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
public class BookDetail {

	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate bookDt;		// 예약일자
	
	private Integer locSeq;			// 지점코드
	private String locNm;
	private Integer roomSeq;		// 회의실코드
	private String roomNm;
	private Integer bookSeq;		// 상세순번

	@JsonFormat(pattern="HH:mm", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="HH:mm")
	private LocalTime strtTm;		// 예약시작시간

	@JsonFormat(pattern="HH:mm", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="HH:mm")
	private LocalTime endTm;		// 예약종료시간
	
	private String bookCd;			// 예약코드
	private Integer bookGroupCd;	// 예약그룹코드 
	private String roomSttsCd;		// 예약상태코드
	private String roomSttsNm;		// 예약상태코드명
	private Integer fee;			// 대여금액
	private String openYn;			// 오픈여부 ( X : 미오픈, O : 오픈 )
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;	// 등록일시
	
	private String regId;			// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;	// 수정일시
	
	private String updId;			// 수정자ID
	private String tel;				// 예약자 연락처
	private String email;			// 예약자 이메일
	private String name;			// 예약자 이름
	
	// 예약페이지에 시간 표출시 필요한 컬럼 
	private Integer groupByCnt;
	
	// 데이터 유무 
	private String settingYn;		// X: 예약설정 데이터 없음,  O: 예약설정 데이터 있음 

}


