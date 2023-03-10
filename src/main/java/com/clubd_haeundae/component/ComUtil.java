package com.clubd_haeundae.component;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.DriverManager;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clubd_haeundae.model.BookDetail;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.service.BookDetailService;
import com.clubd_haeundae.service.FeeService;
import com.clubd_haeundae.service.LocationService;
import com.clubd_haeundae.service.RoomService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Component
@Slf4j
public class ComUtil {
	@Value("${spring.datasource.url}") 
	static String jsUrl;	
	@Value("${spring.datasource.url}")
	private void setJsUrl(String val) {
		jsUrl = val;
	}
	
	@Value("${spring.datasource.username}") 
	static String jsUserNm;
	@Value("${spring.datasource.username}")
	private void setJsUserNm(String val) {
		jsUserNm = val;
	}
	
    @Value("${spring.datasource.password}") 
    static String jsUserPw;
    @Value("${spring.datasource.password}")
    private void setJsUserPw(String val) {
    	jsUserPw = val;
    }
    
	@Autowired
	RoomService roomService;

	@Autowired
	LocationService locService;
	
	@Autowired
	FeeService feeService;
	
	@Autowired
	BookDetailService bkDetailService;
	
    public static String getFileName(String orgFileName, HttpServletRequest req) throws UnsupportedEncodingException {
    	
    	String header = req.getHeader("User-Agent");
    	String newFileName = "";

    	if (header.contains("MSIE") ||  header.contains("Trident")) {
    		newFileName = URLEncoder.encode(orgFileName,"UTF-8").replaceAll("\\+", "%20");
		} else if (header.contains("Firefox")) {
			newFileName = new String(orgFileName.getBytes("UTF-8"), "ISO-8859-1");
		} else if (header.contains("Opera")) {
			newFileName = new String(orgFileName.getBytes("UTF-8"), "ISO-8859-1");
		} else if (header.contains("Chrome")) {
			newFileName = new String(orgFileName.getBytes("UTF-8"), "ISO-8859-1");
		} else newFileName = orgFileName;    	
    	
    	return newFileName;
    }
    
