package com.clubd_haeundae.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.clubd_haeundae.model.CmnCode;
import com.clubd_haeundae.service.CmnCodeService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class CmnCodeController {

	@Autowired
	private CmnCodeService cmnCodeService;

	@RequestMapping("/getRroomSttsList")   
	@ResponseBody
	public List<CmnCode> getRoomSttsList(Model model, HttpServletRequest req) {
		
		CmnCode cmnCode = new CmnCode();
		cmnCode.setUpCd("400");
		List<CmnCode> list = cmnCodeService.selectTabulatorCombo(cmnCode);
		return list;
	}
	
	@RequestMapping("/getCmnCdList/{upCd}")   
	@ResponseBody
	public List<CmnCode> geCmnCdList(@PathVariable String upCd) {
		
		CmnCode cmnCode = new CmnCode();
		cmnCode.setUpCd(upCd);
		List<CmnCode> list = cmnCodeService.selectTabulatorCombo(cmnCode);
		return list;
	}
	
	@RequestMapping("/getCmnNmList/{upCd}")   
	@ResponseBody
	public List<CmnCode> geCmnNmList(@PathVariable String upCd) {
		
		CmnCode cmnCode = new CmnCode();
		cmnCode.setUpCd(upCd);
		List<CmnCode> list = cmnCodeService.selectTabulatorComboNm(cmnCode);
		return list;
	}

}
