package com.clubd_haeundae.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clubd_haeundae.model.GrapeUser;
import com.clubd_haeundae.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping("/getUserList")
	@ResponseBody
	public List<GrapeUser> getUserList(Model model, GrapeUser user) {
		List<GrapeUser> list = userService.selectUserList(user);

		return list;
	}
	
	@RequestMapping("/deleteUser")
	@ResponseBody
	public Map<String, Object> deleteUser(HttpServletRequest req){

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			GrapeUser user = new GrapeUser();
			user.setUserId(req.getParameter("userId"));
			userService.deleteUser(user);
			
			map.put("result",  true);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "사용자 삭제중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	@RequestMapping("/checkUserId")
	@ResponseBody
	public Map<String, Object> checkUserId(HttpServletRequest req){

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			GrapeUser user = new GrapeUser();
			user.setUserId(req.getParameter("userId"));
			GrapeUser selectUser = userService.selectCompanyUserInfo(user);
			
			if(selectUser == null) {
				map.put("result",  true);
			} else {
				map.put("result",  false);
				map.put("message",  "존재하는 ID입니다.");
			}
		} catch(Exception e) {
			map.put("result",  false);
			map.put("message", "ID중복체크중 오류가 발생하였습니다.");
		}
		
		return map;
	}

	@RequestMapping("/insertUserInfo")
	@ResponseBody
	public Map<String, Object> insertUserInfo(HttpServletRequest req, GrapeUser user){
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.info(user.toString());
			
			if ((user.getUserAuth().equals("") || user.getUserAuth().equals("AAA000")) && user.getLocSeq() > 0) {
				// 전체사용자 선택했는데, 선택된 지역이 있을경우 초기화 
				user.setLocSeq(0);
			}
			userService.insertUser(user);
			map.put("result",  true);
			
		} catch(DuplicateKeyException e) {
			e.printStackTrace();
			map.put("result", false);
			map.put("message", "이미 사용중인 ID입니다.");
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "사용자정보 등록중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	@RequestMapping("/updateUserInfo")
	@ResponseBody
	public Map<String, Object> updateUserInfo(HttpServletRequest req, GrapeUser user){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			if ((user.getUserAuth().equals("") || user.getUserAuth().equals("AAA000")) && user.getLocSeq() > 0) {
				// 전체사용자 선택했는데, 선택된 지역이 있을경우 초기화 
				user.setLocSeq(0);
			}
			userService.updateUser(user);
			map.put("result",  true);
			
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "사용자정보 수정중 오류가 발생하였습니다.");
		}
		
		return map;
	}
}
