package com.clubd_haeundae.controller;
 
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.clubd_haeundae.model.BookTemp;
import com.clubd_haeundae.model.CmnCode;
import com.clubd_haeundae.model.Contact;
import com.clubd_haeundae.model.Fee;
import com.clubd_haeundae.model.Image;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.service.BookDetailLogService;
import com.clubd_haeundae.service.BookDetailService;
import com.clubd_haeundae.service.BookLogService;
import com.clubd_haeundae.service.BookService;
import com.clubd_haeundae.service.BookTempService;
import com.clubd_haeundae.service.CmnCodeService;
import com.clubd_haeundae.service.ContactService;
import com.clubd_haeundae.service.FeeService;
import com.clubd_haeundae.service.ImageService;
import com.clubd_haeundae.service.LocationService;
import com.clubd_haeundae.service.RoomService;
import lombok.extern.slf4j.Slf4j;

@PropertySources({ @PropertySource("classpath:application.properties") })
@Controller
@Slf4j
@RequestMapping("/")
public class BookController {
	
	@Autowired
	private LocationService locService;
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private FeeService feeService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private BookLogService bookLogService;
	
	@Autowired
	private BookDetailService bkDetailService;
	
	@Autowired
	private BookDetailLogService bkDetailLogService;
	
	@Autowired
	private BookTempService bkTempService;
	
	@Autowired
	private CmnCodeService codeService;
	
	@Autowired
	private ImageService imageService;

	@Autowired
	private ContactService contService;
	
	@Value("${spring.profiles.active}")
	public String active;
	
