package com.clubd_haeundae.controller;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clubd_haeundae.model.Contact;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.service.ContactService;
import com.clubd_haeundae.service.LocationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class WebController {
	
	@Autowired
	private LocationService locService;
	
	@Autowired
	private ContactService contService;

	@RequestMapping("")
	public String index(Model model, Authentication auth) {
		// 사용자 메인페이지로 이동 
		return "redirect:main";	
	}
	
	/**
	 * 메인페이지
	 * 
	 * @param model
	 * @param assetUser
	 * @param request
	 * @return
	 */
	@RequestMapping("/main")
	public String index(Model model, HttpServletRequest request) {
		
		// 상단 메뉴에 표출할 지점목록 
		List<Location> locs = locService.selectLocListWithImg(new Location());
		model.addAttribute("locs", locs);
		
		// 하단에 표출할 대표연락처 
		Contact cont = contService.getContact(new Contact());
		model.addAttribute("cont", cont);
		
		return "/index";
	}

    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String login(@RequestParam(required = false) String error, HttpServletRequest request, Model model, Authentication auth) throws IOException {
        
		if(auth != null) {
			// 로그인 성공시 관리자 메인페이지로 이동
			return "redirect:/admin/main";
		}
		
        String referrer = request.getHeader("Referer");
		log.debug("referrer - {}", referrer);
		
        if (null != error) {
            Exception exception = (Exception) request.getSession().getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
//            if(exception instanceof LockedException || exception instanceof BadCredentialsException) {
                error = exception.getMessage();
//            }else {
//                error = "Invalid username and password!";
//            }
            model.addAttribute("errorMessage", error);
        }
        
        Cookie[] cs = request.getCookies();
    	if(cs != null) {
    		for(Cookie c : cs) {
    			model.addAttribute(c.getName(), c.getValue());
        	}
    	}

        log.debug("ip1 - {}", request.getRemoteAddr());
        return "login";
    }
    
    @RequestMapping("/succ-logout")
	public String successLogout(Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {

		//세션 invalidate
		request.getSession().invalidate();
		
		//delete cookie
		Cookie[] cs = request.getCookies();
    	if(cs != null) {
    		for(Cookie c : cs) {
    			System.out.println("delete cookie = " + c.getName());
    			c.setMaxAge(0);
    			c.setValue(null);
    			response.addCookie(c);    			
        	}
    	}    	
    	
    	return "/login";
	}

    @RequestMapping("/qrscan")
    public String qrCode(Model model, HttpServletRequest request) {
    	
    	return "/index";
    }
    
    @RequestMapping("/qrcodeBookConfirm")
    public String qrcodeBookConfirm(Model model, HttpServletRequest request) {
    	
    	Location loc = new Location();
		List<Location> locs = locService.selectLocList(loc);
		model.addAttribute("locs", locs);
		model.addAttribute("menu", "bookConfirm");
		
		return "/admin/temp/bookConfirm";
    }
    
}
 	