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
	
	@Query(value = "SELECT MAX(review_comment_id)+1 FROM BK_BOOK_REVIEW_DTL", nativeQuery = true)
	Long findByNextId();
	
	List<ReviewDtl> findByRefGroup(Review refGroup);
	
	ReviewDtl findById(Long id);

	List<ReviewDtl> findByWriter(Users id);
	
	@Transactional
	@Modifying
	@Query(value = "update Review r set r.replyCount = ?1 where r.id = ?2")
	void updateReplyCount(Long replyCount, Long id);
}