	/**
	 * 관리자 모드 > 예약리스트 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bookMain")  
	public String adminBookMain(Model model, HttpServletRequest req) {
		
		// 지점 조회 
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		return "/admin/book/bookMain";
	}
	
	/**
	 * 관리자 모드 > 예약리스트 조회
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/book/list")  
	@ResponseBody
	public List<Book> adminBookList(Model model, HttpServletRequest req, @RequestParam Map<String, Object> params) {
		
		log.info("[adminBookList] params: {}", params);
		Map<String, Object> map = new HashMap<String, Object>();
		List<Book> bookList = new ArrayList<>();
		try {
			if (params.get("bookDt") != null) {
				String strtDt = (params.get("bookDt")).toString().substring(0, 10);
				String endDt = (params.get("bookDt")).toString().substring(13);
	
				map.put("strtDt", strtDt);
				map.put("endDt", endDt);
			}
			
			if (params.get("bookCd") != null) {
				map.put("bookCd", params.get("bookCd").toString());
			}
			map.put("locSeq", params.get("locSeq"));
			
			bookList = bookService.selectBookList(map);
			// log.info("[adminBookList] 조회된 건수 : {}건", bookList.size());
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return bookList;
	}


	/**
	 * 관리자 모드 > 예약 이력 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bookLog")  
	public String bookLog(Model model, HttpServletRequest req) {

		// 지점 조회 
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		// 회의실 조회 
		Room room = new Room();
		List<Room> rooms = roomService.selectRoomList(room);
		model.addAttribute("rooms", rooms);
		
		return "/admin/book/bookLog";
	}
	
	/**
	 * 관리자 모드 > 예약로그 조회
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bookLog/list")  
	@ResponseBody
	public List<BookLog> adminBookLogList(Model model, HttpServletRequest req, @RequestParam Map<String, Object> params) {
		
		log.info("[adminBookLogList] params: {}", params);
		Map<String, Object> map = new HashMap<String, Object>();
		List<BookLog> bookLogList = new ArrayList<>();
		try {
			
			if (params.get("bookDt") != null) {
				String strtDt = (params.get("bookDt")).toString().substring(0, 10);
				String endDt = (params.get("bookDt")).toString().substring(13);
	
				map.put("strtDt", strtDt);
				map.put("endDt", endDt);
				map.put("locSeq", params.get("locSeq"));
			}
			
			bookLogList = bookLogService.selectBookLogList(map);
			log.info("[adminBookLogList] 조회된 건수 : {}건", bookLogList.size());
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return bookLogList;
	}
	
	/**
	 * 관리자 모드 > 예약 조회
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/book")  
	@ResponseBody
	public Book getBook(Book pBook, HttpServletRequest req) {
		
		log.info("[getBook] bookCd: {}", pBook.getBookCd());

		Book book = new Book();
		if ( pBook.getBookCd() == null || pBook.getBookCd().equals("") ) {
			return book;
		}
		book = bookService.getBook(pBook);
		log.info("[getBook]book: {}", book);
		
		return book;
	}
	
	/**
	 * 관리자 모드 > 예약 정보  
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/book/detail")  
	public String adminBookDetail(Model model, HttpServletRequest req, @RequestParam Map<String, Object> params) {
		
		try {
			log.info("[adminBookDetail] 예약코드: {}", params.get("bookCd").toString());
		
			// 예약상태 코드 
			CmnCode cmnCode = new CmnCode();
			cmnCode.setUpCd("100");
			List<CmnCode> roomSttsCodes = codeService.selectList(cmnCode);
			model.addAttribute("roomSttsCodes", roomSttsCodes);
			
			// 예약 메인 
			Book tempBook = new Book();
			tempBook.setBookCd(params.get("bookCd").toString());
			Book book = bookService.getBook(tempBook);
			model.addAttribute("book", book);
			log.info("[adminBookDetail] book: {}", book);
			
			// 예약 상세 
			BookDetail bkDetail = new BookDetail();
			bkDetail.setBookCd(params.get("bookCd").toString());
			List<BookDetail> list = bkDetailService.selectBookDetail(bkDetail);
			model.addAttribute("totalCnt", list.size());
			//log.info("[adminBookDetail] list size: {}", list.size());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "/admin/book/bookDetail";
	}
	
	/**
	 * 관리자 모드 > 예약정보 > 추가 팝업창 
	 * 
	 * @param model
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/admin/popInsertBook")
	public String popInsertBook(Model model, HttpServletRequest req) {

		//log.info("[popInsertBook] locSeq: {}", req.getParameter("locSeq"));

		try {
			// 예약상태 코드 
			CmnCode cmnCode = new CmnCode();
			cmnCode.setUpCd("400");
			List<CmnCode> roomSttsCodes = codeService.selectList(cmnCode);
			model.addAttribute("roomSttsCodes", roomSttsCodes);

			// 지점
			Location loc = new Location();
			List<Location> locs = locService.selectLocList(loc);
			model.addAttribute("locs", locs);
			
			if (req.getParameter("bookCd") != null && req.getParameter("locSeq") != null 
					&& !req.getParameter("bookCd").equals("") && !req.getParameter("locSeq").equals("")) {
				
				model.addAttribute("locSeq", req.getParameter("locSeq"));
				model.addAttribute("bookCd", req.getParameter("bookCd"));
				
				// 파라미터로 받은 지점코드에 대한 회의실을 조회한다 
				Room room = new Room();
				room.setLocSeq(Integer.parseInt(req.getParameter("locSeq").toString()));
				List<Room> rooms = roomService.selectRoomList(room);
				model.addAttribute("rooms", rooms);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "/admin/book/popInsertBook";
	}

	
	/**
	 * 예약 데이터 변경
	 * 
	 * @param req
	 * @param book
	 * @return
	 */
	@RequestMapping("/admin/updateBook")
	@ResponseBody
	public Map<String, Object> updateBook(HttpServletRequest req, Book book){

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[updateBook] " + book.toString());
			
			if (book.getBookCd() == null || book.getBookCd().equals("")) {
				map.put("result",  false);
				map.put("message", "오류가 발생하였습니다.");
				return map;
			}
			
			// 총금액 - 할인금액 = 결제금액 
			Integer nBookAmt = book.getBookAmt() == null || book.getBookAmt() == 0 ? 0 : book.getBookAmt();
			Integer nDcAmt = book.getDcAmt() == null || book.getDcAmt() == 0 ? 0 : book.getDcAmt();
			
			book.setPayAmt(nBookAmt - nDcAmt); 
			
			// ┌─────────── book_detail_log 등록 ───────────┐ 
			BookDetail tmpBkDetail = new BookDetail();
			tmpBkDetail.setBookCd(book.getBookCd());
			List<BookDetail> bkList = bkDetailService.selectBookDetail(tmpBkDetail);

			log.info("[bookCancel] bkList size : {}", bkList.size());
			for (BookDetail bk : bkList) {
				log.info("[bookCancel] bk : {}", bk);
				BookDetailLog bkLog = new BookDetailLog();
				bkLog.setLogSeq(bkDetailLogService.getBkLogIdx());
				bkLog.setBookDt(bk.getBookDt());	
				bkLog.setLocSeq(bk.getLocSeq());
				bkLog.setRoomSeq(bk.getRoomSeq());
				bkLog.setBookSeq(bk.getBookSeq());
				bkLog.setStrtTm(bk.getStrtTm());
				bkLog.setEndTm(bk.getEndTm());
				bkLog.setBookCd(book.getBookCd());
				bkLog.setBookGroupCd(bk.getBookGroupCd());

				// 예약상태 '예약취소신청'으로 변경할 경우
				if (book.getBookSttsCd().equals("100004")) {
					bkLog.setRoomSttsCd("400002");	// 예약가능
					bkLog.setUseYn("N");			
				}
				
				// 예약상태 '예약확정' 또는 '결제완료' 로 변경할 경우
				if (book.getBookSttsCd().equals("100002") || book.getBookSttsCd().equals("100003")) {
					bkLog.setRoomSttsCd("400003");	// 예약마감
					bkLog.setUseYn("Y");			
				}
				bkLog.setRegId(auth.getName());
				bkLog.setFee(bk.getFee());
				
				bkDetailLogService.insertBkDetailLog(bkLog);
			}
			// └─────────── book_detail_log 등록 ───────────┘ 
			
			// ┌─────────── book 업데이트 ───────────┐ 
			// 예약상태 '예약취소신청'으로 변경할 경우
			if (book.getBookSttsCd().equals("100004")) {
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("updId", auth.getName());
				params.put("updBookCdNull", "Y");
				params.put("oriBookCd", book.getBookCd());
				params.put("roomSttsCd", "400002");		// 400002 = 예약가능
				bkDetailService.updateBookDetailByMap(params);
			}
			
			// 예약상태 '예약확정' 또는 '결제완료' 로 변경할 경우
			if (book.getBookSttsCd().equals("100002") || book.getBookSttsCd().equals("100003")) {
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("updId", auth.getName());
				params.put("oriBookCd", book.getBookCd());
				params.put("roomSttsCd", "400003");
				bkDetailService.updateBookDetailByMap(params);
			}
			
			book.setUpdId(auth.getName()); 
			bookService.updateBook(book);
			// └─────────── book 업데이트 ───────────┘ 

			// ┌───────────── 예약 로그 INSERT ─────────────┐
			BookLog bookLog = new BookLog();
			bookLog.setLogSeq(bookLogService.getLogIndex());
			bookLog.setBookCd(book.getBookCd());
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
			map.put("message", "수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}

	/**
	 * 예약 데이터 삭제
	 * 
	 * @param req
	 * @param book
	 * @return

	@RequestMapping("/admin/deleteBook")
	@ResponseBody
	public Map<String, Object> deleteBook(HttpServletRequest req, Book book){

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info("[deleteBook] bookCd: " + book.getBookCd());
			
			if ( req.getParameter("bookCd") == null ) {
				map.put("result",  false);
				map.put("message", "오류가 발생하였습니다.");
			}
			
			// 예약상세 데이터 삭제시..
			
			//
			
			bookService.deleteBook(book);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "삭제중 오류가 발생하였습니다.");
		}
		
		return map;
	}	 */
	
	@RequestMapping("/getBook")  
	@ResponseBody
	public Map<String, Object> getBook(HttpServletRequest req, Book pBook) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			if (pBook.getBookCd() == null || pBook.getBookCd().equals("")) {
				map.put("result",  false);
				map.put("message", "파라미터 확인");
				return map;
			}
			
			Book book = bookService.getBook(pBook); 
			map.put("book",  book);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	} 
	
	/**
	 * 예약 1단계 (회의실/날짜/시간 선택)
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/book/bookMain/{locId}/{roomId}")
	public String bookMain(Model model, HttpServletRequest request, @PathVariable Integer locId, @PathVariable Integer roomId) {
		try {
			log.info("[bookMain] locSeq: {}, roomId: {}", locId, roomId);
	
			if (locId != null) {
					
				// 상단 메뉴에 표출할 지점목록 
				List<Location> locs = locService.selectLocListWithImg(new Location());
				model.addAttribute("locs", locs);
				
				// 하단에 표출할 대표연락처 
				Contact cont = contService.getContact(new Contact());
				model.addAttribute("cont", cont);
				
				// 예약페이지에 표출하기 위한 지점 정보 
				Location tempLoc = new Location();
				tempLoc.setLocSeq(locId);
				Location loc = locService.getLoc(tempLoc);
				model.addAttribute("loc", loc);
		
				// 가장 마지막 예약 설정 날짜 가져오기
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("locSeq", locId);
				Map<String, Object> lastDt = bkDetailService.getMaxBookDt(params);
				log.info("lastDt > " + lastDt);
				if (lastDt != null && lastDt.get("LAST_BOOK_DT") != null) {
					model.addAttribute("lastBookDt", lastDt.get("LAST_BOOK_DT").toString());
				} 
				// 회의실 목록
				Room tmpRoom = new Room();
				tmpRoom.setLocSeq(locId);
				List<Room> roomList = roomService.selectRoomList(tmpRoom);
				model.addAttribute("roomList", roomList);
				
				// 요금표
				Fee tempFee = new Fee();
				tempFee.setLocSeq(locId);
				List<Fee> feeList = feeService.feeTableList(tempFee);
				model.addAttribute("feeList", feeList);
				
				// 지점 이미지
				Map<String, Object> locMap = new HashMap<String, Object>();
				locMap.put("locSeq", locId);
				locMap.put("getLocYn", "Y");
				locMap.put("flrPlanYn", "N");				
				List<Image> locImgList = imageService.imgListByMap(locMap);
				model.addAttribute("locImgList", locImgList);
				//log.info("locImgList > " + locImgList);
				
				// 회의실 이미지
				Map<String, Object> roomMap = new HashMap<String, Object>();
				roomMap.put("locSeq", locId);
				roomMap.put("getRoomYn", "Y");		
				List<Image> roomImgList = imageService.imgListByMap(roomMap);
				model.addAttribute("roomImgList", roomImgList);
				//log.info("roomImgList > " + roomImgList);
				
				// 평면도
				Image tmpImg2 = new Image();
				tmpImg2.setLocSeq(locId);
				tmpImg2.setFlrPlanYn("Y");
				List<Image> flrPlanList = imageService.selectImageList(tmpImg2);
				if ( flrPlanList.size() > 0 ) model.addAttribute("flrPlan", flrPlanList.get(0));
				
				model.addAttribute("menu", "book");
				model.addAttribute("roomId", roomId);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}		
		return "/book/bookMain";
	}
	
	/**
	 * [예약] 사용자가 담아둔 예약 정보를 임시테이블에 넣기 (2단계 페이지(정보입력)로 이동하기 위한 처리) 
	 * 
	 * @param user
	 * @return
	*/
	@RequestMapping("/book/{bookCd}/{locSeq}")  
	@ResponseBody
	public Map<String, Object> book2(HttpServletRequest req, @RequestBody List<Map<String, Object>> params
			, @PathVariable String bookCd, @PathVariable Integer locSeq) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			if (bookCd == null || bookCd.equals("") || locSeq == null) {
				map.put("result",  false);
				map.put("message", "파라미터 확인");
				return map;
			}
			
			log.info("[book2] locSeq: {}, bookCd: {}", locSeq, bookCd);

			// 예약 진행중 or 마감된 예약이 있는지 체크 
			if (chkBookClosed(params) == true) {
				map.put("result",  false);
				map.put("message", "예약진행중 이거나 마감된 예약이 존재합니다.");
				return map;
			}
			// end. 
			
			// 임시 테이블(book_temp)에 저장하기
			for (Map<String, Object> param : params) {
				log.info("[book2] param: {}", param);
		
				BookTemp bkTemp = new BookTemp();
				bkTemp.setSeq(bkTempService.getBookTempIndex());
				bkTemp.setBookCd(bookCd);
				bkTemp.setRoomSeq(Integer.parseInt(param.get("roomSeq").toString())); 
				bkTemp.setBookDt(param.get("bookDt").toString());
				bkTemp.setStrtTm(param.get("strtTm").toString());
				bkTemp.setEndTm(param.get("endTm").toString());
				if (param.get("excludedDate") != null) bkTemp.setExcldDt(param.get("excludedDate").toString());
				bkTemp.setBookAmt(Integer.parseInt(param.get("bookAmt").toString()));
				bkTemp.setPrevCnts(param.get("prevContent").toString());
				bkTempService.insertBookTemp(bkTemp);
			}
			
			map.put("locSeq",  locSeq);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	} 

