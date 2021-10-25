package com.acorn5.booking.order.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.acorn5.booking.order.entity.Order;

public interface OrderRepository extends JpaRepository<Order, Long>{

}
