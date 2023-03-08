package com.clubd_haeundae.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubd_haeundae.model.Room;

@Mapper
@Repository
public interface RoomMapper {

	public List<Room> selectRoomList(Room room);
	
	public Room getRoom(Room room);

	public int insertRoom(Room room);

	public int updateRoom(Room room);
	
	public int deleteRoom(Room room);
}
