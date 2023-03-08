package com.clubd_haeundae.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.Book;
import com.clubd_haeundae.repository.BookMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookService {

	@Autowired
    private BookMapper bookMapper;

	public int getBookIndex() throws Exception {
		return bookMapper.getBookIndex();
	}

    public List<Book> selectBookList(Map<String, Object> params) {
    	return bookMapper.selectBookList(params);
    }

    public Book getBook(Book book) {
    	return bookMapper.getBook(book);
    }

	// 예약 데이터 등록 
	public int insertBook(Book book) {
		return bookMapper.insertBook(book);
	}
	
    // 예약데이터 수정
	public int updateBook(Book book) {
		return bookMapper.updateBook(book);
	}

    // 예약데이터 삭제
	public int deleteBook(Book book) {
		return bookMapper.deleteBook(book);
	}
}