    @RequestMapping("/fileDownload")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response, String fileName) {

    	String sUrl = request.getServletContext().getRealPath("/");
    	String path =  sUrl + "/tmpReport/" + fileName;
        File file = new File(path);
     
        FileInputStream fileInputStream = null;
        ServletOutputStream servletOutputStream = null;
     
        try{
            String downName = getFileName(fileName,  request);
            response.setHeader("Content-Disposition","attachment;filename=\"" + downName+"\"");             
            response.setContentType("application/octer-stream");
            response.setHeader("Content-Transfer-Encoding", "binary;");
     
            fileInputStream = new FileInputStream(file);
            servletOutputStream = response.getOutputStream();
     
            byte b [] = new byte[1024];
            int data = 0;
     
            while((data=(fileInputStream.read(b, 0, b.length))) != -1){
                servletOutputStream.write(b, 0, data);
            }
     
            servletOutputStream.flush();//??????
             
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            if(servletOutputStream!=null){
                try{
                    servletOutputStream.close();
                }catch (IOException e){
                    e.printStackTrace();
                }
            }
            if(fileInputStream!=null){
                try{
                    fileInputStream.close();
                }catch (IOException e){
                    e.printStackTrace();
                }
            }
        }
    }
    
	/**
	 * ???????????? 
	 * - settingType > A : ??????, M : ??????
	 * - day : n???????????? ?????????  
	 *  
	 * @param settingType
	 * @param day
	 */
	public Boolean bookDetailSetting(String settingType, Integer day) {
		
		Boolean isSuccess = false;
		try {
			
			if (settingType.equals("M")) log.info("?????? ?????? ??????");
			else log.info("?????? ?????? ??????");
			
			log.debug("[bookDetailSetting] " + new Date());
			
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			DateTimeFormatter dateFm = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			DateTimeFormatter timeFm = DateTimeFormatter.ofPattern("HH:mm");
			 
			// ??????????????? 
			Calendar cal = Calendar.getInstance();	
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
			cal.setTime(new Date());
			
			String sStrtDt = df.format(cal.getTime());	// ?????? ????????????
			cal.add(Calendar.DATE, day);
			String sEndDt = df.format(cal.getTime());	// ?????? ????????????
			
			log.info("[bookDetailSetting] ????????????: {}, 60??? ??? ??????: {}", sStrtDt, sEndDt);
			
			// ??????????????? 
			List<Room> roomList = roomService.selectRoomList(new Room());
			log.info("[bookDetailSetting] ????????? ??????:" + roomList.size());
			
			for (Room room : roomList) {
				//log.info("[bookDetailSetting] ????????? ???:" + room.getName());
				
				// ?????? ???????????? ???????????? 
				Location tempLoc = new Location();
				tempLoc.setLocSeq(room.getLocSeq());
				Location loc = locService.getLoc(tempLoc);

				String strtTm = "";	// ??????????????????
				String endTm = "";	// ?????????????????? 
				
				Date strtDt = format.parse( sStrtDt );
				Date endDt = format.parse( sEndDt );
			
				long Sec = (endDt.getTime() - strtDt.getTime()) / 1000; // ???
				long Days = Sec / (24*60*60); // ?????????
			
				Calendar cal2 = Calendar.getInstance();
		    
				Date realDate = strtDt; 	// DB??? ????????? ??????
				cal2.setTime(realDate);
		        // ?????? ???????????? ??????
				for (int i = 0; i <= Days ; i++) {
			        log.info("[bookDetailSetting] [{}] ????????????: {}", i, df.format(cal2.getTime()));
					
					String sRealDate = df.format(cal2.getTime());
					
					// ???????????? ?????? ?????? ???????????? (???????????? ????????? ?????? ??? ???????????? ?????? ??????????????? ????????????) 		
					Map<String, Object> feeMap = new HashMap<String, Object>();
					feeMap.put("roomSeq", room.getRoomSeq());
					feeMap.put("bookDt", sRealDate);
					Map<String, Object> fee = feeService.getFeeByBookDt(feeMap);
					// log.info("params: {}, fee: {} ", params, fee);
					
				    strtTm = ((loc.getStrtTm()).toString()).substring(0, 2);
		        	endTm = ((loc.getEndTm()).toString()).substring(0, 2);	
		        	
			        Integer cnt = Integer.parseInt(endTm) - Integer.parseInt(strtTm);
		        	//log.info("{}??? ~ {}??? , {}??? ?????? ", strtTm, endTm, cnt+1);
		        
		        	BookDetail bkDetail = new BookDetail();
				
					bkDetail.setBookDt(LocalDate.parse(sRealDate, dateFm));	// ???????????? 
					bkDetail.setLocSeq(room.getLocSeq());
					bkDetail.setRoomSeq(room.getRoomSeq());					
					
					if ( fee != null ) bkDetail.setFee(Integer.parseInt(fee.get("BASIC_FEE").toString()));
					bkDetail.setOpenYn("O");
					bkDetail.setRegId("system"); 
				
					Integer realTime; 	// DB??? ????????? ??????
					realTime = Integer.parseInt(strtTm);
					// ?????????????????? ??????, 1??????????????? ?????? 
		        	for (int j = 0; j < cnt ; j++) {	
		        		
		        		// ??????????????? ????????? ?????? 
		        		BookDetail tmpBkDetail = new BookDetail();
		        		tmpBkDetail.setRoomSeq(room.getRoomSeq());
		        		tmpBkDetail.setBookDt(LocalDate.parse(sRealDate, dateFm));
						if ( realTime < 10 ) {
							tmpBkDetail.setStrtTm(LocalTime.parse("0" + realTime + ":00", timeFm));
						} else {
							tmpBkDetail.setStrtTm(LocalTime.parse(realTime + ":00", timeFm));
						}
						
		        		BookDetail getBkDetail = bkDetailService.getBookDetail(tmpBkDetail);
		        		if (getBkDetail != null && getBkDetail.getBookSeq() != null) {
		        			//log.info("[bookDetailSetting] ?????? ???????????????????????? ?????? > ?????????:{}, ??????:{}, ??????:{}", getBkDetail.getRoomNm(), getBkDetail.getBookDt(), getBkDetail.getStrtTm());
		        			
		        			realTime += 1;
							continue;
		        		}
		        		// end.
		        				
		        		int idx = bkDetailService.getBkDetailIdx();
						bkDetail.setBookSeq(idx);
						
						if ( realTime < 10 ) {
							bkDetail.setStrtTm(LocalTime.parse("0" + realTime + ":00", timeFm));
						} else {
							bkDetail.setStrtTm(LocalTime.parse(realTime + ":00", timeFm));
						}
		        		
						if ( (realTime +1) < 10 ) {
							bkDetail.setEndTm(LocalTime.parse("0" + (realTime + 1) + ":00", timeFm));
						} else {
							bkDetail.setEndTm(LocalTime.parse((realTime + 1) + ":00", timeFm));
						}
						
						bkDetailService.insertBookDetail(bkDetail);
		        		realTime += 1;
		        	}
					// ?????? +1 
			        cal2.add(Calendar.DATE, 1);
				}
			}
			
			isSuccess = true;
			log.info("[bookDetailSetting] ???????????? ?????? ??????");
		} catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
		return isSuccess;
	}

}
