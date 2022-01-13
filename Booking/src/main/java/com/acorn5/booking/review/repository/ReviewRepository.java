package com.acorn5.booking.review.repository;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.users.entity.Users;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

	Review findById(Long id);
	List<Review> findByIsbn(String isbn);

	List<Review> findByWriter(Users id);
	
	@Query(value = "select r from Review r join fetch r.writer")
	List<Review> findAllReivew();

	@Query(value = "select r from Review r join fetch r.writer where r.id = ?1")
	Review findReviewDetail(Long id);
	
	@Transactional
	@Modifying
	@Query(value = "update Review r set r.viewCount = r.viewCount + 1 where r.id = ?1")
	void addViewCount(Long id);
}
