package com.clubd_haeundae.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.BookDetailLog;

@Mapper
@Repository
public interface BookDetailLogMapper {
	
	public int getBkLogIdx();		// LOG_SEQ

	public int getBkLogGroupCd();	// BOOK_GROUP_CD
	
	public List<BookDetailLog> selectBookDetailLog(BookDetailLog bookDetailLog);
	
	// 예약상세이력 
	public List<BookDetailLog> selectLogByMap(Map<String, Object> params);
	
	// 예약상세이력 (Group By)
	public List<BookDetailLog> groupByListByMap(Map<String, Object> params);
	
	// 예약결과
	public List<Map<String, Object>> selectBookResult(Map<String, Object> params);

	public BookDetailLog getBookDetailLog(BookDetailLog bookDetailLog);
	
	// 예약로그 데이터 등록
	public int insertBkDetailLog(BookDetailLog bookDetailLog);
	
	// 예약로그 데이터 수정
	public int updateBkDetailLog(BookDetailLog bookDetailLog);
	
	// 예약로그 데이터 삭제
	public int deleteBkDetailLog(BookDetailLog bookDetailLog);
	
}
