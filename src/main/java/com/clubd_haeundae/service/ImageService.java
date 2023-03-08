package com.clubd_haeundae.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.Image;
import com.clubd_haeundae.repository.ImageMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ImageService {
	@Autowired
    private ImageMapper imageMapper;

	public int insertImage(Image image) {
		return imageMapper.insertImage(image);
	}

	public List<Image> selectImageList(Image image) {
		return imageMapper.selectImageList(image);
	}

	public List<Image> imgListByMap(Map<String, Object> params) {
		return imageMapper.imgListByMap(params);
	}
	
	public int deleteImage(Image image) {
		return imageMapper.deleteImage(image);
	}

	public int changeImageOrd(Image img) {
		
		if(img.getOrd() == 0) {
			imageMapper.changeImageOther(img);
		}
		
		return imageMapper.changeImageOrd(img);
	}
	
	public int updateImage(Image image) {
		return imageMapper.updateImage(image);
	}
}