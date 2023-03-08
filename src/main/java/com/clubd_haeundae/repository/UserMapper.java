package com.clubd_haeundae.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.GrapeUser;

@Mapper
@Repository
public interface UserMapper {

	public GrapeUser selectUser(String userId);

	public List<GrapeUser> selectUserList(GrapeUser assetUser);

	public int deleteUser(GrapeUser user);

	public GrapeUser selectCompanyUserInfo(GrapeUser user);

	public int insertUser(GrapeUser user);

	public int updateUser(GrapeUser user);

}
