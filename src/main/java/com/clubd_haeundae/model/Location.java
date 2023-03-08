package com.clubd_haeundae.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Location {

	private Integer locSeq;		// 지점코드
	private String name;		// 지점명
	private String addr;		// 주소
	private String lati;		// 위도
	private String longi;		// 경도
	private String map;			// 지도좌표
	private String tel;			// 전화번호
	private String detailInfo;	// 상세정보

	@JsonFormat(pattern="HH:mm", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="HH:mm")
	private LocalTime strtTm;		// 평일운영시작시간

	@JsonFormat(pattern="HH:mm", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="HH:mm")
	private LocalTime endTm;		// 평일운영종료시간
	
	private String expln;			// 지점설명
	private Double area;			// 면적
	private Integer roomCnt;		// 회의실수
	private String bookGuide;		// 예약안내
	private String cnclGuide;		// 취소환불규정
	private String cmpyTp;			// 그레이프/그레이프라운지구분
	private String bankNm;			// 견적서은행
	private String accntNo;			// 견적서계좌번호
	private Integer ord;			// 정렬순서
	private String useYn;			// 사용여부

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;		// 등록일시
	
	private String regId;			// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;		// 수정일시
	
	private String updId;			// 수정자ID
	private String label;			// 콤보박스용 label
	private String value;			// 콤보박스용 value
	private String adminId;			// 관리자ID
	private String adminAuth;		// 관리자권한
	
	private String filePath1;		// 대표이미지
	private String filePath2;		// 대표이지미 썸네일
	
	private String estCorpnm;		// 견적서 상호명
	private String estCorpno;		// 견적서 사업자등록번호
	private String estEmpNm;		// 담당자명
	private String estEmail;		// 담당자 이메일
	private String estTel;			// 담당자 연락처

}


