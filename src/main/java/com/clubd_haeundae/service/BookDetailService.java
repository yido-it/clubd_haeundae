package com.clubd_haeundae.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.BookDetail;
import com.clubd_haeundae.repository.BookDetailMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookDetailService {

	@Autowired
    private BookDetailMapper bookDetailMapper;
	
	// BOOK_SEQ
	public int getBkDetailIdx() throws Exception {
		return bookDetailMapper.getBkDetailIdx();
	}

	// getBkDetailGroupCd
	public int getBkDetailGroupCd() throws Exception {
		return bookDetailMapper.getBkDetailGroupCd();
	}
	
	// 가장 마지막 예약 설정 날짜 가져오기
    public Map<String, Object> getMaxBookDt(Map<String, Object> params) {
    	return bookDetailMapper.getMaxBookDt(params);
    }
	
    public List<BookDetail> selectBookDetail(BookDetail bookDetail) {
    	return bookDetailMapper.selectBookDetail(bookDetail);
    }
    
    public List<BookDetail> selectBookDetailByParam(Map<String, Object> params) {
    	return bookDetailMapper.selectBookDetailByParam(params);
    }
    
    // 예약결과
    public List<Map<String, Object>> selectBookResult(Map<String, Object> params) {
    	return bookDetailMapper.selectBookResult(params);
    }

    // 예약페이지에 표출할 예약타임조회
    public List<BookDetail> bookTimeTable(Map<String, Object> params) {
    	return bookDetailMapper.bookTimeTable(params);
    }

    // 예약 불가능한 시간대 조회
    public List<BookDetail> bookNotAvailableTime(Map<String, Object> params) {
    	return bookDetailMapper.bookNotAvailableTime(params);
    }
    
    public BookDetail getBookDetail(BookDetail bookDetail) {
    	return bookDetailMapper.getBookDetail(bookDetail);
    }
    
    // 1개의 예약에 대한 가장빠른예약시작일자,가장늦은종료일자 조회
    public Map<String, Object> getBookDtByBookCd(Map<String, Object> params) {
    	return bookDetailMapper.getBookDtByBookCd(params);
    }
    
    // 예약설정 데이터 수정
	public int updateBookDetail(BookDetail bookDetail) {
		return bookDetailMapper.updateBookDetail(bookDetail);
	}

    // 예약설정 데이터 수정
	public int updateBookDetailByMap(Map<String, Object> params) {
		return bookDetailMapper.updateBookDetailByMap(params);
	}
	
    // 예약설정 데이터 전체오픈
	public int updateOpenAll(BookDetail bookDetail) {
		return bookDetailMapper.updateOpenAll(bookDetail);
	}
	
	// 예약설정 데이터 등록 
	public int insertBookDetail(BookDetail bookDetail) {
		return bookDetailMapper.insertBookDetail(bookDetail);
	}
	
	// 예약설정 데이터 삭제 
	public int deleteBookDetail(BookDetail bookDetail) {
		return bookDetailMapper.deleteBookDetail(bookDetail);
	}

}
