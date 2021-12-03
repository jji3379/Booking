package com.acorn5.booking.users.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.service.UsersService;

@RestController
@RequestMapping("/v1")
public class UsersApiController {
	
	@Autowired
	private UsersService usersService;
	
	@RequestMapping(value = "/users/login", method = RequestMethod.POST)
	public Users login(HttpServletRequest request,
			HttpServletResponse response,
			@RequestBody Users users) {
		//로그인에 관련된 로직을 서비스를 통해서 처리한다.
		usersService.loginLogic(request, response, users);
		//view page  로 forward  이동해서 응답
		return usersService.loginLogic(request, response, users);
	}
}
