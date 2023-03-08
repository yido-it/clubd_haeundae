package com.clubd_haeundae.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.Book;


@Mapper
@Repository
public interface BookMapper {

	public int getBookIndex();
	
	public List<Book> selectBookList(Map<String, Object> params);
	
	public Book getBook(Book book);

	// 예약 데이터 등록
	public int insertBook(Book book);
	
	// 예약 데이터 수정
	public int updateBook(Book book);
	
	// 예약 데이터 삭제
	public int deleteBook(Book book);
	
}
