package com.clubd_haeundae.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.Contact;

@Mapper
@Repository
public interface ContactMapper {

	public Contact getContact(Contact cont);
}
