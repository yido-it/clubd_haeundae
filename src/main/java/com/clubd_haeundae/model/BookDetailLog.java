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
public class BookDetailLog {

	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate bookDt;		// 예약일자
	
	private Integer locSeq;				// 지점코드
	private String locNm;				// 지점이름 
	private Integer roomSeq;			// 회의실코드
	private String roomNm;				// 회의실이름 
	private Integer bookSeq;			// 상세순번
	private Integer logSeq;				// 이력순번

	@JsonFormat(pattern="HH:mm", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="HH:mm")
	private LocalTime strtTm;		// 예약시작시간

	@JsonFormat(pattern="HH:mm", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="HH:mm")
	private LocalTime endTm;		// 예약종료시간
	
	private String bookCd;			// 예약코드
	private Integer bookGroupCd;	// 예약그룹코드 
	private String roomSttsCd;		// 예약상태코드
	private Integer fee;			// 대여금액
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;		// 등록일시
	
	private String regId;			// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;		// 수정일시
	
	private String updId;			// 수정자ID
	private String useYn;		 	// Y: 등록/변경 , N: 취소
	
	private String name;	// 예약자이름
	private String email;	// 예약자이메일
	private String tel;	// 예약자연락처
}