	/**
	 * 예약 2단계 (정보입력) 페이지로 이동 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/entBook/{bookCd}/{locSeq}")
	public String entBook(Model model, HttpServletRequest req
			, @PathVariable String bookCd, @PathVariable Integer locSeq) {
			
		try {
			// 상단 메뉴에 표출할 지점목록 
			List<Location> locs = locService.selectLocListWithImg(new Location());
			model.addAttribute("locs", locs);
			
			// 하단에 표출할 대표연락처 
			Contact cont = contService.getContact(new Contact());
			model.addAttribute("cont", cont);
			// 지점 담당자 정보 
			Location loc = new Location();
			loc.setLocSeq(locSeq);
			loc = locService.getLoc(loc);
			model.addAttribute("loc", loc);
			
			model.addAttribute("menu", "book2");
			
			if (!bookCd.equals("") && locSeq != null) {
				model.addAttribute("bookCd", bookCd);
				
				// 예약 임시 테이블 조회
				BookTemp bkTemp = new BookTemp();
				bkTemp.setBookCd(bookCd);
				List<BookTemp> list = bkTempService.selectBookTemp(bkTemp);
				model.addAttribute("list", list);
				model.addAttribute("listSize", list.size());
	
				Map<String, Object> getTotalAmt = new HashMap<String, Object>();
				getTotalAmt = bkTempService.getTotalAmt(bkTemp);
				log.info("[entBook] totalAmt:" + getTotalAmt.get("TOTAL_AMT"));
				model.addAttribute("totalAmt", getTotalAmt.get("TOTAL_AMT"));
				
				model.addAttribute("locSeq", locSeq);
			}		
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return "/book/book2";
	}
	
	/**
	 * 예약 3단계 (예약 처리)
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/makeBook/{locSeq}")
	@ResponseBody
	public Map<String, Object> makeBook(Model model, HttpServletRequest req, Book book, @PathVariable Integer locSeq) {

		Map<String, Object> map = new HashMap<String, Object>();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DateTimeFormatter timeFm = DateTimeFormatter.ofPattern("HH:mm");
		DateTimeFormatter dateFm = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		try {
			if ( req.getParameter("bookTempCd") == null || req.getParameter("bookTempCd").equals("") ) {
				map.put("result",  false);
				map.put("message", "파라미터 확인");
				return map;
			}
			log.info("[makeBook] locSeq: {}, bookTempCd: {}, book: {}", locSeq, req.getParameter("bookTempCd"), book);

            // 지점 정보 
            Location loc = new Location();
            loc.setLocSeq(locSeq);
            loc = locService.getLoc(loc);
              
			// insert 할 테이블 -> book, book_detail, book_detail_log 
			// delete 할 테이블 -> book_temp 
			// bookTempCd 로 예약 임시 테이블 조회 후, 예약 테이블에 insert 하기 .. 
			BookTemp bkTemp = new BookTemp();
			String bookTempCd = req.getParameter("bookTempCd").toString();
			bkTemp.setBookCd(bookTempCd);
			List<BookTemp> list = bkTempService.selectBookTemp(bkTemp);
			
			if (list.size() <= 0) {
				map.put("result",  false);
				map.put("message", "처리중 오류 발생 (error code: 1)");
				return map;
			}
			
			List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
			for (BookTemp bk : list) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("bookDt", bk.getBookDt());
				param.put("roomSeq", bk.getRoomSeq());
				param.put("strtTm", bk.getStrtTm());
				param.put("endTm", bk.getEndTm());
				param.put("excludedDate", bk.getExcldDt());
				maps.add(param);
			}
			
			// 예약 진행중 or 마감된 예약이 있는지 체크 
			if (chkBookClosed(maps) == true) {
				map.put("result",  false);
				map.put("message", "예약진행중 이거나 마감된 예약이 존재합니다.");
				return map;
			}
			// end. 
			
			// 예약코드 생성 (년월일 + 6자리순번)
			Integer bookIdx = bookService.getBookIndex() + 1;
			String bookCd = bookTempCd.substring(5, 11) + String.format("%06d",bookIdx);
			// end.
			
			Integer totalAmt = 0;
			String mailContent = ""; // 이메일 전송시 사용될 변수
			for (BookTemp bk : list) {
				
				log.info("[makeBook] 예약정보 -> " + bk);

				// 회의실 번호로 지점 조회 
				Room room = new Room();
				room.setRoomSeq(bk.getRoomSeq());
				room = roomService.getRoom(room);
				// end.
				
				totalAmt += bk.getBookAmt();
				
				Map<String, Object> fee = new HashMap<String, Object>();
				fee.put("roomSeq", bk.getRoomSeq());

				// 예약그룹코드 획득 
				//Integer logGroupCd = bkDetailLogService.getBkLogGroupCd();
				Integer bkGroupCd = bkDetailService.getBkDetailGroupCd();
				log.info("예약그룹코드 > ", bkGroupCd);
				
				String strtDt = bk.getBookDt().substring(0,10);
				String endDt = bk.getBookDt().substring(13);
				String strtTm = ((bk.getStrtTm()).toString()).substring(0, 2);	// 예약시작시간
				String endTm = ((bk.getEndTm()).toString()).substring(0, 2);	// 예약종료시간 
				Integer cnt = Integer.parseInt(endTm) - Integer.parseInt(strtTm);
				log.info("[makeBook] 선택일자:{}~{}, 선택시간:{}~{}, cnt:{}", strtDt, endDt, strtTm, endTm, cnt);

				if (strtDt.equals(endDt)) {
					// 시작일자, 종료일자 같으면 (당일예약)		
					
					// ┌─────────── 날짜에 대한 요금 가져오기 ───────────┐ 
					fee.put("bookDt", strtDt);
					Map<String, Object> getFee = feeService.getFeeByBookDt(fee);
					Integer nBasicFee = getFee != null ? Integer.parseInt(getFee.get("BASIC_FEE").toString()) : 0;
					// └─────────── 날짜에 대한 요금 가져오기 ───────────┘ 
					
					Integer realStrtTm; 	
					realStrtTm = Integer.parseInt(strtTm);
					
					// ┌─────────── 선택한 시간만큼 반복 ───────────┐
					for (int j = 0; j <= cnt ; j++) {	

						// book_detail 예약진행중 or 마감 체크하기 
						// --
						// end.
						
						// ┌─────────── book_detail 업데이트 ───────────┐ 
						BookDetail tmpDetail = new BookDetail();
						tmpDetail.setRoomSeq(bk.getRoomSeq());			// book_detail 회의실코드 
						tmpDetail.setBookDt(LocalDate.parse(strtDt, dateFm));	// book_detail 예약날짜  
						
						if ( realStrtTm < 10 ) {
							tmpDetail.setStrtTm(LocalTime.parse("0" + realStrtTm + ":00", timeFm));
						} else {
							tmpDetail.setStrtTm(LocalTime.parse(realStrtTm + ":00", timeFm));
						}
						log.info("[makeBook] tmpDetail {}", tmpDetail);
						tmpDetail = bkDetailService.getBookDetail(tmpDetail);
						log.info("[makeBook] 예약날짜 {} / 시간 {} / 금액 {}", tmpDetail.getBookDt(), tmpDetail.getStrtTm(), tmpDetail.getFee());
						
						// 예약코드, 예약상태, 금액 변경
						String bookSttsCd = "400001";
						tmpDetail.setBookCd(bookCd);
						tmpDetail.setRoomSttsCd(bookSttsCd);		// book_detail 예약상태 (예약진행중) 
						tmpDetail.setFee(nBasicFee);				
						tmpDetail.setBookGroupCd(bkGroupCd);
						bkDetailService.updateBookDetail(tmpDetail);
						// end.
						// └─────────── book_detail 업데이트 ───────────┘ 

						// ┌─────────── book_detail_log 등록 ───────────┐ 
						BookDetailLog bkLog = new BookDetailLog();
						bkLog.setLogSeq(bkDetailLogService.getBkLogIdx());
						bkLog.setBookDt(LocalDate.parse(strtDt, dateFm));	
						bkLog.setLocSeq(locSeq);
						bkLog.setRoomSeq(bk.getRoomSeq());
						bkLog.setBookSeq(tmpDetail.getBookSeq());
						bkLog.setStrtTm(tmpDetail.getStrtTm());
						bkLog.setEndTm(tmpDetail.getEndTm());
						bkLog.setBookCd(bookCd);
						bkLog.setRoomSttsCd(bookSttsCd);
						bkLog.setFee(nBasicFee);
						bkLog.setBookGroupCd(bkGroupCd);
						bkLog.setUseYn("Y");
						
						bkDetailLogService.insertBkDetailLog(bkLog);
						// └─────────── book_detail_log 등록 ───────────┘ 
						realStrtTm += 1;
					}
					// └─────────── 선택한 시간만큼 반복 ───────────┘ 
				} else {
					// 시작일자, 종료일자 다르면 (여러날 예약)
					Calendar cal = Calendar.getInstance();
			        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				
			        Date Dt1 = format.parse( strtDt );
					Date Dt2 = format.parse( endDt );
				
					long Sec = (Dt2.getTime() - Dt1.getTime()) / 1000; // 초
					long Days = Sec / (24*60*60); // 일자수
				
					Date realBookDt = Dt1; 	
			        cal.setTime(realBookDt);
			        // 선택한 날짜만큼 반복
					for (int i = 0; i <= Days ; i++) {
						
						String sRealDt = df.format(cal.getTime());
						log.info("[makeBook] [{}] 예약날짜: {}", i, sRealDt);
					      
						// 제외할날짜 ....
						if (bk.getExcldDt() != null && bk.getExcldDt().contains(sRealDt)) {
							log.info("[makeBook] ------> {} 해당날짜 예약에서 제외함", sRealDt);
							cal.add(Calendar.DATE, 1);	// 날짜 +1 
							continue;
						}
						// end .
											
						// ┌─────────── 날짜에 대한 요금 가져오기 ───────────┐ 
						fee.put("bookDt", sRealDt);
						Map<String, Object> getFee = feeService.getFeeByBookDt(fee);
						Integer nBasicFee = getFee != null ? Integer.parseInt(getFee.get("BASIC_FEE").toString()) : 0;
						// └─────────── 날짜에 대한 요금 가져오기 ───────────┘ 
						
						Integer realStrtTm; 	
						realStrtTm = Integer.parseInt(strtTm);
						
						// ┌─────────── 선택한 시간만큼 반복  ───────────┐
						for (int j = 0; j <= cnt ; j++) {	

							// book_detail 예약진행중 or 마감 체크하기 
							// --
							// end.
							
							// ┌─────────── book_detail 업데이트───────────┐ 
							BookDetail tmpDetail = new BookDetail();
							tmpDetail.setRoomSeq(bk.getRoomSeq());			// book_detail 회의실코드 
							tmpDetail.setBookDt(LocalDate.parse(sRealDt, dateFm));	// book_detail 예약날짜  
							
							if ( realStrtTm < 10 ) {
								tmpDetail.setStrtTm(LocalTime.parse("0" + realStrtTm + ":00", timeFm));
							} else {
								tmpDetail.setStrtTm(LocalTime.parse(realStrtTm + ":00", timeFm));
							}
							tmpDetail = bkDetailService.getBookDetail(tmpDetail);
							log.info("[makeBook] 예약날짜 {} / 시간 {} / 금액 {}", tmpDetail.getBookDt(), tmpDetail.getStrtTm(), tmpDetail.getFee());
							
							// 예약코드, 예약상태, 금액 변경
							String bookSttsCd = "400001";
							tmpDetail.setBookCd(bookCd);
							tmpDetail.setRoomSttsCd(bookSttsCd);		// book_detail 예약상태 (예약진행중) 
							tmpDetail.setFee(nBasicFee);				
							tmpDetail.setBookGroupCd(bkGroupCd);			
							bkDetailService.updateBookDetail(tmpDetail);
							// end.
							// └─────────── book_detail 업데이트 ───────────┘ 
							
							// ┌─────────── book_detail_log 등록 ───────────┐ 
							BookDetailLog bkLog = new BookDetailLog();
							bkLog.setLogSeq(bkDetailLogService.getBkLogIdx());
							bkLog.setBookDt(LocalDate.parse(sRealDt, dateFm));	
							bkLog.setLocSeq(room.getLocSeq());
							bkLog.setRoomSeq(bk.getRoomSeq());
							bkLog.setBookSeq(tmpDetail.getBookSeq());
							bkLog.setStrtTm(tmpDetail.getStrtTm());
							bkLog.setEndTm(tmpDetail.getEndTm());
							bkLog.setBookCd(bookCd);
							bkLog.setRoomSttsCd(bookSttsCd);
							bkLog.setFee(nBasicFee);
							bkLog.setBookGroupCd(bkGroupCd);
							bkLog.setUseYn("Y");
							
							bkDetailLogService.insertBkDetailLog(bkLog);
							// └─────────── book_detail_log 등록 ───────────┘ 
							
							realStrtTm += 1;  // 시간 +1 
						}
						// └─────────── 선택한 시간만큼 반복 ───────────┘ 	
						
						 
						cal.add(Calendar.DATE, 1);	// 날짜 +1 
					}
				}		
				
				mailContent += bk.getPrevCnts() + "<BR>";
			}
					
			String name = book.getName() != null && !book.getName().equals("") ? book.getName().trim() : ""; 				// 이름
			String email = book.getEmail() != null && !book.getEmail().equals("") ? book.getEmail().trim() : ""; 			// 이메일
			String tel = book.getTel() != null && !book.getTel().equals("") ? book.getTel().trim() : ""; 					// 연락처 
			String reqCnts = book.getReqCnts() != null && !book.getReqCnts().equals("") ? book.getReqCnts() : ""; 	// 요청사항 

			Book regBook = new Book();
			// ┌───────────── 1개의 예약에 대한 가장빠른예약시작일자,가장늦은종료일자 조회 ─────────────┐
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("bookCd", bookCd);
			log.info("[makeBook] selBook > params {}", params);
			Map<String, Object> selBook = bkDetailService.getBookDtByBookCd(params);
			log.info("[makeBook] selBook: {}", selBook);
			
			regBook.setBookStrtDt(LocalDate.parse(selBook.get("BOOK_STRT_DT").toString(),dateFm));
			regBook.setBookEndDt(LocalDate.parse(selBook.get("BOOK_END_DT").toString(),dateFm));
			// └───────────── 1개의 예약에 대한 가장빠른예약시작일자,가장늦은종료일자 조회  ─────────────┘
			
			// ┌───────────── 예약 INSERT ─────────────┐
			regBook.setBookCd(bookCd);
			regBook.setLocSeq(locSeq);
			regBook.setName(name);
			regBook.setEmail(email);
			regBook.setTel(tel);
			regBook.setBookSttsCd("100001");	// 예약상태 > 100001: 예약신청
			regBook.setBookAmt(totalAmt);
			regBook.setDcAmt(0);
			regBook.setPayAmt(totalAmt);
			regBook.setReqCnts(reqCnts);
			
			bookService.insertBook(regBook);
			log.info("[makeBook] regBook: {}", regBook);
			// └───────────── 예약 INSERT ─────────────┘

			// ┌───────────── 예약 로그 INSERT ─────────────┐
			BookLog bookLog = new BookLog();
			bookLog.setLogSeq(bookLogService.getLogIndex());
			bookLog.setBookCd(bookCd);
			bookLog.setLocSeq(locSeq);
			bookLog.setName(name);
			bookLog.setEmail(email);
			bookLog.setTel(tel);
			bookLog.setBookSttsCd("100001");	// 예약상태 > 100001: 예약신청
			bookLog.setBookAmt(totalAmt);
			bookLog.setDcAmt(0);
			bookLog.setPayAmt(totalAmt);
			bookLog.setReqCnts(reqCnts);
			bookLog.setBookStrtDt(LocalDate.parse(selBook.get("BOOK_STRT_DT").toString(),dateFm));
			bookLog.setBookEndDt(LocalDate.parse(selBook.get("BOOK_END_DT").toString(),dateFm));
			
			bookLogService.insertLog(bookLog);
			// └───────────── 예약 로그 INSERT ─────────────┘
			
			// ┌───────────── 임시 테이블 (book_temp) 삭제  ─────────────┐
			BookTemp deleteBkTemp = new BookTemp();
			deleteBkTemp.setBookCd(bookTempCd);
			bkTempService.deleteBookTemp(deleteBkTemp);
			// └───────────── 임시 테이블 (book_temp) 삭제  ─────────────┘
			
			// ┌───────────── 예약정보 메일 전송  ─────────────┐ 
            if ( loc != null && loc.getEstEmail() != null && !loc.getEstEmail().trim().equals("")) {

    			HtmlEmail sendEmail = new HtmlEmail();
    			sendEmail.setCharset("UTF-8");
    			sendEmail.setHostName("ygw.yido.com");
    			sendEmail.setSmtpPort(25);
    			sendEmail.setAuthenticator(new DefaultAuthenticator("help@yido.com", "yido#0623"));
    			sendEmail.setSocketConnectionTimeout(60000);
    			sendEmail.setSocketTimeout(60000);
    			sendEmail.setFrom("help@yido.com", "Grape");
    			sendEmail.setSubject("[" + loc.getName() + "] 예약정보");
    		
    			if ( active.trim().equals("production") ) {
    				sendEmail.addTo(loc.getEstEmail());
    			} else {
    				sendEmail.addTo("baeean@yido.com");
    			}
    			
                String html = "<html><body>"; 
                html = html + "<h3>" + loc.getName() +" 지점의 예약 정보입니다.</h3>";
                html = html + "<b>예약자성함</b>: " + book.getName();
                html = html + "<BR><b>이메일</b>: " + book.getEmail();
                html = html + "<BR><b>연락처</b>: " + book.getTel();
                html = html + "<BR><BR><b>[요청사항]</b><BR>" + book.getReqCnts().replace("\r\n", "<BR>");
                html = html + "<BR><BR><b>[예약정보]</b><BR>" + mailContent;
                html = html + "<BR><a href='//grape.co.kr/admin/bookMain'>예약관리 페이지로 이동</a>";
                html = html + "</body></html>";
          
                sendEmail.setHtmlMsg(html);
                sendEmail.send();
               
            }
			// └───────────── 예약정보 메일 전송  ─────────────┘
           
			map.put("result",  true);
			map.put("bookCd", bookCd);
			map.put("locSeq", locSeq);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "예약중 오류가 발생하였습니다-2");
		}
		
		return map;
	}

	/**
	 * 예약 완료 후 결과 페이지로 이동
	 * (예약자, 장소, 일정, 금액) 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/resultBook/{bookCd}/{locSeq}")
	public String resultBook(Model model, HttpServletRequest request
			, @PathVariable String bookCd, @PathVariable Integer locSeq) {
		
		try {
			// 상단 메뉴에 표출할 지점목록 
			List<Location> locs = locService.selectLocListWithImg(new Location());
			model.addAttribute("locs", locs);
			
			// 하단에 표출할 대표연락처 
			Contact cont = contService.getContact(new Contact());
			model.addAttribute("cont", cont);

			// 지점 담당자 정보 
			Location loc = new Location();
			loc.setLocSeq(locSeq);
			loc = locService.getLoc(loc);
			model.addAttribute("loc", loc);
			
			model.addAttribute("menu", "book3");
			model.addAttribute("bookCd",  bookCd);
	
			if (!bookCd.equals("")) {
				// book_detail 조회 
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("bookCd", bookCd);
				List<Map<String, Object>> list = bkDetailService.selectBookResult(params);
				model.addAttribute("list", list);
				
				Integer idx = 1;
				
		        for (Map<String, Object> bk : list) {
		        	String bookResult = "";
		        	
		        	String strtTm = (bk.get("STRT_TM").toString()).substring(0, 2);
		        	String endTm = (bk.get("END_TM").toString()).substring(0, 2);	
		        	
			        Integer cnt = Integer.parseInt(endTm) - Integer.parseInt(strtTm);

					// 22-08-12(금) ~ 22-08-14(일) 11:00 ~ 13:00 (2시간)
					bookResult = bk.get("STRT_DT").toString() + "(" + yoil(bk.get("STRT_DT").toString()) + ")";
					bookResult += " ~ " + bk.get("END_DT").toString() + "(" + yoil(bk.get("END_DT").toString()) + ")";
					bookResult += " " + strtTm + ":00 ~ " + endTm + ":00 (" + cnt + "시간)";
					bk.put("BOOK_RESULT", bookResult);
					idx += 1;
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/book/book3";
	}

	/**
	 * 예약 확인/취소 페이지
	 * (예약자, 장소, 일정, 금액) 
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/bookDetailConfirm/{bookCd}/{locSeq}")
	public String bookDetailConfirm(Model model, HttpServletRequest request
			, @PathVariable String bookCd, @PathVariable Integer locSeq) {
		
		try {
			// 상단 메뉴에 표출할 지점목록 
			List<Location> locs = locService.selectLocListWithImg(new Location());
			model.addAttribute("locs", locs);
			
			// 하단에 표출할 대표연락처 
			Contact cont = contService.getContact(new Contact());
			model.addAttribute("cont", cont);
			// 지점 담당자 정보 
			Location loc = new Location();
			loc.setLocSeq(locSeq);
			loc = locService.getLoc(loc);
			model.addAttribute("loc", loc);
			
			model.addAttribute("menu", "bookConfirm2");
	
			if (!bookCd.equals("")) {
				Book tmpBook = new Book();
				tmpBook.setBookCd(bookCd);
				Book getBook = bookService.getBook(tmpBook);
				model.addAttribute("book", getBook);
				
				// book_detail 조회 
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("bookCd", bookCd);
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				if (getBook.getBookSttsCd().equals("100004")) {
					// 예약취소의 경우 book_detail_log 테이블에서 조회 
					list = bkDetailLogService.selectBookResult(params);
				} else {
					// 예약취소 아닌경우 book_detail 테이블에서 조회 
					list = bkDetailService.selectBookResult(params);
				}
			
				model.addAttribute("list", list);
				
				Integer idx = 1;
				
		        for (Map<String, Object> bk : list) {
		        	String bookResult = "";
		        	
		        	String strtTm = (bk.get("STRT_TM").toString()).substring(0, 2);
		        	String endTm = (bk.get("END_TM").toString()).substring(0, 2);	
		        	
			        Integer cnt = Integer.parseInt(endTm) - Integer.parseInt(strtTm);

					// 22-08-12(금) ~ 22-08-14(일) 11:00 ~ 13:00 (2시간)
					bookResult = bk.get("STRT_DT").toString() + "(" + yoil(bk.get("STRT_DT").toString()) + ")";
					bookResult += " ~ " + bk.get("END_DT").toString() + "(" + yoil(bk.get("END_DT").toString()) + ")";
					bookResult += " " + strtTm + ":00 ~ " + endTm + ":00 (" + cnt + "시간)";
					bk.put("BOOK_RESULT", bookResult);
					idx += 1;
				}
		        
				model.addAttribute("totalCnt", list.size());
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/book/bookDetailConfirm";
	}
	
	public String yoil(String param) throws ParseException {
		String resultValue = "";
		
		try {
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		    // 토,일,월,화,수,목,금 = 7,1,2,3,4,5,6
			Calendar cal = Calendar.getInstance();
			Date date = format.parse(param); 	
	        cal.setTime(date);
	        
			switch (cal.get(Calendar.DAY_OF_WEEK)) {
				case 1:
					resultValue = "일";
					break;
				case 2:
					resultValue = "월";
					break;
				case 3:
					resultValue = "화";
					break;
				case 4:
					resultValue = "수";
					break;
				case 5:
					resultValue = "목";
					break;
				case 6:
					resultValue = "금";
					break;
				case 7:
					resultValue = "토";
					break;
				default:
					break;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return resultValue;
	}
	
	/**
	 * 예약확인/취소
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/bookConfirm")
	public String bookConfirm(Model model, HttpServletRequest request) {
		
		// 상단 메뉴에 표출할 지점목록 
		List<Location> locs = locService.selectLocListWithImg(new Location());
		model.addAttribute("locs", locs);
		
		// 하단에 표출할 대표연락처 
		Contact cont = contService.getContact(new Contact());
		model.addAttribute("cont", cont);
		model.addAttribute("menu", "bookConfirm");
		
		return "/book/bookConfirm";
	}
	
	/**
	 * 예약확인/취소 > 예약조회 
	 * (예약상태, 예약코드, 예약일, 예약신청일자, 금액) 
	 * 
	 * @param model
	 * @param request
	 * @return
	*/
	@RequestMapping("/bookConfirm/result")
	@ResponseBody
	public Map<String, Object> bookConfirm2(Model model, HttpServletRequest req) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {	
			if (req.getParameter("name") == null || req.getParameter("email") == null
					|| req.getParameter("name").toString().equals("") || req.getParameter("email").toString().equals("")) {
				map.put("result",  false);
				map.put("message", "파라미터 확인");
				return map;
			}
			
			log.info("[bookConfirm2] 예약 정보 조회 > name: {}, email: {}", req.getParameter("name").toString(), req.getParameter("email").toString());
			// book_detail 조회 
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("email", req.getParameter("email").toString().trim());
			params.put("name", req.getParameter("name").toString().trim());
			List<Book> list = bookService.selectBookList(params);
			map.put("list", list);
			
			if (list.size() <= 0) {
				map.put("result",  false);
				map.put("message", "조회된 예약정보가 없습니다.");
				return map;
			}
			
	        map.put("result",  true);
			map.put("resultCnt", list.size());
	        
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "예약 정보 조회 실패");
		}
		
		return map;
	} 
	

	/**
	 * 예약취소 
	 * 
	 * @param model
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/popBookCancel/{bookCd}")
	public String bookCancel(Model model, HttpServletRequest request, @PathVariable String bookCd) {

		log.info("[bookCancel] bookCd: {}", bookCd);

		try {

			model.addAttribute("bookCd", bookCd);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "/book/popBookCancel";
	}
	
	/**
	 * 예약 진행중 or 마감된 예약이 있는지 체크 
	 * 
	 * @param param (사용자가 담은 예약목록)
	 * @return
	 */
	public Boolean chkBookClosed(List<Map<String, Object>> params){
		
		Boolean isClosed = false;
		
		try {
			
			for (Map<String, Object> param : params) {

				String strtDt = param.get("bookDt").toString().substring(0,10);
				String endDt = param.get("bookDt").toString().substring(13);

				// 회의실코드, 날짜, 시간 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("roomSeq", param.get("roomSeq"));
				map.put("strtDt", strtDt);
				map.put("endDt", endDt);
				map.put("strtTm", param.get("strtTm").toString() + ":00");
				map.put("endTm", param.get("endTm").toString() + ":00");
				
				// 제외 날짜가 여러개인경우 쿼리가 정상작동하지 않아서 수정 - 배은화 (2022-08-24)
				if (param.get("excludedDate") != null ) {
					String excludedDate = param.get("excludedDate").toString();
	
					if (excludedDate.indexOf(",") > 0) {
						// 제외할 날짜 여러개
						String[] strArr = (param.get("excludedDate")).toString().split(",");				
						List<String> dtList = new ArrayList<String>();
						 
						for (String str : strArr) {
							dtList.add(str); 
						}
						
						map.put("dtList", dtList);
					} else {
						// 제외할 날짜 하루 
						map.put("excludedDate", param.get("excludedDate"));
					}
				}

				log.info("[chkBookClosed] tmpDetail: {}", map);
				List<BookDetail> BkDetail = bkDetailService.bookNotAvailableTime(map);
				
				if (BkDetail.size() > 0) {
					log.info("[chkBookClosed] BkDetail: {}", BkDetail);
					return true;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return isClosed;
	}
	
} 	