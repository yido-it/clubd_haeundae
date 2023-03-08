package com.clubd_haeundae.security;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.GrapeUser;
import com.clubd_haeundae.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AdminUserDetailsService implements UserDetailsService {

	@Autowired
	private UserService userService;

	@Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
	
		GrapeUser gUser = userService.selectUser(userId);

        List<GrantedAuthority> authorities = Collections.singletonList(new SimpleGrantedAuthority("ROLE_"+gUser.getUserAuth()));

		//log.info("gUser.getUserPwd : " +  gUser.getUserPwd());
        return new User(gUser.getUserId(), gUser.getUserPwd(), authorities);
    }
}
