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
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

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
     
            servletOutputStream.flush();//출력
             
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
     * 레포트 PDF변환
     * @param fileName
     * @param reportName
     * @param param
     * @param request
     * @return
     */
    public static boolean makeReportPdf(String fileName, String reportName, Map<String, Object> param, HttpServletRequest request) {
		
		try {			
			JasperReport jr = JasperCompileManager.compileReport(request.getServletContext().getRealPath("/report/" + reportName +".jrxml"));
			JasperPrint jp = JasperFillManager.fillReport(jr,  param, DriverManager.getConnection(jsUrl, jsUserNm, jsUserPw));
			
			String sUrl = request.getServletContext().getRealPath("/");
			makeDir(sUrl + "/tmpReport/");
			OutputStream output = null;
			output = new FileOutputStream(new File(sUrl + "/tmpReport/" + fileName));
			
			JasperExportManager.exportReportToPdfStream(jp, output);
			output.flush();
			output.close();
						
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
    
    /**
     * 레포트관련 디렉토리 생성
     * @param path
     */
    public static void makeDir(String path) {

    	//String path = "\\tmpReport\\";
    	File Folder = new File(path);

    	if (!Folder.exists()) Folder.mkdir();
    }
    
	/**
	 * 예약세팅 
	 * - settingType > A : 자동, M : 수동
	 * - day : n일뒤까지 세팅됨  
	 *  
	 * @param settingType
	 * @param day
	 */
	public Boolean bookDetailSetting(String settingType, Integer day) {
		
		Boolean isSuccess = false;
		try {
			
			if (settingType.equals("M")) log.info("예약 수동 세팅");
			else log.info("예약 자동 세팅");
			
			log.debug("[bookDetailSetting] " + new Date());
			
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			DateTimeFormatter dateFm = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			DateTimeFormatter timeFm = DateTimeFormatter.ofPattern("HH:mm");
			 
			// 말일구하기 
			Calendar cal = Calendar.getInstance();	
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
			cal.setTime(new Date());
			
			String sStrtDt = df.format(cal.getTime());	// 세팅 시작일자
			cal.add(Calendar.DATE, day);
			String sEndDt = df.format(cal.getTime());	// 세팅 종료일자
			
			log.info("[bookDetailSetting] 현재일자: {}, 60일 뒤 일자: {}", sStrtDt, sEndDt);
			
			// 회의실조회 
			List<Room> roomList = roomService.selectRoomList(new Room());
			log.info("[bookDetailSetting] 회의실 갯수:" + roomList.size());
			
			for (Room room : roomList) {
				//log.info("[bookDetailSetting] 회의실 명:" + room.getName());
				
				// 지점 운영시간 가져오기 
				Location tempLoc = new Location();
				tempLoc.setLocSeq(room.getLocSeq());
				Location loc = locService.getLoc(tempLoc);

				String strtTm = "";	// 운영시작시간
				String endTm = "";	// 운영종료시간 
				
				Date strtDt = format.parse( sStrtDt );
				Date endDt = format.parse( sEndDt );
			
				long Sec = (endDt.getTime() - strtDt.getTime()) / 1000; // 초
				long Days = Sec / (24*60*60); // 일자수
			
				Calendar cal2 = Calendar.getInstance();
		    
				Date realDate = strtDt; 	// DB에 들어갈 일자
				cal2.setTime(realDate);
		        // 세팅 날짜만큼 반복
				for (int i = 0; i <= Days ; i++) {
			        log.info("[bookDetailSetting] [{}] 세팅일자: {}", i, df.format(cal2.getTime()));
					
					String sRealDate = df.format(cal2.getTime());
					
					// 회의실에 대한 요금 가져오기 (날짜마다 요금이 다를 수 있으므로 날짜 반복문안에 있어야함) 		
					Map<String, Object> feeMap = new HashMap<String, Object>();
					feeMap.put("roomSeq", room.getRoomSeq());
					feeMap.put("bookDt", sRealDate);
					Map<String, Object> fee = feeService.getFeeByBookDt(feeMap);
					// log.info("params: {}, fee: {} ", params, fee);
					
				    strtTm = ((loc.getStrtTm()).toString()).substring(0, 2);
		        	endTm = ((loc.getEndTm()).toString()).substring(0, 2);	
		        	
			        Integer cnt = Integer.parseInt(endTm) - Integer.parseInt(strtTm);
		        	//log.info("{}시 ~ {}시 , {}건 등록 ", strtTm, endTm, cnt+1);
		        
		        	BookDetail bkDetail = new BookDetail();
				
					bkDetail.setBookDt(LocalDate.parse(sRealDate, dateFm));	// 세팅일자 
					bkDetail.setLocSeq(room.getLocSeq());
					bkDetail.setRoomSeq(room.getRoomSeq());					
					
					if ( fee != null ) bkDetail.setFee(Integer.parseInt(fee.get("BASIC_FEE").toString()));
					bkDetail.setOpenYn("O");
					bkDetail.setRegId("system"); 
				
					Integer realTime; 	// DB에 들어갈 시간
					realTime = Integer.parseInt(strtTm);
					// 운영시간만큼 반복, 1시간단위로 세팅 
		        	for (int j = 0; j < cnt ; j++) {	
		        		
		        		// 중복데이터 있으면 제외 
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
		        			//log.info("[bookDetailSetting] 이미 세팅되어있으므로 제외 > 회의실:{}, 날짜:{}, 시간:{}", getBkDetail.getRoomNm(), getBkDetail.getBookDt(), getBkDetail.getStrtTm());
		        			
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
					// 날짜 +1 
			        cal2.add(Calendar.DATE, 1);
				}
			}
			
			isSuccess = true;
			log.info("[bookDetailSetting] 예약세팅 설정 완료");
		} catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
		return isSuccess;
	}

}
