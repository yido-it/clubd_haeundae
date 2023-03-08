package com.clubd_haeundae.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.Contact;
import com.clubd_haeundae.repository.ContactMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ContactService {

	@Autowired
    private ContactMapper contMapper;

	public Contact getContact(Contact cont) {
		return contMapper.getContact(cont);
	} 
}
