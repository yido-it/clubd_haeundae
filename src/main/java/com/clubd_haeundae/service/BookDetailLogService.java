package com.clubd_haeundae.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.BookDetailLog;
import com.clubd_haeundae.repository.BookDetailLogMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookDetailLogService {

	@Autowired
    private BookDetailLogMapper bkDetailLogMapper;

	// LOG_SEQ
	public int getBkLogIdx() throws Exception {
		return bkDetailLogMapper.getBkLogIdx();
	}
	
	// getBkLogGroupCd
	public int getBkLogGroupCd() throws Exception {
		return bkDetailLogMapper.getBkLogGroupCd();
	}

    public List<BookDetailLog> selectBookDetailLog(BookDetailLog bookDetailLog) {
    	return bkDetailLogMapper.selectBookDetailLog(bookDetailLog);
    }
    
    // 예약상세이력
    public List<BookDetailLog> selectLogByMap(Map<String, Object> params) {
    	return bkDetailLogMapper.selectLogByMap(params);
    }

    // 예약상세이력 (Group By)
    public List<BookDetailLog> groupByListByMap(Map<String, Object> params) {
    	return bkDetailLogMapper.groupByListByMap(params);
    }

    // 예약결과
    public List<Map<String, Object>> selectBookResult(Map<String, Object> params) {
    	return bkDetailLogMapper.selectBookResult(params);
    }

    public BookDetailLog getBookDetailLog(BookDetailLog bookDetailLog) {
    	return bkDetailLogMapper.getBookDetailLog(bookDetailLog);
    }
    
	// 예약로그 데이터 등록 
	public int insertBkDetailLog(BookDetailLog bookDetailLog) {
		return bkDetailLogMapper.insertBkDetailLog(bookDetailLog);
	}
	
	// 예약로그 데이터 수정 
	public int updateBkDetailLog(BookDetailLog bookDetailLog) {
		return bkDetailLogMapper.updateBkDetailLog(bookDetailLog);
	}

	// 예약로그 데이터 삭제 
	public int deleteBkDetailLog(BookDetailLog bookDetailLog) {
		return bkDetailLogMapper.deleteBkDetailLog(bookDetailLog);
	}
}
