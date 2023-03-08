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
public class Book {

	private String bookCd;		// 예약코드	
	private Integer locSeq;		// 지점코드	
	private String locNm;		// 지점코드
	private String name;		// 예약자명
	private String email;		// 예약자이메일 (암호화)
	private String tel;			// 예약자연락처 (암호화)

	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate bookStrtDt;		// 예약시작일자

	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate bookEndDt;		// 예약종료일자
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime bookReqDt;		// 예약신청일자

	private String bookSttsCd;			// 예약상태코드
	private String bookSttsNm;			// 예약상태명
	private	Integer bookAmt;			// 예약금액
	private	Integer dcAmt;				// 할인금액
	private Integer payAmt;				// 결제금액
	private String reqCnts;				// 요청내용
	private String useYn;				// 사용여부

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;		// 등록일시
	
	private String regId;				// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;		// 수정일시
	
	private String updId;				// 수정자ID
	
	private String bankNm;				// 은행
	private String accntNo;				// 계좌번호
	private String cmpyTp;				// 예금주
	
}


