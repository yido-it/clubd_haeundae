package com.clubd_haeundae.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.Fee;


@Mapper
@Repository
public interface FeeMapper {
	
	// 예약날짜에 해당하는 요금 가져오기 
	public Map<String, Object> getFeeByBookDt(Map<String, Object> params);
	
	// 요금표 ( 현재날짜에 해당하는 요금 가져오기 )
	public List<Fee> feeTableList(Fee fee);

	// 관리자 - 요금리스트 가져오기
	public List<Fee> selectFeeList(Fee fee);
	
	public Fee getFee(Fee fee);

	public int insertFee(Fee fee);

	public int updateFeeByMap(Map<String, Object> params);
	
	public int updateFee(Fee fee);
	
	public int selectSameDateFeeCnt(Fee fee);

	public int updateSameFee(Fee fee);
	
}
