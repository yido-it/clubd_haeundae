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
import com.clubd_haeundae.model.Image;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.service.ImageService;
import com.clubd_haeundae.service.RoomService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/room")
public class RoomController {

	@Autowired
	private RoomService roomService;
	
	@Autowired
	private ImageService imageService;

	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> getList(Model model, Room room) {
		//log.info("room: " + room);
		Map<String, Object> map = new HashMap<String, Object>();
		List<Room> rooms = roomService.selectRoomList(room);
		
		map.put("rooms",  rooms);

		return map;
	}

	@RequestMapping("/roomNameList")
	@ResponseBody
	public String roomNameList(Model model, Room room) {
		
		Map<String, String> map = new HashMap<String, String>();

		List<Room> rooms = roomService.selectRoomList(room);
		//log.info(rooms.toString());
		for (Room item : rooms) {
			// map.put(item.getName(), item.getRoomSeq().toString());
			map.put(item.getName(), item.getName());
		}
	
		JSONObject json =  new JSONObject(map);
	
		return  json.toString();
	}
	
	/**
	 * 회의실 자세히보기 
	 * 
	 * @param model
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/popDetail/{id}")
	public String popDetail(Model model, HttpServletRequest req, @PathVariable Integer id) {

		log.info("[popDetail] roomSeq : {}", id);
		
		Room tempRoom = new Room();
		tempRoom.setRoomSeq(id);
		Room room = roomService.getRoom(tempRoom);
		model.addAttribute("room", room);
		
		Image img = new Image();
		img.setRoomSeq(id);
		List<Image> imgs = imageService.selectImageList(img);
		model.addAttribute("imgs", imgs);
		
		return "/book/popRoomDetail";
	}
	
	/**
	 * 회의실 이미지목록 조회
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/imagelist")
	@ResponseBody
	public List<Image> roomImagelist(Model model, Image image) {
		
		log.info("[roomImagelist] image : {}", image);
		List<Image> imageList = imageService.selectImageList(image);
		log.info("[roomImagelist] 회의실 이미지 목록 조회 건수 : {}", imageList.size());

		return imageList;
	}
	
}
