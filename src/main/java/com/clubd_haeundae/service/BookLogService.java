package com.clubd_haeundae.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.BookLog;
import com.clubd_haeundae.repository.BookLogMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookLogService {

	@Autowired
    private BookLogMapper bookLogMapper;

	public int getLogIndex() throws Exception {
		return bookLogMapper.getLogIndex();
	}

    public List<BookLog> selectBookLogList(Map<String, Object> params) {
    	return bookLogMapper.selectLogList(params);
    }

	public int insertLog(BookLog bookLog) {
		return bookLogMapper.insertLog(bookLog);
	}

}
