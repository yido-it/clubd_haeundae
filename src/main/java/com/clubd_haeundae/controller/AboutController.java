package com.clubd_haeundae.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clubd_haeundae.model.Contact;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.service.ContactService;
import com.clubd_haeundae.service.LocationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class AboutController {

	@Autowired
	private LocationService locService;
	
	@Autowired
	private ContactService contService;

	/**
	 * 회사소개 (about)
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/about")   
	public String about(Model model, HttpServletRequest request) {
		
		// 상단 메뉴에 표출할 지점목록 
		List<Location> locs = locService.selectLocListWithImg(new Location());
		model.addAttribute("locs", locs);
		
		// 하단에 표출할 대표연락처 
		Contact cont = contService.getContact(new Contact());
		model.addAttribute("cont", cont);
		model.addAttribute("menu", "about");
		
		return "/about";
	}

}
