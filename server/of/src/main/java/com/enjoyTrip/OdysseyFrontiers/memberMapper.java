package com.enjoyTrip.OdysseyFrontiers;


import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface memberMapper {

	List<memberDto> findAllMember() throws SQLException;

}
