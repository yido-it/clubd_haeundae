package com.clubd_haeundae.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Contact {

	private Integer contSeq;		// 대표연락처순번
	private String tel;				// 대표연락처
	private String email;			// 대표메일
	private String addr;			// 대표주소
	private String useYn;			// 사용여부

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;	// 등록일시
	
	private String regId;			// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;	// 수정일시
	
	private String updId;			// 수정자ID
}


