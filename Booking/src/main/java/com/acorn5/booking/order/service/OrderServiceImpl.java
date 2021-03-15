package com.acorn5.booking.order.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn5.booking.order.dao.OrderDao;
import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.pay.dto.CartDto;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDao OrderDao;
	
	//by준영, 장바구니 담기(저장) 처리_210308
		@Override
		public void insertCart(OrderDto dto,HttpServletRequest request) {
			String id=(String)request.getParameter("id");
			String image=(String)request.getParameter("image");
			String title=(String)request.getParameter("title");
			int price=Integer.parseInt(request.getParameter("price"));
			int d_price=Integer.parseInt(request.getParameter("d_price"));
			int count=Integer.parseInt(request.getParameter("count"));
			dto.setBuyer(id);
			dto.setImage(image);
			dto.setTitle(title);
			dto.setD_price(d_price);
			dto.setPrice(d_price);
			dto.setCount(count);
			OrderDao.insertOrder(dto);	
		}
}
