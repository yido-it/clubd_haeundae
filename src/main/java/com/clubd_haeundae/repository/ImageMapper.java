package com.clubd_haeundae.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.Image;

@Mapper
@Repository
public interface ImageMapper {

	int insertImage(Image image);

	List<Image> selectImageList(Image image);
	
	List<Image> imgListByMap(Map<String, Object> params);

	int deleteImage(Image image);

	int changeImageOrd(Image img);

	int changeImageOther(Image img);
	
	int updateImage(Image img);

}
