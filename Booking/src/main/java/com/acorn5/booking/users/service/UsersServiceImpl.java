package com.acorn5.booking.users.service;

import java.io.File;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.entity.Cart;
import com.acorn5.booking.cart.entity.QCart;
import com.acorn5.booking.exception.DBFailException;
import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.review.entity.QReview;
import com.acorn5.booking.review.entity.QReviewDtl;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.review.repository.ReviewCommentRepository;

import com.acorn5.booking.users.entity.QSearch;
import com.acorn5.booking.users.entity.QUsers;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.SearchRepository;
import com.acorn5.booking.users.repository.UsersRepository;
import com.querydsl.core.QueryResults;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class UsersServiceImpl implements UsersService{
	
	@PersistenceContext
	EntityManager em;
	
	@Autowired
	private UsersRepository usersRepository;
	
	@Autowired
	private ReviewCommentRepository reviewCommentRepository;


	@Autowired
	private SearchRepository searchRepository;
	
	BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	@Override
	public Page<Review> getMyReview(Long id, Pageable pageable) {
		Users userId = new Users();
		userId.setId(id);

		QReview qReview = QReview.review;
		QUsers qUsers = QUsers.users;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		pageable = new PageRequest(pageable.getPageNumber(), 5, pageable.getSort());
		
		QueryResults<Review> list = queryFactory.selectFrom(qReview)
				.join(qReview.writer, qUsers)
				.fetchJoin()
				.where(qReview.writer.eq(userId))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		
		return new PageImpl<Review>(list.getResults(), pageable, list.getTotal());
	}
	
	@Override
	public Page<ReviewDtl> getMyReply(Long id, Pageable pageable) {
		Users userId = new Users();
		userId.setId(id);
		
		QReviewDtl qReviewDtl = QReviewDtl.reviewDtl;
		QUsers qUsers = QUsers.users;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		pageable = new PageRequest(pageable.getPageNumber(), 5, pageable.getSort());
		
		QueryResults<ReviewDtl> list = queryFactory.selectFrom(qReviewDtl)
				.join(qReviewDtl.writer, qUsers)
				.fetchJoin()
				.where(qReviewDtl.writer.eq(userId))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		
		return new PageImpl<ReviewDtl>(list.getResults(), pageable, list.getTotal());
	}
	
	@Override
	public Page<Cart> getMyCart(Long id, Pageable pageable) {
		Users userId = new Users();
		userId.setId(id);
		
		QCart qCart = QCart.cart;
		QUsers qUsers = QUsers.users;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		pageable = new PageRequest(pageable.getPageNumber(), 5, pageable.getSort());
		
		QueryResults<Cart> list = queryFactory.selectFrom(qCart)
				.join(qCart.userId, qUsers)
				.fetchJoin()
				.where(qCart.userId.eq(userId))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		
		return new PageImpl<Cart>(list.getResults(), pageable, list.getTotal());
	}
	
	@Override
	public Page<Search> getMySearch(Long id, Pageable pageable) {
		Users userId = new Users();
		userId.setId(id);
		
		QUsers qUsers = QUsers.users;
		QSearch qSearch = QSearch.search;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		pageable = new PageRequest(pageable.getPageNumber(), 5, pageable.getSort());
		
		QueryResults<Search> list = queryFactory.selectFrom(qSearch)
				.join(qSearch.userId, qUsers)
				.fetchJoin()
				.where(qSearch.userId.eq(userId))
				.orderBy(qSearch.regdate.desc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		
		return new PageImpl<Search>(list.getResults(), pageable, list.getTotal());
	}
	
	@Override
	public boolean getPwd(Long id, String pwd) {
		Users userInfo = usersRepository.findById(id);
		String encoderPwd = userInfo.getPwd();
		
		boolean checkPwd = encoder.matches(pwd, encoderPwd);
		return checkPwd;
	}
	
	@Override
	public void deleteRecentSearch(Long id) {
		searchRepository.delete(id);
	}
	
	@Override
	public Users addUser(Users users) {
		String savedPwd = encoder.encode(users.getPwd());
		users.setPwd(savedPwd);
		return usersRepository.save(users);
	}
	
	@Override
	public boolean isExistId(String loginId) {
		Users users = usersRepository.findByLoginId(loginId);
		boolean isExisted = true;
		if (users != null) {
			isExisted = false;
		}
		return isExisted;
	}
	
	@Override
	public void loginformLogic(HttpServletRequest request, ModelAndView mView) {
		String url = request.getParameter("url");
		if (url == null) {
			String cPath = request.getContextPath();
			url = cPath;
		}
		
		String savedId = "";
		String savedPwd = "";
		Cookie[] cooks = request.getCookies();
		
		if (cooks != null) {
			for (Cookie tmp : cooks) {
				String key = tmp.getName();
				if (key.equals("savedId")) {
					savedId = tmp.getValue();
				}
				if (key.equals("savedPwd")) {
					savedPwd = tmp.getValue();
				}
			}
		}
		
		mView.addObject("url", url);
		mView.addObject("savedId", savedId);
		mView.addObject("savedPwd", savedPwd);
	}

	@Override
	public Users loginLogic(HttpServletRequest request, HttpServletResponse response, LoginDto loginDto) {

		String url = loginDto.getUrl(); 

		String loginId = loginDto.getLoginId(); 
		String pwd = loginDto.getPwd().toLowerCase(); 
		
		Users dto = new Users();
		
		Users findById = usersRepository.findByLoginId(loginId);
		if (findById == null) {
			throw new DBFailException("아이디가 없습니다.");
		} 
		
		String savedPwd = findById.getPwd();
		if (savedPwd == null) {
			throw new DBFailException("비밀번호가 일치하지 않습니다.");
		}
		
		boolean isEqual = BCrypt.checkpw(pwd, savedPwd);
		if (isEqual) {
			dto.setLoginId(loginId);
			dto.setPwd(savedPwd);
		} else {
			throw new DBFailException("비밀번호가 일치하지 않습니다.");
		}

		boolean isValid = findById.getLoginId().equals(loginId);

		Long id = findById.getId();

		if (isValid) {
			request.getSession().setAttribute("id", id);
			request.getSession().setAttribute("loginId", loginId);
		}
		String isSave = request.getParameter("isSave");

		if (isSave == null) { 
			Cookie idCook = new Cookie("savedId", loginId);
			idCook.setMaxAge(0);
			response.addCookie(idCook);

			Cookie pwdCook = new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(0);
			response.addCookie(pwdCook);
		} else {
			Cookie idCook = new Cookie("savedId", loginId);
			idCook.setMaxAge(60 * 60 * 24); // 하루동안 유지
			response.addCookie(idCook);

			Cookie pwdCook = new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(60 * 60 * 24);
			response.addCookie(pwdCook);
		}
		
		request.setAttribute("dto", dto);
		request.setAttribute("url", url);
		request.setAttribute("isValid", isValid);
		
		return dto;
	}

	@Override
	public Users getInfo(Long id) {
		return usersRepository.findById(id);
	}
	
	@Override
	public void deleteUser(HttpSession session) {
		Long id=(Long)session.getAttribute("id");

		QReviewDtl qReviewDtl = QReviewDtl.reviewDtl;
		JPAQueryFactory queryFactory = new JPAQueryFactory(em);
		Review review = new Review();
		Users user = new Users();
		user.setId(id);
		
		List<ReviewDtl> reviewDtl = reviewCommentRepository.findByWriter(user);
		
		for (int i = 0; i < reviewDtl.size(); i++) {
			
			Long ref_group = reviewDtl.get(i).getRefGroup().getId();
			review.setId(ref_group);
			Long reviewDtlId = reviewDtl.get(i).getId();
			reviewCommentRepository.delete(reviewDtlId);
			
			Long totalReply = queryFactory.select(qReviewDtl.count())
					.from(qReviewDtl)
					.where(qReviewDtl.refGroup.eq(review))
					.fetchOne();
			
			reviewCommentRepository.updateReplyCount(totalReply, ref_group);
		}
		
		session.removeAttribute("id");
		usersRepository.delete(id);
	}
	
	@Override
	public void updateUserPwd(ModelAndView mView, Users dto, HttpServletRequest request,
			HttpSession session) {
		Long id = (Long) session.getAttribute("id");

		String pwd = request.getParameter("pwd");
		String nP = request.getParameter("newPwd");
		String savedPwd = "";
		Users dto2 = new Users();
		if (id != null) {
			savedPwd = usersRepository.findById(id).getPwd();
			dto2 = usersRepository.findById(id);
		}
		
		boolean isSuccess = BCrypt.checkpw(pwd, savedPwd);
		if (isSuccess) {
			String newPwd = new BCryptPasswordEncoder().encode(nP);

			dto2.setPwd(newPwd);
			usersRepository.save(dto2);

			session.removeAttribute("id");
		}
		mView.addObject("isSuccess", isSuccess);
	}
	
	@Override
	public void saveProfileImage(MultipartFile image, HttpServletRequest request) {
		String orgFileName=image.getOriginalFilename();
		String realPath=request.getServletContext().getRealPath("/upload");
		File f=new File(realPath);
		if(!f.exists()) {
			f.mkdir();
		}
		
		String saveFileName=System.currentTimeMillis()+orgFileName;
		String path=realPath+File.separator+saveFileName;
		try {

			image.transferTo(new File(path));
		}catch(Exception e) {
			e.printStackTrace();
		}
		String profile="/upload/"+saveFileName;
		Long id=(Long)request.getSession().getAttribute("id");
		Users dto = usersRepository.findById(id);
		dto.setProfile(profile);
		
		usersRepository.save(dto);
	}
	
	@Override
	public void updateUser(Users dto, HttpSession session) {
		Long id=(Long)session.getAttribute("id");

		Users users = usersRepository.findById(id);
		users.setCare(dto.getCare());
		users.setEmail(dto.getEmail());
		
		usersRepository.save(users);
	}
	@Override
	public Users getCareEmail(Long id) {
		Users dto = usersRepository.findById(id); 

		return dto;
	}
	@Override
	public void deleteProfile(Long id) {
		Users user = usersRepository.findById(id);
		user.setProfile(null);

		usersRepository.save(user);
	}
	
}