package com.acorn5.booking.review.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.entity.ReviewDtl;

@Repository
public interface ReviewCommentRepository extends JpaRepository<ReviewDtl, Long>{
	
	@Query(value = "SELECT MAX(review_comment_id)+1 FROM BK_BOOK_REVIEW_DTL", nativeQuery = true)
	Long findByNextId();
	
	List<ReviewDtl> findByRefGroup(Long refGroup);
	
	ReviewDtl findById(Long id);
}
