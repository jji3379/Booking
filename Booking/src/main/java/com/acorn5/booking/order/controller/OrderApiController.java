package com.acorn5.booking.order.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.order.DateDto;
import com.acorn5.booking.order.dto.OrderSum;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;
import com.acorn5.booking.order.repository.OrderDtlRepository;
import com.acorn5.booking.order.service.OrderService;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.UsersRepository;

@RestController
@RequestMapping("/v1")
public class OrderApiController {
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "/users/myOrder/{id}" ,method = RequestMethod.POST)
	public Page<Order> myTermOrder(@PathVariable Long id, HttpServletRequest request, Pageable pageable, @RequestBody DateDto dateDto) throws ParseException {

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate2 = dateFormat.parse(dateDto.getStartDate());
		Date endDate2 = dateFormat.parse(dateDto.getEndDate());

		return orderService.getMyTermOrder(id, request, pageable, startDate2, endDate2);
	}
	
	@RequestMapping(value = "/users/myOrder/{id}" ,method = RequestMethod.GET)
	public Page<Order> termMyOrder(@PathVariable Long id, HttpServletRequest request, Pageable pageable) throws ParseException {

		return orderService.getMyOrder(id, request, pageable);
	}
	
	@RequestMapping("/users/myOrder/detail/{id}")
	public List<OrderDtl> myOrderDetail(@PathVariable Long id) {

		return orderService.getOrderDetail(id);
	}
}
