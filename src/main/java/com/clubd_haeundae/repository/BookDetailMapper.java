package com.clubd_haeundae.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.BookDetail;


@Mapper
@Repository
public interface BookDetailMapper {
	
	// BOOK_SEQ
	public int getBkDetailIdx();

	// BOOK_GROUP_CD
	public int getBkDetailGroupCd();
	
	// 가장 마지막 예약 설정 날짜 가져오기
	public Map<String, Object> getMaxBookDt(Map<String, Object> params);
	
	public List<BookDetail> selectBookDetail(BookDetail bookDetail);
	
	public List<BookDetail> selectBookDetailByParam(Map<String, Object> params);
	
	// 예약결과
	public List<Map<String, Object>> selectBookResult(Map<String, Object> params);
	
	// 예약페이지에 표출할 예약타임조회
	public List<BookDetail> bookTimeTable(Map<String, Object> params);
	
	// 예약 불가능한 시간대 조회
	public List<BookDetail> bookNotAvailableTime(Map<String, Object> params);
	
	public BookDetail getBookDetail(BookDetail bookDetail);

	// 1개의 예약에 대한 가장빠른예약시작일자,가장늦은종료일자 조회
	public Map<String, Object> getBookDtByBookCd(Map<String, Object> params);
	
	// 예약설정 데이터 수정
	public int updateBookDetail(BookDetail bookDetail);
	
	// 예약설정 데이터 수정
	public int updateBookDetailByMap(Map<String, Object> params);
	
	// 예약설정 데이터 전체오픈
	public int updateOpenAll(BookDetail bookDetail);
	
	// 예약설정 데이터 등록
	public int insertBookDetail(BookDetail bookDetail);
	
	// 예약설정 데이터 삭제
	public int deleteBookDetail(BookDetail bookDetail);

}
