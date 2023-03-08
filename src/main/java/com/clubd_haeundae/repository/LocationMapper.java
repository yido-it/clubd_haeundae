package com.clubd_haeundae.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.Location;

@Mapper
@Repository
public interface LocationMapper {

	public List<Location> selectLocList(Location loc);
	
	public List<Location> selectLocListWithImg(Location loc);
	
	public Location getLoc(Location loc);
	
	public int insertLoc(Location loc);

	public int updateLoc(Location loc);

	public int deleteLoc(Location loc);

	public List<Location> getLocNmList(Location loc);

	public Location selectStrToCode(Location location);
}
