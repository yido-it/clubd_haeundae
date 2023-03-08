package com.clubd_haeundae.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Fee {

	private Integer locSeq;		// 지점코드
	private Integer roomSeq;	// 회의싦코드
	private Integer feeSeq;		// 요금순번

	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate strtDt;		// 요금적용시작일자

	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate endDt;		// 요금적용종료일자
	
	private Integer basicHr;		// 기본시간	
	private Integer basicFee;		// 기본시간당요금
	private Integer overHr;			// 초과시간
	private	Integer overFee;		// 초과시간당요금
	private Integer nightFee;		// 야간요금 (18~22) 화면에 보여주는 용도의 컬럼 
	private String useYn;			// 사용여부

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;		// 등록일시
	
	private String regId;			// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;		// 수정일시
	
	private String updId;			// 수정자ID
	
	private String locNm;			// 지점명
	private String roomNm;			// 회의실명
	private Integer capacity;		// 수용인원

}


