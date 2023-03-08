package com.clubd_haeundae.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class BookTemp {

	private String bookCd;		// 회의실코드+년월일시분초 (120220804145805)	
	private	Integer seq;		// 순번
	private	Integer roomSeq;	// 회의실코드
	private String bookDt;		// 예약일자 (2022-08-01 ~ 2022-08-04)
	private String strtTm;		// 예약시작시간
	private String endTm;		// 예약종료시간
	private String excldDt ;	// 제외할날짜 (2022-08-02,2022-08-03)
	private	Integer bookAmt;	// 예약금액
	private String prevCnts;	// 화면에 보여줄 예약 정보

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;		// 등록일시

}


