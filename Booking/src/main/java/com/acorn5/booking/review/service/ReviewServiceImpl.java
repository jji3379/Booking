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
	
	
	// by남기, 저장된 이미지를 얻어오고 이미지 파일을 MultipartFile 객체에 담아주는 메소드 _210303
	@Override
	public String saveImage(MultipartFile image, HttpServletRequest request) {
		// by남기, 원본 파일명 _210303
		String orgFileName=image.getOriginalFilename();
		// by남기, webapp/upload 폴더 까지의 실제 경로(서버의 파일시스템 상에서의 경로) _210303
		String realPath=request.getServletContext().getRealPath("/upload");
		// by남기, 저장할 파일의 상세 경로 _210303
		String filePath=realPath+File.separator;
		// by남기, 디렉토리를 만들 파일 객체 생성 _210303
		File upload=new File(filePath);
		if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면 
			upload.mkdir(); //만들어 준다.
		}
		// by남기, 저장할 파일 명을 구성한다 _210303
		String saveFileName=
				System.currentTimeMillis()+orgFileName;
		try {
			// by남기, upload 폴더에 파일을 저장한다 _210303
			image.transferTo(new File(filePath+saveFileName));
			System.out.println(filePath+saveFileName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		// by남기, 업로드 경로를 리턴한다 _210303
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
	public void deleteContent(Long num) {
		Review reviewId = new Review();
		reviewId.setId(num);
		List<ReviewDtl> reviewReply = reviewCommentRepository.findByRefGroup(reviewId);

		for (int i = 0; i < reviewReply.size(); i++) {
			reviewCommentRepository.delete(reviewReply.get(i).getId());
		}
		
		reviewRepository.delete(num);
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

	// by남기, 리뷰의 댓글을 삭제하는 메소드 _210303
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
	// by남기, 리뷰의 댓글을 수정하는 메소드 _210303
	@Override
	public void updateComment(ReviewDtl dto) {
		//reviewCommentDao.update(dto);
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