package com.acorn5.booking.review.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.entity.Review;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

	Review findById(Long id);
	
	@Query(value = "select r from Review r join fetch r.writer")
	List<Review> findAllReivew();
}
