package com.clubd_haeundae.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clubd_haeundae.model.CmnCode;
import com.clubd_haeundae.model.Contact;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Tour;
import com.clubd_haeundae.service.CmnCodeService;
import com.clubd_haeundae.service.ContactService;
import com.clubd_haeundae.service.LocationService;
import com.clubd_haeundae.service.TourService;

import lombok.extern.slf4j.Slf4j;

@PropertySources({ @PropertySource("classpath:application.properties") })
@Controller
@Slf4j
@RequestMapping("/")
public class TourController {

	@Autowired
	private LocationService locService;
	
	@Autowired
	private TourService tourService;
	
	@Autowired
	private CmnCodeService cmnCodeService;

	@Autowired
	private ContactService contService;
	
	@Value("${spring.profiles.active}")
	public String active;
	
	/**
	 * 관리자 투어신청리스트화면
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/admin/tourList")  
	public String tourList(Model model, HttpServletRequest req) {

		// 지점 조회 
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		CmnCode cmnCode = new CmnCode();
		cmnCode.setUpCd("300");
		List<CmnCode> codes = cmnCodeService.selectTabulatorCombo(cmnCode);
		model.addAttribute("codes", codes);
		
		return "/admin/tour/tourList";
	}
   
	/**
	 * 관리자 투어신청 정보 변경 
	 * 
	 * @param req
	 * @param book
	 * @return
	 */
	@RequestMapping("/admin/updateTour")
	@ResponseBody
	public Map<String, Object> updateTour(HttpServletRequest req, Tour tour){

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[updateTour] " + tour.toString());
			
			if (tour == null || tour.getTourSeq() == null) {
				map.put("result",  false);
				map.put("message", "오류가 발생하였습니다.");
				return map;
			}
			
			tour.setUpdId(auth.getName());
			tourService.updateTour(tour);
			
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "투어신청 정보 변경중 오류가 발생하였습니다.");
		}
		
		return map;
	}

	/**
	 * 투어신청 상세보기 팝업창
	 * 
	 * @param model
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/admin/popTourDetail")
	public String popTourDetail(Model model, HttpServletRequest req) {

		Tour tour = new Tour();
		
		if(req.getParameter("tourSeq") != null) {
			tour.setTourSeq(Integer.parseInt(req.getParameter("tourSeq").toString()));
			tour = tourService.selectTourInfo(tour);
			model.addAttribute("tour", tour);
		}		
		
		// 지점
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		// 신청상태
		CmnCode cmnCode = new CmnCode();
		cmnCode.setUpCd("300");
		List<CmnCode> reqSttsList = cmnCodeService.selectList(cmnCode);
		model.addAttribute("reqSttsList", reqSttsList);
		
		return "/admin/tour/popTourDetail";
	}
	
	
	/**
	 * 투어신청
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/tour/tourMain")   
	public String tour(Model model, HttpServletRequest request, Integer locSeq) {
		
		// 상단 메뉴에 표출할 지점목록 
		List<Location> locs = locService.selectLocListWithImg(new Location());
		model.addAttribute("locs", locs);
		
		// 하단에 표출할 대표연락처 
		Contact cont = contService.getContact(new Contact());
		model.addAttribute("cont", cont);
		model.addAttribute("menu", "tour");
		model.addAttribute("locSeq",  locSeq);
		
		return "/tour/tourMain";
	}
	
	/**
	 * 투어신청 저장
	 * @param req
	 * @param tour
	 * @return
	 */
	@RequestMapping("/tour/saveRequestTour")
	@ResponseBody
	public Map<String, Object> deleteUser(HttpServletRequest req, Tour tour){

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			tourService.insertTour(tour);

            // 지점 정보 
            Location loc = new Location();
            loc.setLocSeq(tour.getLocSeq());
            loc = locService.getLoc(loc);
            
            // 투어신청 정보 메일 전송 
            if ( loc != null && loc.getEstEmail() != null && !loc.getEstEmail().trim().equals("")) {

    			HtmlEmail email = new HtmlEmail();
    			email.setCharset("UTF-8");
    			email.setHostName("ygw.yido.com");
    			email.setSmtpPort(25);
    			email.setAuthenticator(new DefaultAuthenticator("help@yido.com", "yido#0623"));
    			email.setSocketConnectionTimeout(60000);
    			email.setSocketTimeout(60000);
    			email.setFrom("help@yido.com", "Grape");
    			email.setSubject("[" + loc.getName() + "] 투어신청");
    			
    			if ( active.trim().equals("production") ) {
    				email.addTo(loc.getEstEmail());
    			} else {
        			email.addTo("baeean@yido.com");
    			}
    			
                String html = "<html><body>"; 
                html = html + "<h3>" + loc.getName() +" 지점의 투어신청 정보입니다.</h3>";
                html = html + "<b>희망날짜</b>: " + tour.getTourDt();
                html = html + "<BR><b>희망시간</b>: " + tour.getTourTm();
                html = html + "<BR><b>신청자명</b>: " + tour.getReqNm();
                html = html + "<BR><b>연락처</b>: " + tour.getReqTel();
                html = html + "<BR><BR><b>[요청사항]</b><BR>" + tour.getReqCnts().replace("\r\n", "<BR>");
                html = html + "<BR><BR><a href='//grape.co.kr/admin/tourList'>투어신청 관리 페이지로 이동</a>";
                html = html + "</body></html>";
          
    			//email.setHtmlMsg(html);
    			//email.send();
               
            }
            
			map.put("result",  true);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "투어신청 중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	@RequestMapping("/tour/list")  
	@ResponseBody
	public List<Tour> tourList(Tour tour, @RequestParam Map<String, Object> params) {

		List<Tour> list = new ArrayList<>();
		try {
			if (params.get("searchDt") != null) {
				
				String sStrtDt = (params.get("searchDt")).toString().substring(0, 10);
				String sEndDt = (params.get("searchDt")).toString().substring(13);

				LocalDate strtDt = LocalDate.of(
						Integer.parseInt(sStrtDt.substring(0, 4))
						, Integer.parseInt(sStrtDt.substring(5, 7))
						, Integer.parseInt(sStrtDt.substring(8, 10)));
				
				LocalDate endDt = LocalDate.of(
						Integer.parseInt(sEndDt.substring(0, 4))
						, Integer.parseInt(sEndDt.substring(5, 7))
						, Integer.parseInt(sEndDt.substring(8, 10)));
				
				tour.setSearchStrtDt(strtDt);
				tour.setSearchEndDt(endDt);
			}
			
			list = tourService.selectTourList(tour);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	
}
