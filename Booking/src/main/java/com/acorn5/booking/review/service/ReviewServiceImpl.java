package com.acorn5.booking.review.service;

import java.io.File;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.acorn5.booking.review.entity.QReview;
import com.acorn5.booking.review.entity.QReviewDtl;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.review.repository.ReviewCommentRepository;
import com.acorn5.booking.review.repository.ReviewRepository;
import com.acorn5.booking.users.entity.QUsers;
import com.acorn5.booking.users.entity.Users;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@PersistenceContext
	EntityManager em;
	
	@Autowired
	private ReviewRepository reviewRepository;

	@Autowired
	private ReviewCommentRepository reviewCommentRepository;
	
	@Override
	public Review saveContent(Review dto) {
		dto.setReplyCount((long) 0);
		Review newReview = reviewRepository.save(dto);
		
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		QReview qReview = QReview.review;
		
		Double ratingAvg = queryFactory.select(qReview.rating.avg())
				.from(qReview)
				.where(qReview.isbn.eq(dto.getIsbn()))
				.fetchOne();
		
		reviewRepository.updateRatingAvg(ratingAvg, dto.getIsbn());
		
	    return newReview;
	}
	
	@Override
	@Transactional
	public Page<Review> getList(HttpServletRequest request, Pageable pageable) {
		QReview qReview = QReview.review;
		QUsers qUsers = QUsers.users;
		
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		pageable = new PageRequest(pageable.getPageNumber(), 8, pageable.getSort());
		
		OrderSpecifier<?> orderCondition = null;
		if (pageable.getSort() != null && pageable.getSort().toString().contains("viewCount")) {
			orderCondition = qReview.viewCount.desc(); // 조회순 정렬
		} else if (pageable.getSort() != null && pageable.getSort().toString().contains("rating")) {
			orderCondition = qReview.rating.desc(); // 별점순 정렬
		} else if (pageable.getSort() == null || pageable.getSort().toString().contains("regdate")
				|| orderCondition == null) {
			orderCondition = qReview.regdate.desc(); // 최신순 정렬
		}
		
		QueryResults<Review> list = queryFactory.selectFrom(qReview)
				.join(qReview.writer, qUsers)
				.fetchJoin()
				.orderBy(orderCondition, qReview.regdate.desc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
			
		return new PageImpl<Review>(list.getResults(), pageable, list.getTotal());
	}
	
	@Override
	public Page<Review> getConditionSearchList(HttpServletRequest request, Pageable pageable, String condition, String keyword) {

		if(keyword==null){
			keyword="";
			condition=""; 
		}
		
		QReview qReview = QReview.review;
		QUsers qUsers = QUsers.users;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		pageable = new PageRequest(pageable.getPageNumber(), 8, pageable.getSort());
		OrderSpecifier<?> orderCondition = null;
		if (pageable.getSort() != null && pageable.getSort().toString().contains("viewCount")) {
			orderCondition = qReview.viewCount.desc(); // 조회순 정렬
		} else if (pageable.getSort() != null && pageable.getSort().toString().contains("rating")) {
			orderCondition = qReview.rating.desc(); // 별점순 정렬
		} else if (pageable.getSort() == null || pageable.getSort().toString().contains("regdate")
				|| orderCondition == null) {
			orderCondition = qReview.regdate.desc(); // 최신순 정렬
		}
		
		BooleanBuilder builder = new BooleanBuilder();
		
		if (condition.equals("bookTitle_content")) { // 제목, 내용 검색
			builder.and(qReview.bookTitle.contains(keyword))
					.or(qReview.content.contains(keyword));
		} else if (condition.equals("bookTitle")) { // 제목 검색
			builder.and(qReview.bookTitle.contains(keyword));
		} else if (condition.equals("writer")) { // 작성자 검색
			builder.and(qReview.writer.loginId.contains(keyword));
		} else if (condition.equals("isbn")) { // isbn 검색
			builder.and(qReview.isbn.contains(keyword));
		}
		
		QueryResults<Review> list = queryFactory.selectFrom(qReview)
				.join(qReview.writer, qUsers)
				.fetchJoin()
				.where(builder)
				.orderBy(orderCondition, qReview.regdate.desc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
			
		return new PageImpl<Review>(list.getResults(), pageable, list.getTotal());
	}
	
	@Override
	public String saveImage(MultipartFile image, HttpServletRequest request) {
		String orgFileName=image.getOriginalFilename();
		String realPath=request.getServletContext().getRealPath("/upload");
		String filePath=realPath+File.separator;
		File upload=new File(filePath);
		
		if(!upload.exists()) { 
			upload.mkdir(); 
		}
		
		String saveFileName=
				System.currentTimeMillis()+orgFileName;
		try {
			image.transferTo(new File(filePath+saveFileName));
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/upload/"+saveFileName;
	}
	
	@Override
	@Transactional
	public void updateContent(Long id, Review dto) {
		Review review = reviewRepository.findById(id);
		
		review.setReviewTitle(dto.getReviewTitle());
		review.setContent(dto.getContent());
		review.setRating(dto.getRating());
		review.setSpoCheck(dto.getSpoCheck());

		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		QReview qReview = QReview.review;
		
		reviewRepository.save(review);
		Double ratingAvg = queryFactory.select(qReview.rating.avg())
				.from(qReview)
				.where(qReview.isbn.eq(dto.getIsbn()))
				.fetchOne();
		
		reviewRepository.updateRatingAvg(ratingAvg, dto.getIsbn());
	}

	@Override
	public void deleteContent(Long id) {
		Review reviewId = new Review();
		reviewId.setId(id);
		List<ReviewDtl> reviewReply = reviewCommentRepository.findByRefGroup(reviewId);
		Review review = reviewRepository.findById(id);

		for (int i = 0; i < reviewReply.size(); i++) {
			reviewCommentRepository.delete(reviewReply.get(i).getId());
		}
		
		reviewRepository.delete(id);
		
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		QReview qReview = QReview.review;
		Double ratingAvg = queryFactory.select(qReview.rating.avg())
				.from(qReview)
				.where(qReview.isbn.eq(review.getIsbn()))
				.fetchOne();
		
		reviewRepository.updateRatingAvg(ratingAvg, review.getIsbn());
	}

	@Override
	public Review getDetail(Long id) {

		return reviewRepository.findReviewDetail(id);		
	}
	
	@Override
	@Transactional
	public ReviewDtl saveComment(HttpServletRequest request) {
		Long writer = (Long) request.getSession().getAttribute("id");
		Long ref_group = Long.parseLong(request.getParameter("refGroup"));
		Long target_id = Long.parseLong(request.getParameter("target_id"));
		String content = request.getParameter("content");

		String comment_group = request.getParameter("commentGroup");

		ReviewDtl dto=new ReviewDtl();
		Review review=new Review();
		review.setId(ref_group);
		Users writerId = new Users();
		if (writer != null) {
			writerId.setId(writer);
		}

		Users targetId = new Users();
		targetId.setId(target_id);
		
		dto.setWriter(writerId);
		dto.setTarget_id(targetId);
		dto.setContent(content);
		dto.setRefGroup(review);
		
		if(comment_group == null) { 
			dto.setCommentGroup(reviewCommentRepository.findByNextId());
		}else {
			dto.setCommentGroup(Long.parseLong(comment_group));
		}
		ReviewDtl reply = reviewCommentRepository.save(dto);
		
		QReviewDtl qReviewDtl = QReviewDtl.reviewDtl;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		
		Long totalReply = queryFactory.select(qReviewDtl.count())
				.from(qReviewDtl)
				.where(qReviewDtl.refGroup.eq(review))
				.fetchOne();
		
		reviewCommentRepository.updateReplyCount(totalReply, ref_group);
		
		return reply;
	}

	@Override
	@Transactional
	public void deleteComment(Long replyId) {
		ReviewDtl comment = reviewCommentRepository.findById(replyId);
		QReviewDtl qReviewDtl = QReviewDtl.reviewDtl;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		
		reviewCommentRepository.delete(replyId);
		Long totalReply = queryFactory.select(qReviewDtl.count())
				.from(qReviewDtl)
				.where((qReviewDtl.refGroup.eq(comment.getRefGroup())))
				.fetchOne();
		
		reviewCommentRepository.updateReplyCount(totalReply, comment.getRefGroup().getId());
	}
	
	@Override
	public void updateComment(ReviewDtl dto) {
		ReviewDtl comment = reviewCommentRepository.findById(dto.getId());
		comment.setContent(dto.getContent());
		
		reviewCommentRepository.save(comment);
	}

	@Override
	public Page<Review> getBookReview(String isbn, Pageable pageable) {
		QReview qReview = QReview.review;
		QUsers qUsers = QUsers.users;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		pageable = new PageRequest(pageable.getPageNumber(), 3, pageable.getSort());
		OrderSpecifier<?> orderCondition = null;
		
		if (pageable.getSort() != null && pageable.getSort().toString().contains("rating")) {
			orderCondition = qReview.rating.desc(); // 별점순 정렬
		} else if (pageable.getSort() == null || pageable.getSort().toString().contains("regdate") || orderCondition == null) {
			orderCondition = qReview.regdate.desc(); // 최신순 정렬
		}
		
		QueryResults<Review> list = queryFactory.select(qReview)
				.from(qReview)
				.join(qReview.writer, qUsers)
				.fetchJoin()
				.where(qReview.isbn.eq(isbn))
				.orderBy(orderCondition, qReview.regdate.desc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		
		return new PageImpl<Review>(list.getResults(), pageable, list.getTotal());
	}
	@Override
	public Double reviewAvgRating(String isbn) {
		QReview qReview = QReview.review;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
				
		Double avgRating = queryFactory.select(qReview.rating.avg())
				.from(qReview)
				.where(qReview.isbn.eq(isbn))
				.fetchOne();
		
		return avgRating;
	}
	@Override
	public Long reviewTotalReply(Long refGroup) {
		QReviewDtl qReviewDtl = QReviewDtl.reviewDtl;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		Review review = new Review();
		review.setId(refGroup);
		
		Long totalReply = queryFactory.select(qReviewDtl.count())
				.from(qReviewDtl)
				.where(qReviewDtl.refGroup.eq(review))
				.fetchOne();
		
		return totalReply;
	}
}