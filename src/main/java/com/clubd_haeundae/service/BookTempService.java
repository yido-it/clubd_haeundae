package com.clubd_haeundae.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.BookTemp;
import com.clubd_haeundae.repository.BookTempMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookTempService {

	@Autowired
    private BookTempMapper bkTempMapper;

	public int getBookTempIndex() throws Exception {
		return bkTempMapper.getBookTempIndex();
	}

    public List<BookTemp> selectBookTemp(BookTemp bkTemp) {
    	return bkTempMapper.selectBookTemp(bkTemp);
    }

    public Map<String, Object> getTotalAmt(BookTemp bkTemp) {
    	return bkTempMapper.getTotalAmt(bkTemp);
    }

	public int insertBookTemp(BookTemp bkTemp) {
		return bkTempMapper.insertBookTemp(bkTemp);
	}

	public int deleteBookTemp(BookTemp bkTemp) {
		return bkTempMapper.deleteBookTemp(bkTemp);
	}
}
