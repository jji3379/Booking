package com.acorn5.booking.review.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.entity.ReviewDtl;

@Repository
public interface ReviewCommentRepository extends JpaRepository<ReviewDtl, Long>{
	
	@Query(value = "SELECT AUTO_INCREMENT "
			+ "FROM information_schema.tables "
			+ "WHERE table_name = 'BK_BOOK_REVIEW_DTL' "
				+ "AND table_schema = 'bookingDB'", nativeQuery = true)
	Long findByNextId();
	
	List<ReviewDtl> findByRefGroup(Long refGroup);
	
	ReviewDtl findById(Long id);
}
