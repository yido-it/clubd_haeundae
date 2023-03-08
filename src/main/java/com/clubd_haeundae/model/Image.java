package com.clubd_haeundae.model;


import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Image {
	
	private Integer imgSeq;		// 이미지순번
	private String filePath1;	// 원본파일경로
	private String filePath2; 	// 축소파일경로
	private Integer locSeq;		// 지점코드
	private Integer roomSeq;	// 회의실코드
	private Integer ord;		// 정렬순서
	private String flrPlanYn;	// 평면도여부
	private String useYn;		// 사용여부

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDt;		// 등록일시
	
	private String regId;			// 등록자ID
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updDt;		// 수정일시
	
	private String updId;			// 수정자ID

	private String locName;		// 지점명
	private String roomName;	// 회의실명
	private String getLocYn;	
	private String getRoomYn;	
}


