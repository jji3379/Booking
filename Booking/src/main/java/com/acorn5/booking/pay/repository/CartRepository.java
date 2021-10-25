package com.acorn5.booking.pay.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.pay.entity.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long>{

}
