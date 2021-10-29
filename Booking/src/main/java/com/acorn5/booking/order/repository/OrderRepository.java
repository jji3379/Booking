package com.acorn5.booking.order.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.users.entity.Users;

public interface OrderRepository extends JpaRepository<Order, Long>{

	List<Order> findByBuyer(Long buyer);
	List<Order> findById(Long id);
}
