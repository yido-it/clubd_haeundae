package com.clubd_haeundae.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.CmnCode;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Tour;
import com.clubd_haeundae.repository.CmnCodeMapper;
import com.clubd_haeundae.repository.LocationMapper;
import com.clubd_haeundae.repository.TourMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TourService {

	@Autowired
    private TourMapper tourMapper;

	@Autowired
	private CmnCodeMapper commonCodeMapper;
	
	@Autowired
	private LocationMapper lcationMapper;
	
	public List<Tour> selectTourList(Tour tour){
		return tourMapper.selectTourList(tour);
	}

	public Tour selectTourInfo(Tour tour){
		return tourMapper.selectTourInfo(tour);
	}

	public int insertTour(Tour tour) {
		return tourMapper.insertTour(tour);
	}

	public int updateTour(Tour tour) {

		// 신청상태
		if (tour.getReqSttsNm() != null) {
			CmnCode cmnCode = new CmnCode();
			cmnCode.setCmnNm(tour.getReqSttsNm());
			cmnCode.setUpCd("300");
			cmnCode = commonCodeMapper.selectStrToCode(cmnCode);
			tour.setReqSttsCd(cmnCode.getCmnCd());
		}
		
		// 지점 
		if (tour.getLocName() != null) {
			Location loc = new Location();
			loc.setName(tour.getLocName());
			loc = lcationMapper.getLoc(loc);
			tour.setLocSeq(loc.getLocSeq());	
		}
		
		log.info("[updateTour] tour : {} ", tour);
		
		return tourMapper.updateTour(tour);
	}
    
}
