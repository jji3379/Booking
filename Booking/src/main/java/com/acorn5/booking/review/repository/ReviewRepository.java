package com.acorn5.booking.review.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.entity.Review;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

	Review findById(Long id);
}
