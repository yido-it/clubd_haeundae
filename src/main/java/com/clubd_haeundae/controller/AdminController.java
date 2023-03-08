package com.clubd_haeundae.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.clubd_haeundae.model.CmnCode;
import com.clubd_haeundae.model.Fee;
import com.clubd_haeundae.model.GrapeUser;
import com.clubd_haeundae.model.Image;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.service.BookDetailService;
import com.clubd_haeundae.service.CmnCodeService;
import com.clubd_haeundae.service.FeeService;
import com.clubd_haeundae.service.ImageService;
import com.clubd_haeundae.service.LocationService;
import com.clubd_haeundae.service.RoomService;
import com.clubd_haeundae.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private LocationService locService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private CmnCodeService cmnCodeService;
	
	@Autowired
	private FeeService feeService;	
	
	@Autowired
	private BookDetailService bookDetailService;	
	
    @Value("${file.root}") 
    static String rootDir = "";	
    
    @Value("${file.root}") 
    private void setValue(String fileRoot){
    	rootDir = fileRoot + "/";
    }
    
    private static final int IMG_WIDTH = 265;
	
	/**
	 * 관리자모드 메인
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/main")   
	public String about(Model model, HttpServletRequest request) {

		return "/admin/main";
	}

	/**
	 * 관리자모드 사용자관리
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/userList")
	public String userList(Model model, GrapeUser assetUser, HttpServletRequest request) {
		return "/admin/user/userList";
	}
	
	/**
	 * 관리자모드 사용자관리 팝업
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/popUserInfo")
	public String popUserInfo(Model model, GrapeUser user, HttpServletRequest req) {
		
		if(req.getParameter("userId") != null) {
			user = userService.selectUser(req.getParameter("userId"));
			model.addAttribute("info", user);
		}
		
		CmnCode cmnCode = new CmnCode();
		cmnCode.setUpCd("AAA");
		List<CmnCode> comboList = cmnCodeService.selectList(cmnCode);
		model.addAttribute("authList", comboList);
		
		Location loc = new Location();
		List<Location> locList = locService.selectLocList(loc);
		model.addAttribute("locList", locList);
		
		return "/admin/user/popUser";
	}
	
	/**
	 * 관리자모드 지점관리
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/locList")
	public String locList(Model model, Location loc, HttpServletRequest request) {
		
		//locService.selectLocList(loc);
		//model.addAttribute("locInfo", loc);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("myUserId", auth.getName());
		model.addAttribute("myAuth", auth.getAuthorities());
		
		return "/admin/loc/location";
	}
	
	/**
	 * 관리자모드 지점관리 리스트용
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getLoclist")
	@ResponseBody
	public List<Location> getLoclist(Model model, Location loc) {
		List<Location> locs = locService.selectLocList(loc);

		return locs;
	}
	
	/**
	 * 관리자모드 회의실관리
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/roomList")
	public String roomList(Model model, GrapeUser assetUser, HttpServletRequest request) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("myUserId", auth.getName());
		model.addAttribute("myAuth", auth.getAuthorities());
		
		// 지점 조회 
		Location loc = new Location();
		loc.setAdminId(auth.getName());
		loc.setAdminAuth(auth.getAuthorities().toString());
		
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		return "/admin/room/room";
	}
	
	/**
	 * 지점 신규저장 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/insertLocInfo")
	@ResponseBody
	public Map<String, Object> insertLocInfo(HttpServletRequest req, Location loc){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			locService.insertLoc(req, loc);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "지점정보 등록중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 지점 수정 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateLocInfo")
	@ResponseBody
	public Map<String, Object> updateLocInfo(HttpServletRequest req, Location loc){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			locService.updateLoc(loc);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "지점정보 수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 지점 삭제 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/deleteLocInfo")
	@ResponseBody
	public Map<String, Object> deleteLocInfo(HttpServletRequest req, Location loc){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			locService.deleteLoc(loc);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "지점정보 수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 회의실 삭제 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/deleteRoomInfo")
	@ResponseBody
	public Map<String, Object> deleteRoomInfo(HttpServletRequest req, Room room){
		Map<String, Object> map = new HashMap<String, Object>();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		try {
			roomService.deleteRoom(room);
			
			// 회의실 삭제시 이미지도 use_yn = N 으로 변경
			Image image = new Image();
			image.setRoomSeq(room.getRoomSeq());
			image.setUpdId(auth.getName());
			image.setUseYn("N");
			imageService.updateImage(image);
			// end.
			
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "지점정보 수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 관리자모드 평면도업로드 팝업
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/flrPlnPop")
	public String flrPlnPop(Model model, Location loc, HttpServletRequest req) {
	
		return "/admin/loc/popFlrPln";
	}
	
	/**
	 * 관리자모드 지점사진 업로드 팝업
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/locPop")
	public String locPop(Model model, Location loc, HttpServletRequest req) {
		
		return "/admin/loc/popLoc";
	}
	
	/**
	 * 관리자모드 평면도 업로드
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/flrPlnUpload")
	@ResponseBody
	public String flrPlnUpload(MultipartHttpServletRequest request, Image image, HttpServletRequest req) throws IllegalStateException, IOException {
		Iterator<String> iter = request.getFileNames();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		int s_row = 0;
		
		while(iter.hasNext()) {
			String uploadFileName = iter.next();
			
			MultipartFile mFile = request.getFile(uploadFileName);
			
			String originalFileName = mFile.getOriginalFilename();
			String extName = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());
			
			File convFile  = new File(originalFileName);
			String filePath = convFile.getAbsolutePath();
			
			File copyFile = new File(filePath);
			
			mFile.transferTo(copyFile);
			
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMM");
			Date time = new Date();
			String yearMonth = format1.format(time);
			String path = image.getLocSeq() + "/" ;
			
			//이미지별 폴더 구분
			if(image.getRoomSeq() == 0) {
				if( "Y".equals(image.getFlrPlanYn()) ) {
					path += "flrPlan" + "/" + yearMonth;
				}else {
					path += "loc" + "/" + yearMonth;
				}
			}else {
				path += "room" + "/" + yearMonth;
			}
			String saveFileName = mFile.getOriginalFilename();
			
			if(saveFileName != null && !saveFileName.equals("")) {
				saveFileName = System.currentTimeMillis() + extName;
				
				try {
					uploadObject(path, saveFileName, filePath);
					
					Map<String, Object> map = new HashMap<String, Object>();
					
					try {
						image.setFilePath1(path+"/"+saveFileName);
						image.setFilePath2("thumb/"+path+"/"+saveFileName);
						
						image.setRegId(auth.getName());
						imageService.insertImage(image);
						
		    			map.put("result",  true);
		    			
		    		} catch(Exception e) {
		    			e.printStackTrace();
		    			map.put("result",  false);
		    			map.put("message", "평면도 등록 중 오류가 발생하였습니다.");
		    		}
					
				} catch (IllegalStateException e) {

					e.printStackTrace();

				}
				
				if(copyFile.exists()) copyFile.delete();
			}
		}
		
		return "";
	}
	
	/**
	 * 관리자모드 파일 업로드
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
    public static void uploadObject(String folderName, String objectName, String filePath) throws IOException {
    	String fullPath = null;
		fullPath = folderName + "/" + objectName;
		
		makeDir(folderName);
		log.debug(folderName);
		log.debug(filePath);
		log.debug(fullPath);
		
		writeFile(filePath, fullPath);
		
		String[] tempName = objectName.split("\\.");
		String ext = "."+tempName[1];
		log.debug(ext);
		
		
		if (ext.equals(".png") || ext.equals(".jpg") || ext.equals(".jpeg")) {
			reduceImg(rootDir + folderName + "/", rootDir + "/thumb/" + folderName + "/", ext, objectName);
		}
    }
    
    /**
	 * 파일 생성
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
    private static boolean writeFile(String filePath, String saveFileName) throws IOException{
		boolean result = false;
		//byte[] data = multipartFile.getBytes();
		byte[] data = Files.readAllBytes(new File(filePath).toPath());
		
		FileOutputStream fos = new FileOutputStream(rootDir + saveFileName);
		
		fos.write(data);
		fos.close();
   
		return result;
	}
    
    /**
	 * 폴더 생성
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
    public static void makeDir(String... paths) {

		if(new File(rootDir + paths[paths.length - 1]).exists()){
			return;
		}
		
		for(String path : paths){
			File dirPath = new File(rootDir + path);

			if(!dirPath.exists()){
				dirPath.mkdirs();
			}
		}
	}
    
    /**
	 * * 원본 이미지를 리사이즈 한다. * *
	 * 
	 * @param String imgsrc 원본 이미지 경로
	 * @param String imgdist 대상 경로 *
	 * @param String fileName 파일명 *
	 * @param String suffix 확장자 ( .jpg , .png ) *
	 * @throws IOException
	 */

	public static void reduceImg(String imgsrc, String imgdist, String suffix, String fileName) throws IOException {
		File srcfile = new File(imgsrc + fileName);
		File destFolder = new File(imgdist);
		
		if (!destFolder.exists()) {
			destFolder.mkdirs();
		}
		
		java.awt.Image src = ImageIO.read(srcfile);
		
		float ratio = src.getWidth(null) / IMG_WIDTH;
		
		int newHeight = (int)(src.getHeight(null) / ratio);
		
		BufferedImage resizeImage = new BufferedImage(IMG_WIDTH, newHeight, BufferedImage.TYPE_INT_RGB);
		resizeImage.getGraphics().drawImage(src.getScaledInstance(IMG_WIDTH, newHeight, java.awt.Image.SCALE_SMOOTH), 0, 0, null);

		FileOutputStream out = new FileOutputStream(imgdist + fileName);
		ImageIO.write(resizeImage, suffix.substring(1), out);
		
		out.close();
	}
	
	/**
	 * 관리자모드 이미지 실제파일 삭제
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	public static void deleteObject(String filePath) {
    	File file = new File(rootDir + filePath);
    	
    	if(file.exists()) file.delete(); 
    }
	
	/**
	 * 관리자모드 이미지목록 조회
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getImagelist")
	@ResponseBody
	public List<Image> getImagelist(Model model, Image image) {
		List<Image> imageList = imageService.selectImageList(image);

		return imageList;
	}
	
	/**
	 * 이미지 삭제
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/deleteImage")
	@ResponseBody
	public Map<String, Object> deleteImage(HttpServletRequest req, Image img){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			imageService.deleteImage(img);
			
			//원본 파일과 썸네일 파일을 지운다.
			deleteObject(img.getFilePath1());
			deleteObject(img.getFilePath2());
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "이미지 삭제 중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 이미지 삭제
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/changeImageOrd")
	@ResponseBody
	public Map<String, Object> changeImageOrd(HttpServletRequest req, Image img){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			imageService.changeImageOrd(img);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "이미지 순번 변경 중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 에디터용 이미지
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@PostMapping("/editorImgUpload")
	@ResponseBody
	public String editorImgUpload(HttpServletRequest request, MultipartFile file) throws Exception {
		
		String orgFileNm = file.getOriginalFilename();
		
		String folderName = "/editor/"+LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
		
		String extNm = orgFileNm.substring(orgFileNm.lastIndexOf("."), orgFileNm.length());
		String fileName = System.currentTimeMillis() + extNm;
		
		File convFile  = new File(orgFileNm);
		String filePath = convFile.getAbsolutePath();
		File copyFile = new File(filePath);
		
		file.transferTo(copyFile);
		
		makeDir(folderName);
		String fullPath = folderName + "/" + fileName;
		
		writeFile(filePath, fullPath);

		return "/store" + fullPath;
	}
	
	/**
	 * 에디터용 이미지
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@PostMapping("/editorImgUploadPaste")
	@ResponseBody
	public Map<String, String> editorImgUploadPaste(HttpServletRequest request, MultipartFile upload) throws Exception {
        Map<String, String> map = new HashMap<String, String>();

        String orgFileNm = upload.getOriginalFilename();
		
		String folderName = "/editor/"+LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
		
		String extNm = orgFileNm.substring(orgFileNm.lastIndexOf("."), orgFileNm.length());
		String fileName = System.currentTimeMillis() + extNm;
		
		File convFile  = new File(orgFileNm);
		String filePath = convFile.getAbsolutePath();
		File copyFile = new File(filePath);
		
		upload.transferTo(copyFile);
		
		makeDir(folderName);		
		
		String fullPath = folderName + "/" + fileName;
		
		writeFile(filePath, fullPath);
		
		map.put("url",  "/store" + fullPath);
		map.put("fileName",  fileName);
		map.put("uploaded",  "1");
		return map;
	}
	
	/**
	 * 관리자모드 회의실관리 리스트용
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getRoomList")
	@ResponseBody
	public List<Room> getRoomList(Model model, Room room) {
		List<Room> rooms = roomService.selectRoomList(room);
		
		return rooms;
	}
	
	/**
	 * 관리자모드 공통코드 리스트
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getCmnCodeList")
	@ResponseBody
	public List<CmnCode> getCmnCodeList(Model model, CmnCode cmnCode) {
		List<CmnCode> code = cmnCodeService.selectTabulatorCombo(cmnCode);
		
		return code;
	}
	
	/**
	 * 관리자모드 공통코드명 리스트
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getCmnCodeNmList")
	@ResponseBody
	public List<CmnCode> getCmnCodeNmList(Model model, CmnCode cmnCode) {
		List<CmnCode> code = cmnCodeService.selectTabulatorComboNm(cmnCode);
		
		return code;
	}
	
	/**
	 * 관리자모드 요금관리 리스트용
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getFeelist")
	@ResponseBody
	public List<Fee> getFeelist(Model model, Fee fee) {
		List<Fee> fees = feeService.selectFeeList(fee);

		return fees;
	}
	
	
	/**
	 * 회의실 신규저장 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/insertRoomInfo")
	@ResponseBody
	public Map<String, Object> insertRoomInfo(HttpServletRequest req, Room room){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			roomService.insertRoom(req, room);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "지점정보 등록중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 회의실 수정 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateRoomInfo")
	@ResponseBody
	public Map<String, Object> updateRoomInfo(HttpServletRequest req, Room room){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			roomService.updateRoom(room);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "지점정보 수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	
	/**
	 * 회의실 수정 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getLocNmList")
	@ResponseBody
	public List<Location> getLocNmList(HttpServletRequest req, Location loc){

		return locService.getLocNmList(loc);
	}
	
	/**
	 * 관리자모드 이용요금입력 팝업
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/popFeeInfo")
	public String popFeeInfo(Model model, Fee fee, HttpServletRequest req) {
		
		try {
			if (req.getParameter("feeSeq") != null) {
				Integer feeSeq = Integer.parseInt(req.getParameter("feeSeq").toString());
				
				Fee getFee = new Fee();
				getFee.setFeeSeq(feeSeq);
				getFee = feeService.getFee(getFee);
		
				model.addAttribute("info", getFee);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "/admin/room/popFee";
	}
	
	/**
	 * 회의실 신규저장 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/insertFee")
	@ResponseBody
	public Map<String, Object> insertFee(HttpServletRequest req, Fee fee){
		Map<String, Object> map = new HashMap<String, Object>();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		
		try {
			if (fee.getLocSeq() != null && fee.getRoomSeq() != null && fee.getFeeSeq() != null && fee.getStrtDt() != null && fee.getBasicFee() != null) {
				map.put("result", false);
				map.put("message", "요금 등록중 오류가 발생하였습니다. (파라미터 누락)");
			}
			
			// 선택한 시작일자에서 하루 빼기 
			String strtDt = fee.getStrtDt().toString();
			cal.setTime(format.parse(strtDt));
			cal.add(Calendar.DATE, -1);
			// end.
			
			feeService.insertFee(req, fee, LocalDate.parse(format.format(cal.getTime())));
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "요금 등록중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 관리자 요금 수정
	 * 
	 * @param req
	 * @param fee
	 * @return
	 */
	@RequestMapping("/updateFee")
	@ResponseBody
	@Transactional
	public Map<String, Object> updateFee(HttpServletRequest req, Fee fee){
		Map<String, Object> map = new HashMap<String, Object>();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		try {
			log.info("[updateFee] {}", fee);
			
			if (fee.getLocSeq() != null && fee.getRoomSeq() != null && fee.getFeeSeq() != null && fee.getStrtDt() != null && fee.getBasicFee() != null) {
				map.put("result", false);
				map.put("message", "요금 수정중 오류가 발생하였습니다. (파라미터 누락)");
			}
			
			// fee 테이블 수정 
			fee.setUpdId(auth.getName());
			feeService.updateFee(fee);
			
			// book_detail 테이블 수정 
			map.put("updId", auth.getName());
			map.put("locSeq", fee.getLocSeq());
			map.put("roomSeq", fee.getRoomSeq());
			map.put("fee", fee.getBasicFee());
			map.put("gtBookDt", fee.getStrtDt());
			map.put("bookCdIsNull", "Y");
			bookDetailService.updateBookDetailByMap(map);
			// end.
			
			// book_detail_log insert
			 
			// end.
			
			map.put("result",  true);
		
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "요금 수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 관리자모드 지점사진 업로드 팝업
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/roomPop")
	public String roomPop(Model model, Location loc, HttpServletRequest req) {
		
		return "/admin/room/popRoom";
	}
	
	/**
	 * 이용요금이력이 같은날짜가 있는지 확인 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/selectSameDateFeeCnt")
	@ResponseBody
	public int selectSameDateFeeCnt(Model model, Fee fee) {
		int cntFee = feeService.selectSameDateFeeCnt(fee);

		return cntFee;
	}
	
	/**
	 * 이용요금 같은날 수정
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateSameFee")
	@ResponseBody
	public Map<String, Object> updateSameFee(HttpServletRequest req, Fee fee){
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			feeService.updateSameFee(req, fee);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "요금 등록중 오류가 발생하였습니다.");
		}
		
		return map;
	}
}
