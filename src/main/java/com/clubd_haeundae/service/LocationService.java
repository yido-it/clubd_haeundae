package com.clubd_haeundae.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.repository.LocationMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LocationService {

	@Autowired
    private LocationMapper locMapper;

	public List<Location> selectLocList(Location loc) {
		
		if(loc.getAdminAuth() != null) {
			if(!loc.getAdminAuth().equals("[ROLE_AAA001]") ) {
				loc.setAdminId(null);
			}	
		}
				
		return locMapper.selectLocList(loc);
	}
	
	public List<Location> selectLocListWithImg(Location loc){
		return locMapper.selectLocListWithImg(loc);
	}

	public Location getLoc(Location loc) {
		return locMapper.getLoc(loc);
	}
	
	public int insertLoc(HttpServletRequest req, Location loc) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		loc.setRegId(auth.getName());
		return locMapper.insertLoc(loc);
	}

	public int updateLoc(Location loc) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		loc.setUpdId(auth.getName());
		return locMapper.updateLoc(loc);
	}

	public int deleteLoc(Location loc) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		loc.setUpdId(auth.getName());
		return locMapper.deleteLoc(loc);
	}

	public List<Location> getLocNmList(Location loc) {
		return locMapper.getLocNmList(loc);
	}
  
}
