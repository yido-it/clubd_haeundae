package com.clubd_haeundae.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.CmnCode;
import com.clubd_haeundae.repository.CmnCodeMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CmnCodeService {

	@Autowired
    private CmnCodeMapper commonCodeMapper;

    public List<CmnCode> selectList(CmnCode code){
    	return commonCodeMapper.selectList(code);
    }

	public List<CmnCode> selectTabulatorCombo(CmnCode cmnCode) {
		return commonCodeMapper.selectTabulatorCombo(cmnCode);
	}

	public List<CmnCode> selectTabulatorComboNm(CmnCode cmnCode) {
		return commonCodeMapper.selectTabulatorComboNm(cmnCode);
	}
    
}
