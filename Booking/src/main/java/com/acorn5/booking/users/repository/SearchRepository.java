package com.acorn5.booking.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.users.entity.Search;

@Repository
public interface SearchRepository extends JpaRepository<Search, Long>{
	
}
