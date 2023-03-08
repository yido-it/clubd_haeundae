package com.clubd_haeundae.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clubd_haeundae.model.Contact;
import com.clubd_haeundae.model.Fee;
import com.clubd_haeundae.model.Image;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.service.ContactService;
import com.clubd_haeundae.service.FeeService;
import com.clubd_haeundae.service.ImageService;
import com.clubd_haeundae.service.LocationService;
import com.clubd_haeundae.service.RoomService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/loc")
public class LocationController {

	@Autowired
	private LocationService locService;
	
	@Autowired
	private ImageService imgService;
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private FeeService feeService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private ContactService contService;

	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> getList(Model model, Location loc) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Location> locs = locService.selectLocList(loc);
		
		map.put("locs",  locs);

		return map;
	}
	
	@RequestMapping("/listWithImg")
	@ResponseBody
	public Map<String, Object> getListWithImg(Model model, Location loc) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Location> locs = locService.selectLocListWithImg(loc);
		
		map.put("locs",  locs);

		return map;
	}
	
	@RequestMapping("/info/{locSeq}")
	@ResponseBody
	public Map<String, Object> getLocInfo(@PathVariable Integer locSeq) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Location loc = new Location();
		loc.setLocSeq(locSeq);
		loc = locService.getLoc(loc);
		
		map.put("loc",  loc);

		return map;
	}
	

	@RequestMapping("/locNameList")
	@ResponseBody
	public String locNameList(Model model, Location loc) {
		
		Map<String, String> map = new HashMap<String, String>();

		List<Location> locs = locService.selectLocList(loc);
		
		for (Location item : locs) {
			// map.put(item.getName(), item.getLocSeq().toString());
			map.put(item.getName(), item.getName());
		}
	
		JSONObject json =  new JSONObject(map);
	
		return  json.toString();
	}
	
	/**
	 * 모든지점 페이지 
	 * 
	 * @param model
	 * @param assetUser
	 * @param request
	 * @return
	 */
	@RequestMapping("/locMain")
	public String location(Model model, HttpServletRequest request) {
		
		// 상단 메뉴에 표출할 지점목록 
		List<Location> locs = locService.selectLocListWithImg(new Location());
		model.addAttribute("locs", locs);
		
		// 하단에 표출할 대표연락처 
		Contact cont = contService.getContact(new Contact());
		model.addAttribute("cont", cont);
		model.addAttribute("menu", "loc");
		
		return "/loc/locMain";
	}
	
	/**
	 * 지점소개 페이지
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/locDetail/{id}")   
	public String yeouido(Model model, HttpServletRequest request, @PathVariable Integer id) {
		
		Location loc = new Location();
		// 상단 메뉴에 표출할 지점목록 
		List<Location> locs = locService.selectLocListWithImg(new Location());
		model.addAttribute("locs", locs);
		
		// 하단에 표출할 대표연락처 
		Contact cont = contService.getContact(new Contact());
		model.addAttribute("cont", cont);
		
		//지점정보
		loc.setLocSeq(id);
		model.addAttribute("loc",  locService.getLoc(loc));
		
		// 지점 이미지
		Map<String, Object> locMap = new HashMap<String, Object>();
		locMap.put("locSeq", id);
		locMap.put("getLocYn", "Y");
		locMap.put("flrPlanYn", "N");				
		List<Image> locImgList = imageService.imgListByMap(locMap);
		model.addAttribute("locImgList", locImgList);
		//log.info("locImgList > " + locImgList);
		
		// 회의실 이미지
		Map<String, Object> roomMap = new HashMap<String, Object>();
		roomMap.put("locSeq", id);
		roomMap.put("getRoomYn", "Y");		
		List<Image> roomImgList = imageService.imgListByMap(roomMap);
		model.addAttribute("roomImgList", roomImgList);
		//log.info("roomImgList > " + roomImgList);
	
		// 평면도
		Image tmpImg2 = new Image();
		tmpImg2.setLocSeq(id);
		tmpImg2.setFlrPlanYn("Y");
		List<Image> flrPlanList = imageService.selectImageList(tmpImg2);
		if ( flrPlanList.size() > 0 ) model.addAttribute("flrPlan", flrPlanList.get(0));
		
		//회의실리스트
		Room room = new Room();
		room.setLocSeq(id);
		List<Room> rooms = roomService.selectRoomList(room);
		model.addAttribute("roomList",  rooms);
		
		//요금표리스트
		Fee fee = new Fee();
		fee.setLocSeq(id);
		List<Fee> fees = feeService.feeTableList(fee);
		model.addAttribute("feeList",  fees);

		model.addAttribute("menu", "loc");
		
		return "/loc/locDetail";
	}
}
