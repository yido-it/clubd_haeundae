package com.clubd_haeundae.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.clubd_haeundae.model.CmnCode;
import com.clubd_haeundae.model.Location;
import com.clubd_haeundae.model.Room;
import com.clubd_haeundae.repository.CmnCodeMapper;
import com.clubd_haeundae.repository.LocationMapper;
import com.clubd_haeundae.repository.RoomMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RoomService {

	@Autowired
    private RoomMapper roomMapper;
	
	@Autowired
	private CmnCodeMapper commonCodeMapper;
	
	@Autowired
	private LocationMapper locationMapper;

	public List<Room> selectRoomList(Room room) {
		return roomMapper.selectRoomList(room);
	}

	public Room getRoom(Room room) {
		return roomMapper.getRoom(room);
	}

	public int insertRoom(HttpServletRequest req, Room room) {
		CmnCode cmnCode = new CmnCode();
		cmnCode.setCmnNm(room.getCmnNm());
		cmnCode = commonCodeMapper.selectStrToCode(cmnCode);
		
		String roomTpCd = cmnCode.getCmnCd();
		room.setRoomTpCd(roomTpCd);
		
		Location location = new Location();
		location.setName(room.getLocName());
		location = locationMapper.selectStrToCode(location);
		
		int locSeq = location.getLocSeq();
		room.setLocSeq(locSeq);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		room.setRegId(auth.getName());
		
		return roomMapper.insertRoom(room);
	}

	public int updateRoom(Room room) {
		
		CmnCode cmnCode = new CmnCode();
		cmnCode.setCmnNm(room.getCmnNm());
		cmnCode = commonCodeMapper.selectStrToCode(cmnCode);
		
		String roomTpCd = cmnCode.getCmnCd();
		room.setRoomTpCd(roomTpCd);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		room.setUpdId(auth.getName());
		
		return roomMapper.updateRoom(room);
	}

	public int deleteRoom(Room room) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		room.setUpdId(auth.getName());
		return roomMapper.deleteRoom(room);
	}

}
