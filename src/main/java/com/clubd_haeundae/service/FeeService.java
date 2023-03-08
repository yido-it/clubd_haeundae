package com.clubd_haeundae.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.Fee;
import com.clubd_haeundae.repository.FeeMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FeeService {

	@Autowired
    private FeeMapper feeMapper;
	
	// 예약날짜에 해당하는 요금 가져오기 
    public Map<String, Object> getFeeByBookDt(Map<String, Object> params) {
    	return feeMapper.getFeeByBookDt(params);
    }
	
	// 요금표 ( 현재날짜에 해당하는 요금 가져오기 )
    public List<Fee> feeTableList(Fee fee) {
    	return feeMapper.feeTableList(fee);
    }

    // 관리자 - 요금리스트 가져오기
	public List<Fee> selectFeeList(Fee fee) {
		return feeMapper.selectFeeList(fee);
	}
	
	public Fee getFee(Fee fee) {
		return feeMapper.getFee(fee);
	}


	public int insertFee(HttpServletRequest req, Fee fee, LocalDate endDt) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		log.info("[insertFee] endDt:" + endDt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("regId", auth.getName());
		map.put("updId", auth.getName());
		map.put("endDt", endDt);
		map.put("locSeq", fee.getLocSeq());
		map.put("roomSeq", fee.getRoomSeq());
		map.put("feeSeq", fee.getFeeSeq());
		
		feeMapper.updateFeeByMap(map);
		
		fee.setRegId(auth.getName());
		return feeMapper.insertFee(fee);
	}

	public int selectSameDateFeeCnt(Fee fee) {
		return feeMapper.selectSameDateFeeCnt(fee);
	}

	public int updateSameFee(HttpServletRequest req, Fee fee) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		fee.setUpdId(auth.getName());
		
		return feeMapper.updateSameFee(fee);
	}
	
	public int updateFee(Fee fee) {
		
		return feeMapper.updateFee(fee);
	}
}
