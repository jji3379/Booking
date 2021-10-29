package com.acorn5.booking.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.users.entity.Users;

@Repository
public interface UsersRepository extends JpaRepository<Users, Long>{
	Users findById(Long id);
	Users findByLoginId(String loginId);
}
