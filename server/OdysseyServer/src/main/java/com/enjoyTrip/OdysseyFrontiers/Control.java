package com.enjoyTrip.OdysseyFrontiers;

import java.sql.SQLException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/a")
public class Control {
	private final memberMapper memberMapper;

	public Control(memberMapper memberMapper) {
		super();
		this.memberMapper = memberMapper;
	}

	@GetMapping("/join")
	public ResponseEntity<?> join() {
		List<memberDto> list = null;
		try {
			list = memberMapper.findAllMember();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
}
