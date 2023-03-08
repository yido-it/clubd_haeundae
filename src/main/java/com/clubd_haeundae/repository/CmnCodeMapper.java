package com.clubd_haeundae.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.CmnCode;

@Mapper
@Repository
public interface CmnCodeMapper {

	public List<CmnCode> selectList(CmnCode code);

	public List<CmnCode> selectTabulatorCombo(CmnCode cmnCode);

	public List<CmnCode> selectTabulatorComboNm(CmnCode cmnCode);

	public CmnCode selectStrToCode(CmnCode cmnCode);
	
}
