package com.clubd_haeundae.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Tour {

	private Integer tourSeq;		// 투어순번
	private Integer locSeq;			// 지점코드
	private String  locName;		// 지점명

	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate tourDt;		// 투어일자
	
	private String tourTm;		// 투어시간
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime reqDt;		// 신청일시
	
	private String reqNm;		// 신청자이름
	private String reqInfo;		// 신청자소속
	private	String reqEmail;	// 신청자이메일
	private String reqTel;		// 신청자연락처
	private String reqSttsCd;	// 신청상태코드
	private String reqSttsNm;	// 신청상태명
	private String reqCnts;		// 신청요청사항
	
	private String regId;			// 등록자ID
	private String updId;			// 수정자ID
	
	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate searchStrtDt;		// 조회시작일
	
	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate searchEndDt;		// 조회종료일
}


