package com.clubd_haeundae.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.clubd_haeundae.service.FeeService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/fee")
public class FeeController {

	@Autowired
	private FeeService feeService;

	/**
	 * 예약날짜에 해당하는 요금 가져오기
	 * 
	 * @param model
	 * @param fee
	 * @param req
	 * @param params
	 * @return
	 */
	@RequestMapping("/getFee")
	@ResponseBody
	public Map<String, Object> getFee(Model model, HttpServletRequest req, @RequestParam Map<String, Object> params) {
		log.info("[getFee] params: {}", params);
		Map<String, Object> map = new HashMap<String, Object>();
		String basicFee = "";
		
		try {
				
			if (params.get("strtDt") != null && params.get("endDt") != null && !params.get("strtDt").equals("") && !params.get("endDt").equals("") ) {
				// 시작일자 ~ 종료일자 반복문으로 요금 가져요기 (날짜마다 요금이 상이할 수 있으므로..)
				basicFee = getBasicFee(params);
			} else {
				// 예약날짜가 요금설정 기간에 포함되는 데이터를 가져와야함 
				Map<String, Object> getFee = feeService.getFeeByBookDt(params);
				basicFee = getFee != null ? getFee.get("BASIC_FEE").toString() : "";				
			}
			
			map.put("basicFee", basicFee);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	/**
	 * 시작일자 ~ 종료일자 반복문으로 요금 가져요기 (날짜마다 요금이 상이할 수 있으므로..)
	 * 
	 * @param params
	 * @return
	 */
	public String getBasicFee(@RequestParam Map<String, Object> params) {

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> getFee = new HashMap<String, Object>();
		String basicFee = "";
		
		try {
			// 사용자가 선택한 예약 시작일자~종료일자 
			String strtDt = params.get("strtDt").toString().trim();
			String endDt = params.get("endDt").toString().trim();
			// 사용자가 선택한 시간대 갯수 ( 9시~12시 선택했으면 timeCnt => 4 )
			Integer timeCnt = Integer.parseInt(params.get("timeCnt").toString());
			
			Date bookDt1 = format.parse( strtDt );
			Date bookDt2 = format.parse( endDt );
		
			long Sec = (bookDt2.getTime() - bookDt1.getTime()) / 1000; // 초
			long Days = Sec / (24*60*60); // 일자수
		
			Calendar cal = Calendar.getInstance();
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	        
			Map<String, Object> params2 = new HashMap<String, Object>();
			params2.put("roomSeq", params.get("roomSeq"));
			
			Integer nRealFee = 0;	// [날짜수 * 요금 * 선택한 시간대]를 계산한 금액
			Boolean isExcluded = false; 
			String excludedDate = "";
			// 제외할 날짜가 존재하면 
			if (params.get("excludedDate") != null) {
				isExcluded = true;
				excludedDate = params.get("excludedDate").toString();
			}
			
			Date realBookDt = bookDt1; 	// DB에 들어갈 예약일자
			cal.setTime(realBookDt);
			
			// 선택한 날짜만큼 반복 	      
			for (int i = 0; i <= Days ; i++) {
				Integer nBasicFee = 0;

				log.info("[getBasicFee] 선택한 날짜: {}", df.format(cal.getTime()));
				
				if (isExcluded) {
					// 제외할 날짜가 존재하면, 해당 날짜는 요금 조회하지 않도록  
					if ( excludedDate.contains(",") ) {
						// excludedDate = 2022-08-01,2022-08-02,2022-08-03						
						if (excludedDate.contains(df.format(cal.getTime()))) {
						    cal.add(Calendar.DATE, 1);	// 날짜 +1 
							continue;
						}
					} else {
						// excludedDate = 2022-08-01 
						if (df.format(cal.getTime()).equals(excludedDate)) {
						    cal.add(Calendar.DATE, 1);	// 날짜 +1 
							continue;
						}
					}
				}

				params2.put("bookDt", df.format(cal.getTime()));
				getFee = feeService.getFeeByBookDt(params2);
	
				nBasicFee = getFee != null ? Integer.parseInt(getFee.get("BASIC_FEE").toString()) : 0;
				nRealFee += nBasicFee * timeCnt;
				log.info("[getBasicFee] {} 날짜에 대한 1시간당 금액: {}", df.format(cal.getTime()), nBasicFee.toString());
				
			    cal.add(Calendar.DATE, 1); // 날짜 +1 
			}
	
			basicFee = nRealFee.toString();	
			log.info("[getBasicFee] 총 금액: {}", basicFee);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return basicFee;
	}

}
