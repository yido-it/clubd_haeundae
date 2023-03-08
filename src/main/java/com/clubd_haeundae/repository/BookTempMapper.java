package com.clubd_haeundae.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.BookTemp;


@Mapper
@Repository
public interface BookTempMapper {

	public int getBookTempIndex();

	public List<BookTemp> selectBookTemp(BookTemp bkTemp);

	public Map<String, Object> getTotalAmt(BookTemp bkTemp);
	
	public int insertBookTemp(BookTemp bkTemp);

	public int deleteBookTemp(BookTemp bkTemp);
}
