package com.acorn5.booking.order.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.cart.service.CartService;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;
import com.acorn5.booking.order.service.OrderService;

@RestController
@RequestMapping("/v1")
public class OrderApiController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;

	// 유저 주문 정보 조회 api
	@GetMapping(value = "/user/{id}/order")
	public Page<Order> getOrder(@PathVariable Long id, HttpServletRequest request, Pageable pageable)
			throws ParseException {
		
		return orderService.getMyOrder(id, request, pageable);
	}
	
	// 유저 기간별 주문 조회 api
	@GetMapping(value = "/user/{id}/order/{startDate}/{endDate}")
	public Page<Order> getTermOrder(@PathVariable Long id, HttpServletRequest request, Pageable pageable,
			@PathVariable String startDate, @PathVariable String endDate) throws ParseException {

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate2 = dateFormat.parse(startDate);
		Date endDate2 = dateFormat.parse(endDate);

		return orderService.getMyTermOrder(id, request, pageable, startDate2, endDate2);
	}

	// 주문 상세 조회 api
	@GetMapping("/user/{id}/order/{orderId}")
	public List<OrderDtl> getOrderDetail(@PathVariable Long id, @PathVariable Long orderId) {

		return orderService.getOrderDetail(orderId);
	}

	// 결제 완료 시 장바구니 삭제 및 주문정보 등록 api
	@PostMapping(value = "/pay/order")
	public ResponseEntity<List<OrderDtl>> insertOrder(@RequestBody List<OrderDtl> dto, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("id");
		cartService.deletPay(id, request);
		List<OrderDtl> order = orderService.orderInsert(dto, request);

		return ResponseEntity.ok(order);
	}
}
