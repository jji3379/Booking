package com.acorn5.booking.order.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.order.dao.OrderDao;
import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.order.dto.OrderSum;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;
import com.acorn5.booking.order.entity.QOrder;
import com.acorn5.booking.order.entity.QOrderDtl;
import com.acorn5.booking.order.repository.OrderDtlRepository;
import com.acorn5.booking.order.repository.OrderRepository;
import com.acorn5.booking.review.dao.ReviewDao;
import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.review.entity.QReview;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.users.entity.QUsers;
import com.acorn5.booking.users.entity.Users;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class OrderServiceImpl implements OrderService {
	//@Autowired
	//private OrderDao dao;
	
	@PersistenceContext
	EntityManager em;
	
	//@Autowired
	//private ReviewDao reviewDao;
	
	@Autowired
	private OrderDtlRepository orderDtlRepository; 

	@Autowired
	private OrderRepository orderRepository; 
	
	//by욱현, my_order에 테이블에 담기_210317
	@Override
	public OrderDtl orderInsert(OrderDtl dto, HttpServletRequest request) {
		// 전송된 파라미터들을 받는다.
		// form 으로 전송하면 안되는건가???
		/*
		Long id = Long.parseLong(request.getParameter("o_id"));
		Long buyer = Long.parseLong(request.getParameter("buyer"));
		String image = request.getParameter("image");
		String title = request.getParameter("title");
		int price = Integer.parseInt(request.getParameter("price"));
		int d_price = Integer.parseInt(request.getParameter("d_price"));
		int count = Integer.parseInt(request.getParameter("count"));
		String isbn = request.getParameter("isbn");
		*/
		// dto객체에 담기
		/*
		dto.setId(id);
		dto.setBuyer(buyer);
		dto.setImage(image);
		dto.setTitle(title);
		dto.setPrice(price);
		dto.setD_price(d_price);
		dto.setCount(count);
		dto.setIsbn(isbn);
		*/
		Users users = new Users();
		Long loginId=(Long)request.getSession().getAttribute("id");
		Order order = new Order();
		if(loginId != null) {
			users.setId(loginId);
			order.setBuyer(users);
			//dto.setBuyer(users);
			//dto객체 전달해서 db수정
		}
		Order newOrder = orderRepository.save(order);
		dto.setOrderNum(newOrder);
		return orderDtlRepository.save(dto);
		//dao.insertOrder(dto);
	}

	//by욱현, my_order에서 구매자 주문내역 불러오기 로직 _2021317
	@Override
	public Page<Order> getMyOrder(Long id, HttpServletRequest request, Pageable pageable) {
		
		//Long id = (Long) session.getAttribute("id");
		//회원의 주문내역 전체 얻기 
		Users buyerId = new Users();
		buyerId.setId(id);
		//List<Order> list = orderDtlRepository.findByBuyer(buyerId); 
				//dao.getMyOrder((String)session.getAttribute("id"));
		//주문번호 끼리 묶기
		//List<OrderSum> orderList = new ArrayList<OrderSum>();
		//orderRepository.findByBuyer(buyerId);

		pageable = new PageRequest(pageable.getPageNumber(), 5, pageable.getSort());		
		JPAQueryFactory query = new JPAQueryFactory(em);
		//QOrderDtl qOrderDtl = QOrderDtl.orderDtl;
		QOrder qOrder = QOrder.order;
		QUsers qUsers = QUsers.users;
		
		QueryResults<Order> orderList = query.selectFrom(qOrder)
				.join(qOrder.buyer, qUsers)
				.fetchJoin()
				.where(qOrder.buyer.eq(buyerId))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();

		return new PageImpl<Order>(orderList.getResults(), pageable, orderList.getTotal());
	}
	
	//by욱현, order_detail에서 주문내역 디테일 불러오는 로직_2021320
	@Override
	public List<OrderDtl> getOrderDetail(Long orderId) {
		
		Order order = new Order();
		order.setId(orderId);
		// 이거 수정해야됨
		List<OrderDtl> list = orderDtlRepository.findByOrderNum(order);
		return list;
	}
}
