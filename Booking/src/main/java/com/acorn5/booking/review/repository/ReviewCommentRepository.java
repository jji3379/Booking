package com.acorn5.booking.review.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.users.entity.Users;

@Repository
public interface ReviewCommentRepository extends JpaRepository<ReviewDtl, Long>{
	
	@Query(value = "SELECT sequence_next_hi_value FROM REVIEW_DTL_SEQ", nativeQuery = true)
	Long findByNextId();

	List<ReviewDtl> findByRefGroup(Review refGroup);

	ReviewDtl findById(Long id);

	List<ReviewDtl> findByWriter(Users id);

	@Transactional
	@Modifying
	@Query(value = "update Review r set r.replyCount = ?1 where r.id = ?2")
	void updateReplyCount(Long replyCount, Long id);
}
