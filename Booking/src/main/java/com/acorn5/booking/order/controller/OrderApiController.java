package com.acorn5.booking.order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.order.dto.OrderSum;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.repository.OrderRepository;
import com.acorn5.booking.order.service.OrderService;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.UsersRepository;

@RestController
@RequestMapping("/v1")
public class OrderApiController {
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private UsersRepository usersRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	@RequestMapping("/users/myOrder/{id}")
	public List<Order> myOrder(@PathVariable Long id, HttpServletRequest request) {
		//뷰페이지에서 프로필이미지 로드를 위한 로직 
		//id = (Long) session.getAttribute("id");
		Users dto = usersRepository.findById(id); 
				//dao.getData(id);
		//mView.addObject("dto", dto);
		
		//주문내역을 조회하기 위한 로직
		
		//orderService.getMyOrder(session, mView, orderDto, request);
		//mView.setViewName("users/private/my_order");
		return orderService.getMyOrder(id, request);
	}
}
