package com.clubd_haeundae.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.BookLog;

@Mapper
@Repository
public interface BookLogMapper {

	public int getLogIndex();
	
	public List<BookLog> selectLogList(Map<String, Object> params);
	
	public int insertLog(BookLog bookLog);
}
