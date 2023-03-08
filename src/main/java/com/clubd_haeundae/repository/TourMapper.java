package com.clubd_haeundae.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.Tour;

@Mapper
@Repository
public interface TourMapper {

	public List<Tour> selectTourList(Tour tour);

	public Tour selectTourInfo(Tour tour);

	public int insertTour(Tour tour);

	public int updateTour(Tour tour);
	
}
