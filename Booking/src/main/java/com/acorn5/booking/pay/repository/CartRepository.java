package com.acorn5.booking.pay.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.pay.entity.Cart;
import com.acorn5.booking.users.entity.Users;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long>{
	List<Cart> findByUserId(Users id);
	Cart findById(Long id);
}
