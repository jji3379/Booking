package com.acorn5.booking.order.service;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;
import com.acorn5.booking.order.entity.QOrder;
import com.acorn5.booking.order.repository.OrderDtlRepository;
import com.acorn5.booking.order.repository.OrderRepository;

import com.acorn5.booking.users.entity.QUsers;
import com.acorn5.booking.users.entity.Users;
import com.querydsl.core.QueryResults;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class OrderServiceImpl implements OrderService {

	@PersistenceContext
	EntityManager em;
	
	@Autowired
	private OrderDtlRepository orderDtlRepository; 

	@Autowired
	private OrderRepository orderRepository; 
	
	@Override
	public List<OrderDtl> orderInsert(List<OrderDtl> dto, HttpServletRequest request) {

		Users users = new Users();
		Long loginId = (Long) request.getSession().getAttribute("id");
		Order order = new Order();
		int orderCount = 0;
		if (loginId != null) {
			users.setId(loginId);
			order.setBuyer(users);
			order.setTotalPrice(dto.get(0).getTotalPrice());
			for (int i = 0; i < dto.size(); i++) {
				orderCount += dto.get(i).getCount();
			}
			order.setOrderCount(orderCount);
		}
		Order newOrder = orderRepository.save(order);
		for (int i = 0; i < dto.size(); i++) {
			dto.get(i).setOrderNum(newOrder);
			orderDtlRepository.save(dto.get(i));
		}
		return dto;
	}

	@Override
	public List<OrderDtl> getOrderDetail(Long orderId) {
		Order order = new Order();
		order.setId(orderId);
		List<OrderDtl> list = orderDtlRepository.findByOrderNum(order);
		
		return list;
	}

	@Override
	public Page<Order> getMyOrder(Long id, HttpServletRequest request, Pageable pageable) {
		Users buyerId = new Users();
		buyerId.setId(id);

		pageable = new PageRequest(pageable.getPageNumber(), 5, pageable.getSort());		
		JPAQueryFactory query = new JPAQueryFactory(em);
		QOrder qOrder = QOrder.order;
		QUsers qUsers = QUsers.users;
		
		QueryResults<Order> orderList = query.selectFrom(qOrder)
				.join(qOrder.buyer, qUsers)
				.fetchJoin()
				.where(qOrder.buyer.eq(buyerId))
				.orderBy(qOrder.id.desc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();

		return new PageImpl<Order>(orderList.getResults(), pageable, orderList.getTotal());
	}

	@Override
	public Page<Order> getMyTermOrder(Long id, HttpServletRequest request, Pageable pageable, Date startDate,
			Date endDate) {
		
		Users buyerId = new Users();
		buyerId.setId(id);

		pageable = new PageRequest(pageable.getPageNumber(), 5, pageable.getSort());		
		JPAQueryFactory query = new JPAQueryFactory(em);
		QOrder qOrder = QOrder.order;
		QUsers qUsers = QUsers.users;
		
		QueryResults<Order> orderList = query.selectFrom(qOrder)
				.join(qOrder.buyer, qUsers)
				.fetchJoin()
				.where(qOrder.buyer.eq(buyerId)
						.and(qOrder.regdate.between(startDate, endDate)))
				.orderBy(qOrder.id.desc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();

		return new PageImpl<Order>(orderList.getResults(), pageable, orderList.getTotal());
	}
}