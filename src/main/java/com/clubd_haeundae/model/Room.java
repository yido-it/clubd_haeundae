package com.clubd_haeundae.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Room {

	private Integer locSeq;		// 지점코드
	private String locName;		// 지점코드명
	private Integer roomSeq;	// 회의실코드
	private String name;		// 회의실명
	private String roomTpCd;	// 회의실타입코드
	private String cmnNm;		// 회의실타입
	private Integer capacity;	// 수용인원
	private String expln;		// 회의실설명
	private String guide;		// 시설안내
	private Integer roomOrd;		// 회의실 정렬순서
	private String useYn;			// 사용여부

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;		// 등록일시
	
	private String regId;			// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;		// 수정일시
	
	private String updId;			// 수정자ID
	
	private String filePath1;		// 원본파일경로
	private String filePath2;		// 축소파일경로
	private String flrFilePath1;	// 평면도 원본파일경로
	private String flrFilePath2;    // 평면도 축소파일경로
	private String flrPlanYn;		// 평면도 여부
	private String imgOrg;			// 이미지 정렬순서
	private Integer basicFee;		// 기본요금
	private String adminId;			// 관리자ID
	private Integer nightFee;		// 야간요금 (18~22) 화면에 보여주는 용도의 컬럼 

}


