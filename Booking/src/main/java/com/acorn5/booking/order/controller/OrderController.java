package com.acorn5.booking.order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.order.dto.OrderSum;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.repository.OrderRepository;
import com.acorn5.booking.order.service.OrderService;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.UsersRepository;

@Controller
public class OrderController {
	@Autowired
	private OrderService orderService;
	
	//@Autowired //by욱현. 주문내역 페이지 에서도 프로필이미지를 볼수있게 하기위해_2021317
	//UsersDao dao;
	
	@Autowired
	private UsersRepository usersRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private CartService cartservice;
	
	//by욱현. 결제한 책들을 my_order 테이블에 저장하기_2021317
	@RequestMapping(value = "/pay/orderInsert", method = RequestMethod.POST)
	public ResponseEntity<Order> orderInsert(@RequestBody Order dto, HttpServletRequest request) {
		//dto객체 전달해서 db수정
		//orderRepository.save(dto);
		Order order = orderService.orderInsert(dto, request);
		return ResponseEntity.ok(order);
	}
	
	//by욱현.내 주문 내역 조회_2021316
	@RequestMapping("/users/myOrder/{id}")
	public List<Order> myOrder(@PathVariable Long id,
		HttpServletRequest request) {
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
	//by욱현. 주문조회 디테일 페이지
		@RequestMapping("/users/private/my_order.do")
		public ModelAndView my_order(HttpSession session, ModelAndView mView,
				HttpServletRequest request) {
			//뷰페이지에서 프로필이미지 로드를 위한 로직 
			Long id = (Long) session.getAttribute("id");
			if (id != null) {
				// by 우석, view page 에서 cartitem 불러오기_210315
				cartservice.listCart(mView, request);
			}
			Users dto = usersRepository.findById(id);  
					//dao.getData(id);
			mView.addObject("dto", dto);
			
			
			mView.setViewName("users/private/my_order.page");
			return mView;
		}
	//by욱현. 주문조회 디테일 페이지
	@RequestMapping("/users/private/order_detail.do")
	public ModelAndView orderDetail(HttpSession session, ModelAndView mView,
			HttpServletRequest request) {
		//뷰페이지에서 프로필이미지 로드를 위한 로직 
		Long id = (Long) session.getAttribute("id");
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
		Users dto = usersRepository.findById(id);  
				//dao.getData(id);
		mView.addObject("dto", dto);
		mView.setViewName("users/private/order_detail.page");
		return mView;
	}
	
	
}