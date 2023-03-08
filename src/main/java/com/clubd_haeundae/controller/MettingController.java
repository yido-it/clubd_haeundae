package com.clubd_haeundae.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.clubd_haeundae.model.Contact;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.service.ContactService;
import com.clubd_haeundae.service.LocationService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class MettingController {

	@Autowired
	private LocationService locService;
	
	@Autowired
	private ContactService contService;

	/**
	 * 미팅 & 이벤트 (MEETINGS & EVENTS)
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/meeting")   
	public String meeting(Model model, HttpServletRequest request) {
		
		// 상단 메뉴에 표출할 지점목록 
		List<Location> locs = locService.selectLocListWithImg(new Location());
		model.addAttribute("locs", locs);
		
		// 하단에 표출할 대표연락처 
		Contact cont = contService.getContact(new Contact());
		model.addAttribute("cont", cont);
		model.addAttribute("menu", "meeting");
		
		return "/meeting";
	}
	
}
