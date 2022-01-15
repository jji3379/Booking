package com.acorn5.booking.order.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;
import com.acorn5.booking.users.entity.Users;

@Repository
public interface OrderDtlRepository extends JpaRepository<OrderDtl, Long>{

	List<OrderDtl> findById(Long id);
	List<OrderDtl> findByOrderNum(Order orderNum);
	
}
