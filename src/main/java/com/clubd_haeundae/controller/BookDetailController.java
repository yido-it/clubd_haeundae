package com.clubd_haeundae.controller;
 
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.clubd_haeundae.component.ComUtil;
import com.clubd_haeundae.model.Book;
import com.clubd_haeundae.model.BookDetail;
import com.clubd_haeundae.model.BookDetailLog;
import com.clubd_haeundae.model.BookLog;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.service.BookDetailLogService;
import com.clubd_haeundae.service.BookDetailService;
import com.clubd_haeundae.service.BookLogService;
import com.clubd_haeundae.service.BookService;
import com.clubd_haeundae.service.FeeService;
import com.clubd_haeundae.service.LocationService;
import com.clubd_haeundae.service.RoomService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class BookDetailController {
	
	@Autowired
	BookDetailService bkDetailService;

	@Autowired
	BookDetailLogService bkDetailLogService;
	
	@Autowired
	BookService bookService;
	
	@Autowired
	BookLogService bookLogService;
	
	@Autowired
	LocationService locService;
	
	@Autowired
	RoomService roomService;
	
	@Autowired
	FeeService feeService;
	
	@Autowired
	ComUtil comUtil;


	/**
	 * 관리자 모드 > 예약설정셋팅 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bookSetting")  
	public String detailmain(Model model, HttpServletRequest req) {
		
		// 지점 조회 
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		// 회의실 조회 
		Room room = new Room();
		List<Room> rooms = roomService.selectRoomList(room);
		model.addAttribute("rooms", rooms);
		
		return "/admin/book/bookSetting";
	}
	
	/**
	 * 관리자 모드 > 예약설정 리스트 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bkDetail/list")  
	@ResponseBody
	public List<BookDetail> detailList(BookDetail bookDetail, HttpServletRequest req) {

		log.info("[detailList] " + bookDetail);
		List<BookDetail> list = bkDetailService.selectBookDetail(bookDetail);
		return list;
	}
	
	/**
	 * 관리자 모드 > 예약현황 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bookStatus")  
	public String bookStatus(Model model, HttpServletRequest req) {

		// 지점 조회 
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		return "/admin/book/bookStatus";
	}
	
	/**
	 * 관리자 모드 > 예약현황 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bkDetail/status")  
	@ResponseBody
	public List<BookDetail> detailStatus(@RequestParam Map<String, Object> params, HttpServletRequest req) {

		log.info("[detailStatus] bookDetail : " + params);
		List<BookDetail> list = new ArrayList<>();
		
		try {
			if (params.get("searchBookDt") != null) {
				String strtDt = (params.get("searchBookDt")).toString().substring(0, 10);
				String endDt = (params.get("searchBookDt")).toString().substring(13);
	
				params.put("searchStrtDt", strtDt);
				params.put("searchEndDt", endDt);
			}
			
			list = bkDetailService.selectBookDetailByParam(params);
			log.info("[detailStatus] 조회된 건수 : {}건", list.size());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	/**
	 * 예약설정셋팅 등록/수정 팝업창
	 * 
	 * @param model
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/admin/popBkDetail")
	public String popBookDetail(Model model, HttpServletRequest req) {

		BookDetail bookDetail = new BookDetail();
		
		if(req.getParameter("bookSeq") != null) {
			log.info("[popBookDetail] " + bookDetail.toString());
			
			bookDetail.setBookSeq(Integer.parseInt(req.getParameter("bookSeq").toString()));
			bookDetail = bkDetailService.getBookDetail(bookDetail);

			model.addAttribute("bkDetail", bookDetail);
		}
		
		// 지점
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		// 회의실		
		Room room = new Room();
		if(req.getParameter("bookSeq") != null) {
			room.setLocSeq(bookDetail.getLocSeq());
		}
		List<Room> rooms = roomService.selectRoomList(room);
		model.addAttribute("rooms", rooms);
			
		// 시작시간, 종료시간 select box 
		Map<Integer, String> map = new HashMap<Integer, String>();

		for(int i=0 ; i<24 ; i++) {
			String value = "";
			
			if ( i < 10 ) {
				value = "0" + i + ":00";
			} else {
				value = i + ":00";
			}
			
			map.put(i, value);
		}
		
		model.addAttribute("timeMap", map);
		
		return "/admin/book/popBkDetailForm";
	}
	
	/**
	 * 예약설정 데이터 등록
	 * 
	 * @param req
	 * @param bookDetail
	 * @return
	 */
	@RequestMapping("/admin/insertBookDetail")
	@ResponseBody
	public Map<String, Object> insertBookDetail(HttpServletRequest req, BookDetail bookDetail){

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[insertBookDetail] " + bookDetail.toString());
			
			// 등록전 시간 중복 체크 
			BookDetail chkBookDetail = new BookDetail();
			chkBookDetail.setLocSeq(bookDetail.getLocSeq());
			chkBookDetail.setRoomSeq(bookDetail.getRoomSeq());
			chkBookDetail.setBookDt(bookDetail.getBookDt());
			chkBookDetail.setStrtTm(bookDetail.getStrtTm());
			chkBookDetail.setEndTm(bookDetail.getEndTm());
			List<BookDetail> chkList = bkDetailService.selectBookDetail(chkBookDetail);
			if ( chkList.size() > 0 ) {
				map.put("result", false);
				map.put("message", "시작시간 & 종료시간이 중복되는 데이터가 있습니다.");
				return map;
			}
			
			int idx = bkDetailService.getBkDetailIdx();
			bookDetail.setBookSeq(idx);
			bookDetail.setRegId(auth.getName()); 
			bkDetailService.insertBookDetail(bookDetail);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "등록중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 예약설정 데이터 변경 (단순히 book_detail 데이터만 변경 하는 API) 
	 * 
	 * @param req
	 * @param bookDetail
	 * @return
	 */
	@RequestMapping("/admin/updateBookSetting")
	@ResponseBody
	public Map<String, Object> updateBookSetting(HttpServletRequest req, BookDetail bookDetail){

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[updateBookDetail] " + bookDetail.toString());
			
			if ( req.getParameter("pBookSeq") == null ) {
				map.put("result",  false);
				map.put("message", "수정중 오류가 발생하였습니다. (파라미터 누락)");
			}
			
			if (req.getParameter("updateTime") != null && req.getParameter("updateTime").equals("Y")) {
				// 시작/종료시간 변경했을 경우에만 중복체크
				BookDetail chkBookDetail = new BookDetail();
				chkBookDetail.setLocSeq(bookDetail.getLocSeq());
				chkBookDetail.setRoomSeq(bookDetail.getRoomSeq());
				chkBookDetail.setBookDt(bookDetail.getBookDt());
				chkBookDetail.setStrtTm(bookDetail.getStrtTm());
				chkBookDetail.setEndTm(bookDetail.getEndTm());
				List<BookDetail> chkList = bkDetailService.selectBookDetail(chkBookDetail);
				if ( chkList.size() > 0 ) {
					map.put("result", false);
					map.put("message", "시작시간 & 종료시간이 중복되는 데이터가 있습니다.");
					return map;
				}	
			}
			
			bookDetail.setBookSeq(Integer.parseInt(req.getParameter("pBookSeq").toString()));
			bookDetail.setUpdId(auth.getName()); 
			bkDetailService.updateBookDetail(bookDetail);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}

	/**
	 * 예약설정 데이터 삭제 (단순히 book_detail 데이터만 삭제하는 API) 
	 * 
	 * @param req
	 * @param bookDetail
	 * @return
	 */
	@RequestMapping("/admin/deleteBookSetting")
	@ResponseBody
	public Map<String, Object> deleteBookSetting(HttpServletRequest req, BookDetail bookDetail){

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[deleteBookSetting] bookSeq: " + bookDetail.getBookSeq());
			
			if ( req.getParameter("bookSeq") == null ) {
				map.put("result",  false);
				map.put("message", "오류가 발생하였습니다.");
			}
			
			bkDetailService.deleteBookDetail(bookDetail);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "삭제중 오류가 발생하였습니다.");
		}
		
		return map;
	}

	/**
	 * 예약 데이터 삭제 ( book, book_detail, book_detil_log 모두 변경 및 삭제 )
	 * 
	 * @param req
	 * @param bookDetail
	 * @return
	 */
	@RequestMapping("/admin/deleteBookDetail")
	@ResponseBody
	public Map<String, Object> deleteBookDetail(HttpServletRequest req, BookDetail bkDetail){

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[deleteBookDetail] bookDetail: {}", bkDetail);
			
			if ( bkDetail.getBookSeq() == null || bkDetail.getBookCd() == null ) {
				map.put("result",  false);
				map.put("message", "오류가 발생하였습니다.");
			}
			
			String bookSttsCd = "";
			BookDetail tmpDetail = new BookDetail();
			tmpDetail.setBookCd(bkDetail.getBookCd());
			List<BookDetail> list = bkDetailService.selectBookDetail(tmpDetail);
			if(list.size() == 1) {
				bookSttsCd = "100004";
				
				Book getBook = new Book();
				getBook.setBookCd(list.get(0).getBookCd());
				getBook = bookService.getBook(getBook);
			
				// ┌───────────── 예약 로그 INSERT ─────────────┐
				BookLog bookLog = new BookLog();
				bookLog.setLogSeq(bookLogService.getLogIndex());
				bookLog.setBookCd(list.get(0).getBookCd());
				bookLog.setLocSeq(list.get(0).getLocSeq());
				bookLog.setName(getBook.getName());
				bookLog.setEmail(getBook.getEmail());
				bookLog.setTel(getBook.getTel());
				bookLog.setBookSttsCd("100004");	
				bookLog.setBookAmt(getBook.getBookAmt());
				bookLog.setDcAmt(getBook.getDcAmt());
				bookLog.setPayAmt(getBook.getPayAmt());
				if (!getBook.getReqCnts().equals("")) bookLog.setReqCnts(getBook.getReqCnts());
				bookLog.setBookStrtDt(getBook.getBookStrtDt());
				bookLog.setBookEndDt(getBook.getBookEndDt());
				bookLog.setRegId(auth.getName());
				bookLogService.insertLog(bookLog);
				// └───────────── 예약 로그 INSERT ─────────────┘
				
			}
			
			// ┌─────────── book_detail_log 등록 ───────────┐ 
			BookDetail tmpBkDetail = new BookDetail();
			tmpBkDetail.setBookSeq(bkDetail.getBookSeq());
			BookDetail getBkDetail = bkDetailService.getBookDetail(tmpBkDetail);
			
			BookDetailLog bkLog = new BookDetailLog();
			bkLog.setLogSeq(bkDetailLogService.getBkLogIdx());
			bkLog.setBookDt(getBkDetail.getBookDt());	
			bkLog.setLocSeq(getBkDetail.getLocSeq());
			bkLog.setRoomSeq(getBkDetail.getRoomSeq());
			bkLog.setBookSeq(getBkDetail.getBookSeq());
			bkLog.setStrtTm(getBkDetail.getStrtTm());
			bkLog.setEndTm(getBkDetail.getEndTm());
			bkLog.setBookCd(getBkDetail.getBookCd());
			bkLog.setRoomSttsCd("400002"); 	// 삭제니까 '예약가능'으로 변경
			bkLog.setFee(getBkDetail.getFee());
			bkLog.setBookGroupCd(getBkDetail.getBookGroupCd());
			bkLog.setRegId(auth.getName());
			bkLog.setUseYn("N");		// 삭제니까 사용안함
			
			bkDetailLogService.insertBkDetailLog(bkLog);
			// └─────────── book_detail_log 등록 ───────────┘ 
			
			// ┌─────────── book_detail 업데이트 ───────────┐ 
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("updId", auth.getName());
			params.put("roomSttsCd", "400002");	// 예약가능
			params.put("updBookCdNull", "Y");
			params.put("updBookGroupCdNull", "Y");
			params.put("oriBookCd", bkDetail.getBookCd());
			params.put("bookSeq", bkDetail.getBookSeq());
			bkDetailService.updateBookDetailByMap(params);
			// └─────────── book_detail 업데이트 ───────────┘ 
			
			// ┌─────────── book 금액 변경  ───────────┐ 
			Book tmpBook = new Book();
			tmpBook.setBookCd(bkDetail.getBookCd());
			Book book = bookService.getBook(tmpBook);
			log.info("[deleteBookDetail] book : {}", book);
			log.info("[deleteBookDetail] fee : {}", bkDetail.getFee());
			
			Integer fee	= bkDetail.getFee() != null ? bkDetail.getFee() : 0; // 시간당 금액
			Integer bookAmt = book.getBookAmt() != null ? book.getBookAmt() : 0;
			Integer dcAmt = book.getDcAmt() != null ? book.getDcAmt() : 0;
			Integer payAmt = book.getPayAmt() != null ? book.getPayAmt() : 0;
			
			book.setBookAmt(bookAmt - fee);
			book.setPayAmt(payAmt - fee);
			book.setUpdId(auth.getName());
			log.info("[deleteBookDetail] book : {}", book);
			
			if (!bookSttsCd.equals("")) book.setBookSttsCd("100004");
			
			bookService.updateBook(book);
			// └─────────── book 금액 변경 ───────────┘ 
			
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "삭제중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 예약 데이터 변경 ( book, book_detail, book_detil_log 모두 변경 )
	 * 
	 * @param req
	 * @param bookDetail
	 * @return
	 */
	@RequestMapping("/admin/updateBookDetail/{bookCd}")
	@ResponseBody
	public Map<String, Object> updateBookDetail(HttpServletRequest req, @RequestBody List<Map<String, Object>> params
			, @PathVariable String bookCd){
		
		DateTimeFormatter dateFm = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		DateTimeFormatter timeFm = DateTimeFormatter.ofPattern("HH:mm");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[updateBookDetail] bookCd: {}", bookCd);
			if (bookCd==null || bookCd.equals("")) {
				map.put("result",  false);
				map.put("message", "예약코드 누락");
				return map;
			}
			
			// book 테이블에 update 할 금액 
			Integer updFee = 0;
			
			// 예약그룹코드 
			Integer bkDetailGroupCd = bkDetailService.getBkDetailGroupCd();
			Integer bkLogGroupCd = bkDetailLogService.getBkLogGroupCd();
			
			for (Map<String, Object> param : params) {
				log.info("[updateBookDetail] param: {}", param);
				
				// book_detail_log 추가 
				BookDetailLog delLog = new BookDetailLog();
				delLog.setBookDt(LocalDate.parse(param.get("bookDt").toString(), dateFm));
				delLog.setLocSeq(Integer.parseInt(param.get("locSeq").toString()));
				delLog.setRoomSeq(Integer.parseInt(param.get("roomSeq").toString()));
				delLog.setBookSeq(Integer.parseInt(param.get("bookSeq").toString()));
				delLog.setLogSeq(bkDetailLogService.getBkLogIdx());
				delLog.setStrtTm(LocalTime.parse(param.get("strtTm").toString(), timeFm));
				delLog.setEndTm(LocalTime.parse(param.get("endTm").toString(), timeFm));
				delLog.setBookCd(bookCd);
				delLog.setBookGroupCd(bkLogGroupCd);
				delLog.setRoomSttsCd("400001");	// 예약진행중
				delLog.setFee(Integer.parseInt(param.get("fee").toString()));
				delLog.setRegId(auth.getName());
				delLog.setUseYn("Y");
				//log.info("[updateBookDetail] delLog: {}", delLog);
				bkDetailLogService.insertBkDetailLog(delLog);
				// end.
				
				// book_detail 변경 (where 조회 조건 : 날짜, 시간, 지점코드)
				Map<String, Object> updParam = new HashMap<String, Object>();
				updParam.put("updId", auth.getName());
				updParam.put("roomSttsCd", "400001");	// 예약진행중
				updParam.put("updBookCd", bookCd);
				updParam.put("updBookGroupCd", bkDetailGroupCd);
				updParam.put("updId", auth.getName());
				updParam.put("bookDt", param.get("bookDt"));	// where 조건 
				updParam.put("strtTm", param.get("strtTm"));	// where 조건 
				updParam.put("roomSeq", param.get("roomSeq"));	// where 조건 
				bkDetailService.updateBookDetailByMap(updParam);
				// end.
				
				updFee += param.get("fee") != null ? Integer.parseInt(param.get("fee").toString()) : 0;					
			}
		
			// book 금액 변경 
			Book tmpBook = new Book();
			tmpBook.setBookCd(bookCd);
			Book book = bookService.getBook(tmpBook);
			log.info("[updateBookDetail] book : {}", book);
			log.info("[updateBookDetail] fee : {}", updFee);
			
			Integer bookAmt = book.getBookAmt() != null ? book.getBookAmt() : 0;
			Integer dcAmt = book.getDcAmt() != null ? book.getDcAmt() : 0;
			Integer payAmt = book.getPayAmt() != null ? book.getPayAmt() : 0;
			
			book.setBookAmt(bookAmt + updFee);
			book.setPayAmt(payAmt + updFee);
			book.setUpdId(auth.getName());
			log.info("[updateBookDetail] book : {}", book);
			
			bookService.updateBook(book);
			// end.
			
			// ┌───────────── 예약 로그 INSERT ─────────────┐
			BookLog bookLog = new BookLog();
			bookLog.setLogSeq(bookLogService.getLogIndex());
			bookLog.setBookCd(bookCd);
			bookLog.setLocSeq(book.getLocSeq());
			bookLog.setName(book.getName());
			bookLog.setEmail(book.getEmail());
			bookLog.setTel(book.getTel());
			bookLog.setBookSttsCd(book.getBookSttsCd());	
			bookLog.setBookAmt(book.getBookAmt());
			bookLog.setDcAmt(book.getDcAmt());
			bookLog.setPayAmt(book.getPayAmt());
			bookLog.setReqCnts(book.getReqCnts());
			bookLog.setBookStrtDt(book.getBookStrtDt());
			bookLog.setBookEndDt(book.getBookEndDt());
			bookLog.setRegId(auth.getName());
			bookLogService.insertLog(bookLog);
			// └───────────── 예약 로그 INSERT ─────────────┘
			
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "처리중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * 예약설정 > 전체오픈
	 * 
	 * @param req
	 * @param bookDetail
	 * @return
	 */
	@RequestMapping("/admin/bookDetail/openAll")
	@ResponseBody
	public Map<String, Object> openAll(HttpServletRequest req, BookDetail bookDetail){

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[openAll] " + bookDetail.toString());

			bookDetail.setUpdId(auth.getName()); 
			bkDetailService.updateOpenAll(bookDetail);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}

	/**
	 * 예약셋팅 팝업창
	 * 
	 * @param model
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/admin/popBkSetting")
	public String popBkSetting(Model model, HttpServletRequest req) {

		BookDetail bookDetail = new BookDetail();

		// 지점
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		// 회의실		
		Room room = new Room();
		if(req.getParameter("bookSeq") != null) {
			room.setLocSeq(bookDetail.getLocSeq());
		}
		List<Room> rooms = roomService.selectRoomList(room);
		model.addAttribute("rooms", rooms);
		
		return "/admin/book/popBkSetting";
	}
	
	/**
	 * 예약 수동 세팅
	 * 
	 * @param req
	 * @param bookDetail
	 * @return
	 */
	@RequestMapping("/admin/bkSetting")
	@ResponseBody
	public Map<String, Object> bkSetting(HttpServletRequest req){

		Map<String, Object> map = new HashMap<String, Object>();
		DateTimeFormatter dateFm = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		Map<String, Object> params = new HashMap<String, Object>();
		
		try {
			if ( req.getParameter("settingType") == null || req.getParameter("bookDt") == null || req.getParameter("locSeq") == null || req.getParameter("roomSeq") == null ) {
				map.put("result",  false);
				map.put("message", "오류가 발생하였습니다.");
				return map;
			}
	
			String bookDt = req.getParameter("bookDt");
			Integer locSeq = Integer.parseInt(req.getParameter("locSeq").toString());
			String sRoomSeq = req.getParameter("roomSeq") != null && !req.getParameter("roomSeq").toString().equals("") ? req.getParameter("roomSeq").toString() : "0";
			Integer roomSeq = Integer.parseInt(sRoomSeq);
			String copyBookDt = req.getParameter("copyBookDt").toString();
			Integer settingType = Integer.parseInt(req.getParameter("settingType").toString());
			
			params.put("bookDt", bookDt);
			params.put("locSeq", locSeq);
			params.put("roomSeq", roomSeq);
			params.put("settingType", settingType);
			params.put("copyBookDt", copyBookDt);
			
			Boolean result = false;
			if (settingType == 1) {
				// 기본설정
				result = bkBasicSetting(params);
			} else if (settingType == 2) {
				// 복사 
				BookDetail bkDetail = new BookDetail();
				bkDetail.setBookDt(LocalDate.parse(copyBookDt, dateFm));
				bkDetail.setLocSeq(locSeq);
				bkDetail.setRoomSeq(roomSeq);
				List<BookDetail> list = bkDetailService.selectBookDetail(bkDetail);
				log.info("[bkSetting] 복사할 데이터 조회 > bookDt:{}, logSeq:{}, roomSeq:{}", bkDetail.getBookDt(), bkDetail.getLocSeq(), bkDetail.getRoomSeq());
				log.info("[bkSetting] 조회 결과 건수 > {}건", list.size());
				
				if (list.size() <= 0) {
					map.put("result",  false);
					map.put("message", "복사할 데이터가 없습니다.");
					return map;
				}
				result = bkCopySetting(params, list);
			}
			
			if (result) {
				map.put("result",  true);
			} else {
				map.put("result",  false);
				map.put("message", "설정중 오류가 발생하였습니다-1");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "설정중 오류가 발생하였습니다-2");
		}
		
		return map;
	}
	
	/**
	 * 예약세팅  '기본설정' 으로 세팅
	 * 
	 * 1. 지점에 대한 운영시간 가져요기
	 * 2. 회의실에 대한 요금 가져오기 (예약날짜에 해당되는 요금 가져와야함)
	 * 3. 주말/평일 구분 
	 * 
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public Boolean bkBasicSetting(Map<String, Object> params) throws Exception{
		Boolean returnValue = false;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		try { 
			// bookDt: 2022-07-25 ~ 2022-07-29, locSeq: 1, roomSeq: 1, copyBookDt: 2022-07-27, settingType: 1
			log.info("[bkBasicSetting] bookDt: {}, locSeq: {}, roomSeq: {}, copyBookDt: {}, settingType: {}"
					, params.get("bookDt"), params.get("locSeq"), params.get("roomSeq"), params.get("copyBookDt"), params.get("settingType"));
			
			String bookDt = params.get("bookDt").toString();
			Integer locSeq = Integer.parseInt(params.get("locSeq").toString());
			Integer roomSeq = Integer.parseInt(params.get("roomSeq").toString());
	
			String strtTm = "";	// 운영시작시간
			String endTm = "";	// 운영종료시간 
	
			DateTimeFormatter timeFm = DateTimeFormatter.ofPattern("HH:mm");
			
			// 지점 운영시간 가져오기 
			Location tempLoc = new Location();
			tempLoc.setLocSeq(locSeq);
			Location loc = locService.getLoc(tempLoc);
			
			// 선택된 회의실 없는 경우 회의실 리스트 조회하기
			List<Room> roomList = new ArrayList<Room>();
			if ( roomSeq == 0) {
				Room room = new Room();
				room.setLocSeq(locSeq);
				roomList = roomService.selectRoomList(room);
			} else {
				Room room = new Room();
				room.setLocSeq(locSeq);
				room.setRoomSeq(roomSeq);
				roomList.add(room);
			}
			// end.
			
			// 사용자가 설정한 예약 시작일자~종료일자  
			String sBookDt1 = bookDt.substring(0, 10);
			String sBookDt2 = bookDt.substring(13);

			LocalDate bookDt1 = LocalDate.of(
					Integer.parseInt(sBookDt1.substring(0, 4))
					, Integer.parseInt(sBookDt1.substring(5, 7))
					, Integer.parseInt(sBookDt1.substring(8, 10)));
			
			LocalDate bookDt2 = LocalDate.of(
					Integer.parseInt(sBookDt2.substring(0, 4))
					, Integer.parseInt(sBookDt2.substring(5, 7))
					, Integer.parseInt(sBookDt2.substring(8, 10)));

			long Days = ChronoUnit.DAYS.between(bookDt1, bookDt2); // 날짜 차이 구하기 
			
	        LocalDate realBookDt = bookDt1; 	// DB에 들어갈 예약일자

	        // 선택한 날짜만큼 반복
			for (int i = 0; i <= Days ; i++) {

				for (Room room : roomList) {
					// 회의실에 대한 요금 가져오기  (날짜마다 요금이 다를 수 있으므로 날짜 반복문안에 있어야함)
					Map<String, Object> feeMap = new HashMap<String, Object>();
					feeMap.put("roomSeq", room.getRoomSeq());
					feeMap.put("bookDt", realBookDt.toString());
					Map<String, Object> fee = feeService.getFeeByBookDt(feeMap);
					
			        log.info("[bkBasicSetting] [{}] 예약일자: {}", i, realBookDt);
	
			        strtTm =((loc.getStrtTm()).toString()).substring(0, 2);
		        	endTm =((loc.getEndTm()).toString()).substring(0, 2);	
		        	
			        Integer cnt = Integer.parseInt(endTm) - Integer.parseInt(strtTm);
		        
		        	BookDetail bkDetail = new BookDetail();
				
					bkDetail.setBookDt(realBookDt);	// 예약일자 
					bkDetail.setLocSeq(locSeq);
					bkDetail.setRoomSeq(room.getRoomSeq());
					
					// 삭제 후 등록 ( bookDt, locSeq, roomSeq 까지만 필요함 )
					bkDetailService.deleteBookDetail(bkDetail);
					
					if ( fee != null ) bkDetail.setFee(Integer.parseInt(fee.get("BASIC_FEE").toString()));
					bkDetail.setOpenYn("O");
					bkDetail.setRegId(auth.getName()); 
				
					Integer realStrtTm; 	// DB에 들어갈 시작시간
					realStrtTm = Integer.parseInt(strtTm);
					// 운영시간만큼 반복, 1시간단위로 세팅 
		        	for (int j = 0; j < cnt ; j++) {	
		        		int idx = bkDetailService.getBkDetailIdx();
						bkDetail.setBookSeq(idx);
						
						if ( realStrtTm < 10 ) {
							bkDetail.setStrtTm(LocalTime.parse("0" + realStrtTm + ":00", timeFm));
						} else {
							bkDetail.setStrtTm(LocalTime.parse(realStrtTm + ":00", timeFm));
						}
		        		
						if ( (realStrtTm +1) < 10 ) {
							bkDetail.setEndTm(LocalTime.parse("0" + (realStrtTm + 1) + ":00", timeFm));
						} else {
							bkDetail.setEndTm(LocalTime.parse((realStrtTm + 1) + ":00", timeFm));
						}
						
						bkDetailService.insertBookDetail(bkDetail);
		        		realStrtTm += 1;
		        	}
		        	
				}
				
		        // 예약 등록 후 날짜 +1 한다 
				realBookDt = realBookDt.plusDays(1);
			}
			returnValue = true;
			
		} catch(Exception e) {
			e.printStackTrace();
			returnValue = false;
		}
		
		return returnValue;
	}
	
	/**
	 * 예약세팅  '복사' 로 세팅
	 * 
	 * 1. 지점/회의실/기준날짜로 데이터 조회 후, 날짜만 변경해서 세팅하기	 
	 * 
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public Boolean bkCopySetting(Map<String, Object> params, List<BookDetail> list) throws Exception{
		Boolean returnValue = false;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		try { 
			// bookDt: 2022-07-25 ~ 2022-07-29, locSeq: 1, roomSeq: 1
			log.info("[bkCopySetting] bookDt: {}, locSeq: {}, roomSeq: {}", params.get("bookDt"), params.get("locSeq"), params.get("roomSeq"));
			
			String bookDt = params.get("bookDt").toString();
			Integer locSeq = Integer.parseInt(params.get("locSeq").toString());
			Integer roomSeq = Integer.parseInt(params.get("roomSeq").toString());
					
			if ( list.size() > 0 ) {
				// 사용자가 설정한 예약 시작일자~종료일자  
				String sBookDt1 = bookDt.substring(0, 10);
				String sBookDt2 = bookDt.substring(13);

				LocalDate bookDt1 = LocalDate.of(
						Integer.parseInt(sBookDt1.substring(0, 4))
						, Integer.parseInt(sBookDt1.substring(5, 7))
						, Integer.parseInt(sBookDt1.substring(8, 10)));
				
				LocalDate bookDt2 = LocalDate.of(
						Integer.parseInt(sBookDt2.substring(0, 4))
						, Integer.parseInt(sBookDt2.substring(5, 7))
						, Integer.parseInt(sBookDt2.substring(8, 10)));

				long Days = ChronoUnit.DAYS.between(bookDt1, bookDt2); // 날짜 차이 구하기 
				
		        LocalDate realBookDt = bookDt1; 	// DB에 들어갈 예약일자

		        BookDetail bkDetail = new BookDetail();
				
				bkDetail.setLocSeq(locSeq);
				bkDetail.setRoomSeq(roomSeq);
				
				// 선택한 날짜만큼 반복 	      
				for (int i = 0; i <= Days ; i++) {
					
			        log.info("[bkCopySetting] [{}] 예약일자: {}, 복사건수: {}건", i, realBookDt, list.size());
			        
					bkDetail.setBookDt(realBookDt);	// 예약일자 
					
					// 삭제 후 등록 ( bookDt, locSeq, roomSeq 까지만 필요함 )
					bkDetailService.deleteBookDetail(bkDetail);
					
					// 복사할 데이터만큼 반복
					for (BookDetail bk : list) {					
		        		int idx = bkDetailService.getBkDetailIdx();
						bkDetail.setBookSeq(idx);
						bkDetail.setFee(bk.getFee());
						bkDetail.setOpenYn("O");
						bkDetail.setRegId(auth.getName()); 
						bkDetail.setStrtTm(bk.getStrtTm());
						bkDetail.setEndTm(bk.getEndTm());
				
						bkDetailService.insertBookDetail(bkDetail);			      	
					}
					// 예약 등록 후 날짜 +1 한다 
					realBookDt = realBookDt.plusDays(1);			    		
				}
			} 
			returnValue = true;
			
		} catch(Exception e) {
			e.printStackTrace();
			returnValue = false;
		}
		
		return returnValue;	
	}

	/**
	 * 사용자 예약페이지
	 * (예약설정 데이터 조회) 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/bookTimeTable")  
	@ResponseBody
	public Map<String, Object> bookTimeTable(HttpServletRequest req) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			if ( req.getParameter("bookDt") == null ) {
				map.put("result",  false);
				map.put("message", "파라미터 확인");
				return map;
			}

			log.info("[bookTimeTable] bookDt: {}, roomSeq: {}", req.getParameter("bookDt"), req.getParameter("roomSeq"));
			
			String bookDt = req.getParameter("bookDt").toString();
			String strtDt = bookDt.substring(0, 10);
			String endDt = bookDt.substring(13);
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("strtDt", strtDt);
			params.put("endDt", endDt);
			params.put("roomSeq", req.getParameter("roomSeq"));
			
			List<BookDetail> list = bkDetailService.bookTimeTable(params);
			log.info("[bookTimeTable] 조회된 건수: {}", list.size());
			map.put("list",  list);		
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}	
	

	/**
	 * 선택한 시간대로 예약 불가능한 시간이 있는지 체크 
	 * 	1. DB 조회해서 예약진행중 or 마감된 시간대가 있는지 
	 *  2. 예약 오픈 안된 날이 있는지
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/bookNotAvailableTime")  
	@ResponseBody
	public Map<String, Object> bookNotAvailableTime(HttpServletRequest req) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DateTimeFormatter timeFm = DateTimeFormatter.ofPattern("HH:mm");
		DateTimeFormatter dateFm = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		try {
			if ( req.getParameter("strtDt") == null || req.getParameter("endDt") == null 
					|| req.getParameter("strtTm") == null || req.getParameter("endTm") == null ) {
				map.put("result",  false);
				map.put("message", "파라미터 확인");
				return map;
			}

			log.info("[bookNotAvailableTime] strtDt: {}, endDt: {}, strtTm: {}, endTm: {}"
					, req.getParameter("strtDt"), req.getParameter("endDt"), req.getParameter("strtTm"), req.getParameter("endTm"));

			String pRoomSeq = req.getParameter("roomSeq");
			String pStrtDt = req.getParameter("strtDt");
			String pEndDt = req.getParameter("endDt");
			String pStrtTm = req.getParameter("strtTm");
			String pEndTm = req.getParameter("endTm");
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("roomSeq", pRoomSeq);
			params.put("strtDt", pStrtDt);
			params.put("endDt", pEndDt);
			params.put("strtTm", pStrtTm);
			params.put("endTm", pEndTm);
			
			// 예약진행중 or 마감된 시간대가 있는지 
			List<BookDetail> list = bkDetailService.bookNotAvailableTime(params);
			log.info("[bookNotAvailableTime] 조회된 건수: {}", list.size());
			
			if (list.size() > 0) {	
				map.put("bookNotAvailableTimeList",  list);		
			}
			
			// 오픈 안된 날이 있는지
			Date bookDt1 = format.parse( pStrtDt );
			Date bookDt2 = format.parse( pEndDt );
		
			long Sec = (bookDt2.getTime() - bookDt1.getTime()) / 1000; // 초
			long Days = Sec / (24*60*60); // 일자수
		
			Calendar cal = Calendar.getInstance();
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	        
			Date realBookDt = bookDt1; 	
	        cal.setTime(realBookDt);
        				
	        //List<Map<String, Object>> bkList = new ArrayList<Map<String, Object>>();
	        List<BookDetail> bkList = new ArrayList<BookDetail>();
			// 선택한 날짜만큼 반복 	      
			for (int i = 0; i <= Days ; i++) {
				
				Integer strtPos = pStrtTm.indexOf(":");
				Integer endPos = pStrtTm.indexOf(":");
				
				Integer cnt = Integer.parseInt(pEndTm.substring(0, endPos)) - Integer.parseInt(pStrtTm.substring(0, strtPos));

				Integer realStrtTm; 	
				realStrtTm = Integer.parseInt(pStrtTm.substring(0, strtPos));
				for (int j = 0; j <= cnt ; j++) {
					// Map<String, Object> bk = new HashMap<String, Object>();
					BookDetail bk = new BookDetail();
			        
					bk.setRoomSeq(Integer.parseInt(pRoomSeq));
					bk.setBookDt(LocalDate.parse(df.format(cal.getTime()), dateFm));
					
					if ( realStrtTm < 10 ) {
						bk.setStrtTm(LocalTime.parse("0" + realStrtTm + ":00", timeFm));
					} else {
						bk.setStrtTm(LocalTime.parse(realStrtTm + ":00", timeFm));
					}
					
					bk.setOpenYn("O");

					BookDetail tmpBk = bkDetailService.getBookDetail(bk);
					if (tmpBk == null) {
						bk.setSettingYn("X");
						log.info("[bookNotAvailableTime] 오픈되지 않았거나, 데이터가 존재하지 않음 > roomSeq: {} bookDt: {}, strtTm: {}"
								, bk.getRoomSeq(), bk.getBookDt(), bk.getStrtTm());
						bkList.add(bk);
					}
					
					realStrtTm += 1;
				}
				cal.add(Calendar.DATE, 1);
			}
			// log.info("[bookNotAvailableTime] bkList: {}", bkList.toString());
			
			if (bkList.size() > 0) {	
				map.put("bookNotSettingList",  bkList);		
			}
			// end.
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}	
	
	/**
	 * 예약 취소 ( book, book_detail, book_detil_log 모두 변경 )
	 * 
	 * @param req
	 * @param bookCd
	 * @return
	 */
	@RequestMapping("/bookCancel/{bookCd}")
	@ResponseBody
	public Map<String, Object> bookCancel(HttpServletRequest req, @PathVariable String bookCd){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[bookCancel] bookCd: {}", bookCd);
			
			if (bookCd == null || bookCd.equals("")) {
				map.put("result",  false);
				map.put("message", "예약코드 누락");
				return map;
			}
			
			// ┌─────────── book_detail_log 등록 ───────────┐ 
			BookDetail tmpBkDetail = new BookDetail();
			tmpBkDetail.setBookCd(bookCd);
			List<BookDetail> bkList = bkDetailService.selectBookDetail(tmpBkDetail);

			log.info("[bookCancel] bkList size : {}", bkList.size());
			for (BookDetail bk : bkList) {
				BookDetailLog bkLog = new BookDetailLog();
				bkLog.setLogSeq(bkDetailLogService.getBkLogIdx());
				bkLog.setBookDt(bk.getBookDt());	
				bkLog.setLocSeq(bk.getLocSeq());
				bkLog.setRoomSeq(bk.getRoomSeq());
				bkLog.setBookSeq(bk.getBookSeq());
				bkLog.setStrtTm(bk.getStrtTm());
				bkLog.setEndTm(bk.getEndTm());
				bkLog.setBookCd(bookCd);
				bkLog.setRoomSttsCd("400002");	// 취소니까 '예약가능'으로 변경
				bkLog.setFee(bk.getFee());
				bkLog.setBookGroupCd(bk.getBookGroupCd());
				bkLog.setUseYn("N");						// 취소니까 사용안함
				
				bkDetailLogService.insertBkDetailLog(bkLog);
			}
			// └─────────── book_detail_log 등록 ───────────┘ 
			
			// ┌─────────── book 업데이트 ───────────┐ 
			Book tmpBook = new Book();
			tmpBook.setBookCd(bookCd);
			Book book = bookService.getBook(tmpBook);
			log.info("[bookCancel] book : {}", book);
			
			book.setBookSttsCd("100004"); // 예약취소신청	
			
			bookService.updateBook(book);
			// └─────────── book 업데이트 ───────────┘ 

			// ┌───────────── 예약 로그 INSERT ─────────────┐
			BookLog bookLog = new BookLog();
			bookLog.setLogSeq(bookLogService.getLogIndex());
			bookLog.setBookCd(bookCd);
			bookLog.setLocSeq(book.getLocSeq());
			bookLog.setName(book.getName());
			bookLog.setEmail(book.getEmail());
			bookLog.setTel(book.getTel());
			bookLog.setBookSttsCd("100004");	// 예약취소신청
			bookLog.setBookAmt(book.getBookAmt());
			bookLog.setDcAmt(book.getDcAmt());
			bookLog.setPayAmt(book.getPayAmt());
			bookLog.setReqCnts(book.getReqCnts());
			bookLog.setBookStrtDt(book.getBookStrtDt());
			bookLog.setBookEndDt(book.getBookEndDt());
			
			bookLogService.insertLog(bookLog);
			// └───────────── 예약 로그 INSERT ─────────────┘
			
			// ┌─────────── book_detail 업데이트 ───────────┐ 
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("roomSttsCd", "400002"); 		// 예약가능		
			param.put("updBookCdNull", "Y"); 		
			param.put("updBookGroupCdNull", "Y"); 		
			param.put("oriBookCd", bookCd); 		
			
			bkDetailService.updateBookDetailByMap(param);
			// └─────────── book_detail 업데이트 ───────────┘ 

			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "처리중 오류가 발생하였습니다.");
		}
		
		return map;
	}	
	
	/**
	 * 예약 수동 세팅
	 *  
	 * 파라미터 > day : n일뒤까지 세팅됨  
	 */
	@RequestMapping("/bookManualSetting/{day}")  
	@ResponseBody
	public Boolean bookManualSetting(@PathVariable Integer day) {
		return comUtil.bookDetailSetting("M", day);
	}
	
	
	/**
	 * 예약내역 상세보기
	 * 
	 * @param model
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/popBookDetail/{bookCd}/{groupCd}")
	public String popBookDetail(Model model, HttpServletRequest req, @PathVariable String bookCd, @PathVariable Integer groupCd) {

		log.info("[popBookDetail] bookCd: {}, groupCd: {}", bookCd, groupCd);
		
		try {
			Book book = new Book();
			book.setBookCd(bookCd);
			book = bookService.getBook(book);
			
			if (!book.getBookSttsCd().equals("100004")) {
				BookDetail bookDetail = new BookDetail();
				bookDetail.setBookCd(bookCd);
				bookDetail.setBookGroupCd(groupCd);
				List<BookDetail> list = bkDetailService.selectBookDetail(bookDetail);
				log.info("[popBookDetail] list size : {}", list.size());
				model.addAttribute("list", list);
			} else {
				// 100004 -> 예약취소 
				BookDetailLog bookDetailLog = new BookDetailLog();
				bookDetailLog.setBookCd(bookCd);
				bookDetailLog.setBookGroupCd(groupCd);
				List<BookDetailLog> list = bkDetailLogService.selectBookDetailLog(bookDetailLog);
				log.info("[popBookDetail] log list size : {}", list.size());
				model.addAttribute("list", list);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
		return "/book/popBookDetail";
	}
	
} 	