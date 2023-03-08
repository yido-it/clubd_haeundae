package com.clubd_haeundae.model;


import java.io.Serializable;
import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.userdetails.User;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class Common implements Serializable {
	
	private static final long serialVersionUID = -2877126382111684097L;
	
	private Integer start;
	private Integer length;
	
	protected Integer offset;
	protected Integer pageSize;
	
	//검색조건일자
    private String searchStartDt;
    private String searchEndDt;
    private String searchWord;
    
	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	protected LocalDate regDt;
	
	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	protected LocalDate updDt;
	
	private String regId;
	private String updId;
	
	
	
}
