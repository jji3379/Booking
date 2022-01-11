package com.acorn5.booking.users.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;

@Repository
public interface SearchRepository extends JpaRepository<Search, Long>{
	List<Search> findByUserId(Users id);
}
