package com.clubd_haeundae.controller;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.clubd_haeundae.model.BookDetailLog;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.service.BookDetailLogService;
import com.clubd_haeundae.service.LocationService;
import com.clubd_haeundae.service.RoomService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class BookDetailLogController {
	
	@Autowired
	BookDetailLogService bkLogService;
	
	@Autowired
	LocationService locService;
	
	@Autowired
	RoomService roomService;
	
	/**
	 * 관리자 모드 > 예약 로그 조회 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bkDetailLog/list")  
	@ResponseBody
	public List<BookDetailLog> bkDetailLogList(@RequestParam Map<String, Object> params, HttpServletRequest req) {
		
		log.info("[bkDetailLogList] params: {}", params);
		List<BookDetailLog> list = new ArrayList<>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			if (params.get("bookDt") != null) {
				String strtDt = (params.get("bookDt")).toString().substring(0, 10);
				String endDt = (params.get("bookDt")).toString().substring(13);
	
				map.put("strtDt", strtDt);
				map.put("endDt", endDt);
			}
			if (params.get("locSeq") != null) map.put("locSeq", params.get("locSeq"));
			if (params.get("roomSeq") != null) map.put("roomSeq", params.get("roomSeq"));
			if (params.get("bookCd") != null) map.put("bookCd", params.get("bookCd"));
			
			// map.put("useYn", "Y");
			//log.info("[bkDetailLogList] map: {}", map);
			list = bkLogService.selectLogByMap(map);
			log.info("[bkDetailLogList] 조회된 건수 : {}건", list.size());
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	/**
	 * 관리자 모드 > 예약 로그 조회 (GROUP BY)
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bkDetailLog/groupByList")  
	@ResponseBody
	public List<BookDetailLog> bkDetailLogGroupByList(@RequestParam Map<String, Object> params, HttpServletRequest req) {
		
		log.info("[bkDetailLogGroupByList] params: {}", params);
		List<BookDetailLog> list = new ArrayList<>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			if (params.get("bookDt") != null) {
				String strtDt = (params.get("bookDt")).toString().substring(0, 10);
				String endDt = (params.get("bookDt")).toString().substring(13);
	
				map.put("strtDt", strtDt);
				map.put("endDt", endDt);
			}
			if (params.get("locSeq") != null) map.put("locSeq", params.get("locSeq"));
			if (params.get("roomSeq") != null) map.put("roomSeq", params.get("roomSeq"));
			if (params.get("bookCd") != null) map.put("bookCd", params.get("bookCd"));
			
			// map.put("useYn", "Y");
			//log.info("[bkDetailLogList] map: {}", map);
			list = bkLogService.groupByListByMap(map);
			log.info("[bkDetailLogList] 조회된 건수 : {}건", list.size());
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * 관리자 모드 > 예약 상세이력 
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/admin/bookDetailLog")  
	public String bookLog(Model model, HttpServletRequest req) {

		// 지점 조회 
		Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		
		// 회의실 조회 
		Room room = new Room();
		List<Room> rooms = roomService.selectRoomList(room);
		model.addAttribute("rooms", rooms);
		
		return "/admin/book/bookDetailLog";
	}

	@RequestMapping("/admin/bkDetailLog/status")  
	@ResponseBody
	public List<BookDetailLog> detailLogStatus(BookDetailLog bookDetailLog, HttpServletRequest req) {

		log.info("[detailLogStatus] bookDetailLog : " + bookDetailLog);
		
		bookDetailLog.setUseYn("Y");
		List<BookDetailLog> list = bkLogService.selectBookDetailLog(bookDetailLog);
		log.info("[detailLogStatus] 조회된 건수 : {}건", list.size());

		return list;
	}
	

} 	