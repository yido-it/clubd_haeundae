package com.clubd_haeundae.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.GrapeUser;
import com.clubd_haeundae.repository.UserMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserService {

	@Autowired
    private UserMapper userMapper;
	@Autowired
    private PasswordEncoder passwordEncoder;

    public GrapeUser selectUser(String userId) {
    	return userMapper.selectUser(userId);
    }

    public List<GrapeUser> selectUserList(GrapeUser assetUser){
    	return userMapper.selectUserList(assetUser);
    }

	public int deleteUser(GrapeUser user) {
		return userMapper.deleteUser(user);
	}

	public GrapeUser selectCompanyUserInfo(GrapeUser user) {
		return userMapper.selectCompanyUserInfo(user);
	}

	public int insertUser(GrapeUser user) {
		user.setUserPwd(encodePassword(user.getUserPwd()));
    	return userMapper.insertUser(user);
	}

	public String encodePassword(String password) {
    	return passwordEncoder.encode(password);
    }

	public int updateUser(GrapeUser user) {
		System.out.println("####" + user.getUserPwd());
		if(user.getUserPwd() != null) {
			//업데이트를 통해서 기본설정된 패스워드라면 업데이트 하지 않는다.
			if( "******".equals(user.getUserPwd()) ) {
				user.setUserPwd(null);
			}else {
				user.setUserPwd(encodePassword(user.getUserPwd()));
			}
		}
    	return userMapper.updateUser(user);
	}
}
