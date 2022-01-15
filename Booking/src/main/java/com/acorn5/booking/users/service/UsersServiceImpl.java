package com.acorn5.booking.users.service;

import java.io.File;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.exception.DBFailException;
import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.order.dao.OrderDao;
import com.acorn5.booking.pay.dao.CartDao;
import com.acorn5.booking.pay.entity.Cart;
import com.acorn5.booking.pay.entity.QCart;
import com.acorn5.booking.pay.repository.CartRepository;
import com.acorn5.booking.review.dao.ReviewCommentDao;
import com.acorn5.booking.review.dao.ReviewDao;
import com.acorn5.booking.review.entity.QReview;
import com.acorn5.booking.review.entity.QReviewDtl;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.review.repository.ReviewCommentRepository;
import com.acorn5.booking.review.repository.ReviewRepository;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UserInfoDto;
import com.acorn5.booking.users.dto.UsersDto;
import com.acorn5.booking.users.entity.QSearch;
import com.acorn5.booking.users.entity.QUsers;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.UsersRepository;
import com.querydsl.core.QueryResults;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class UsersServiceImpl implements UsersService{
	
	//by욱현.dao객체 di시키기위해 준비_2021222
	//@Autowired
	//private UsersDao dao;
	
	//회원탈퇴시 해당 해원의 기록을 모두 삭제하기 위해 di
	//@Autowired
	//private ReviewCommentDao reviewCommentDao;
	//@Autowired
	//private ReviewDao reviewDao;
	//@Autowired
	//private CartDao cartDao;
	//@Autowired
	//private OrderDao orderDao;
	
	@PersistenceContext
	EntityManager em;
	
	@Autowired
	private UsersRepository usersRepository;

	@Autowired
	private ReviewRepository reviewRepository;
	
	@Autowired
	private ReviewCommentRepository reviewCommentRepository;

	@Autowired
	private CartRepository cartRepository;
	
	//by욱현.비밀번호 암호 인코딩위한 객체 필드선언_2021222
	BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	//by욱현.회원가입관련 로직_2021222
	@Override
	public Users addUser(Users users) {
		String savedPwd = encoder.encode(users.getPwd());
		users.setPwd(savedPwd);
		return usersRepository.save(users);
	}
	//by욱현.id중복겁사관련 로직_2021222
	@Override
	public boolean isExistId(String loginId) {
		// id  존재 여부를 리턴해준다. 
		Users users = usersRepository.findByLoginId(loginId);
		boolean isExisted = true;
		if (users != null) {
			isExisted = false;
		}
		return isExisted;
	}
	//by욱현.로그인폼관련 로직_2021222
	@Override
	public void loginformLogic(HttpServletRequest request, ModelAndView mView) {
		// GET 방식 파라미터 url 이라는 이름으로 전달되는 값이 있는지 읽어와보기
		String url = request.getParameter("url");
		// 만일 넘어오는 값이 없다면
		if (url == null) {
			// 로그인 후에 home.do 요청이 되도록 절대 경로를 구성한다.
			String cPath = request.getContextPath();
			url = cPath;
		}
		//쿠키에 저장된 아이디와 비밀번호를 담을 변수
		String savedId = "";
		String savedPwd = "";
		// 쿠키에 저장된 값을 위의 변수에 저장하는 코드
		Cookie[] cooks = request.getCookies();
		if (cooks != null) {
			// 반복문 돌면서 쿠키객체를 하나씩 참조해서
			for (Cookie tmp : cooks) {
				// 저장된 키값을 읽어온다.
				String key = tmp.getName();
				// 만일 키값이 savedId 라면
				if (key.equals("savedId")) {
					// 쿠키 value 값을 savedId 라는 지역변수에 저장
					savedId = tmp.getValue();
				}
				if (key.equals("savedPwd")) {
					savedPwd = tmp.getValue();
				}
			}
		}			
		//view page 에서 필요한 데이터를 담는다. 
		mView.addObject("url", url);
		mView.addObject("savedId", savedId);
		mView.addObject("savedPwd", savedPwd);
	}

	//by욱현.로그인 비즈니스 로직_2021222
	@Override
	public Users loginLogic(HttpServletRequest request, HttpServletResponse response, LoginDto loginDto) {
		//로그인후 가야하는 목적지 정보

		String url = loginDto.getUrl(); 
				//request.getParameter("url");
		//로그인 실패를 대비해서 목적지 정보를 인코딩한 결과도 준비 한다.
		//String encodedUrl=URLEncoder.encode(url);
		//1. 폼전송되는 아이디와 비밀번호를 읽어온다.
		String loginId = loginDto.getLoginId(); 
				//request.getParameter("loginId");
		String pwd = loginDto.getPwd(); 
				//request.getParameter("pwd");
		
		/*
		 	인코딩되 저장된 패스워드와 비교
		 */
		Users dto = new Users();
		
		Users findById = usersRepository.findByLoginId(loginId);
		if (findById == null) {
			throw new DBFailException("아이디가 없습니다.");
		} // by욱현.미등록 아이디에 관한 예외처리 수정_21310
		
		String savedPwd = findById.getPwd();
		System.out.println("savePwd : " + savedPwd);
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

		// 2. DB 에 실제로 존재하는 (유효한) 정보인지 확인한다.
		boolean isValid = findById.getLoginId().equals(loginId);

		Long id = findById.getId();

		// 3. 유효한 정보이면 로그인 처리를 하고 응답 그렇지 않으면 아이디혹은 비밀번호가 틀렸다고 응답
		if (isValid) {
			// HttpSession 객체를 이용해서 로그인 처리를 한다.
			request.getSession().setAttribute("id", id);
			request.getSession().setAttribute("loginId", loginId);
		}
		// 체크박스를 체크 하지 않았으면 null 이다.
		String isSave = request.getParameter("isSave");

		if (isSave == null) {// 체크 박스를 체크 안했다면
			// 저장된 쿠키 삭제
			Cookie idCook = new Cookie("savedId", loginId);
			idCook.setMaxAge(0);// 삭제하기 위해 0 으로 설정
			response.addCookie(idCook);

			Cookie pwdCook = new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(0);
			response.addCookie(pwdCook);
		} else {// 체크 박스를 체크 했다면
				// 아이디와 비밀번호를 쿠키에 저장
			Cookie idCook = new Cookie("savedId", loginId);
			idCook.setMaxAge(60 * 60 * 24);// 하루동안 유지
			response.addCookie(idCook);

			Cookie pwdCook = new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(60 * 60 * 24);
			response.addCookie(pwdCook);
		}
		// view page 에서 필요한 데이터를 request 에 담고
		request.setAttribute("dto", dto);
		// request.setAttribute("encodedUrl", encodedUrl);
		request.setAttribute("url", url);
		request.setAttribute("isValid", isValid);
		
		return dto;
	}

	//by욱현.dto정보를 얻어내는 로직 _2021222
	@Override
	public Users getInfo(Long id) {
		//로그인된 아이디를 읽어와서
		//개인정보를 읽어온다.
		//Users dto= dao.getData(id);
		UserInfoDto userinfo = new UserInfoDto();
		Users dto = new Users();
		if (id != null) {
			dto = usersRepository.findById(id);
		}
		
		return dto;
	}
	
	//by욱현.회원탈퇴 관련 비즈니스 로직_2021222
	@Override
	public void deleteUser(HttpSession session) {
		// ***** 수정 필요 *****
		//로그인된 아이디를 읽어온다. 
		Long id=(Long)session.getAttribute("id");
		//DB 에서 삭제
		//dao.delete(id);
		//댓글삭제
		//reviewCommentDao.delete2(id);
		//리뷰삭제
		//reviewDao.delete2(id);
		//카트에서 삭제
		//cartDao.delete2(id);
		//주문내역 삭제
		//orderDao.delete(id);
		//로그아웃 처리
		session.removeAttribute("id");
		usersRepository.delete(id);
	}
	
	//by욱현.비밀번호 수정 관련 로직_2021222
	@Override
	public void updateUserPwd(ModelAndView mView, Users dto, HttpServletRequest request,
			HttpSession session) {
		//로그인 된 아이디를 읽어와서 
		Long id = (Long) session.getAttribute("id");

		String pwd = request.getParameter("pwd");
		String nP = request.getParameter("newPwd");
		String savedPwd = "";
		Users dto2 = new Users();
		if (id != null) {
			savedPwd = usersRepository.findById(id).getPwd();
			// dao.getData(id).getPwd();//db에서 불러온 기존 pwd(인코딩된 상태)
			dto2 = usersRepository.findById(id);
		}
		
		boolean isSuccess = BCrypt.checkpw(pwd, savedPwd);
		// 만일 성공이면
		if (isSuccess) {
			String newPwd = new BCryptPasswordEncoder().encode(nP);
			// dto.setPwd(savedPwd);
			// dto.setId(id);
			dto2.setPwd(newPwd);
			usersRepository.save(dto2);
			// dao.updatePwd(dto);
			// 비밀번호가 수정되었으므로 다시 로그인 하도록 로그인 아웃 처리를 한다.
			session.removeAttribute("id");
		}
		//성공 여부를 ModelAndView 객체에 담는다.
		mView.addObject("isSuccess", isSuccess);
	}
	
	//by욱현.프로필이미지 업로드 관련 로직_2021222
	@Override
	public void saveProfileImage(MultipartFile image, HttpServletRequest request) {
		//원본 파일명 
		String orgFileName=image.getOriginalFilename();
		//파일을 저장할 실제 경로   "/webapp/upload"   
		String realPath=request.getServletContext().getRealPath("/upload");
		File f=new File(realPath);
		if(!f.exists()) {//만일 존재 하지 않으면
			f.mkdir();//폴더를 만든다.
		}
		//절대 중복이 되지 않을만한 저장할 파일명을 구성한다.
		String saveFileName=System.currentTimeMillis()+orgFileName;
		//저장할 파일의 전체 경로를 구성한다.
		String path=realPath+File.separator+saveFileName;
		try {
			//임시폴더에 업로드된 파일을 원하는 위치에 원하는 파일명으로 이동 시킨다.
			image.transferTo(new File(path));
		}catch(Exception e) {
			e.printStackTrace();
		}
		//DB 에 저장할 이미지의 경로
		String profile="/upload/"+saveFileName;
		//로그인된 아이디
		Long id=(Long)request.getSession().getAttribute("id");
		//수정할 정보를 dto 에 담기
		Users dto = usersRepository.findById(id);
		dto.setProfile(profile);
		usersRepository.save(dto);
		//dao 를 이용해서 수정 반영하기
		//dao.updateProfile(dto);
	}
	//by욱현.회원정보수정관련 로직_2021222
	@Override
	public void updateUser(Users dto, HttpSession session) {
		//로그인된 아이디를 읽어온다.
		Long id=(Long)session.getAttribute("id");
		//dto 에 담는다.
		Users users = usersRepository.findById(id);
		users.setCare(dto.getCare());
		users.setEmail(dto.getEmail());
		System.out.println("care : "+dto.getCare()+"email : "+dto.getEmail());
		usersRepository.save(users);
		//dao 를 이용해서 DB 에 수정 반영한다.
		//dao.update(dto);
	}
	@Override
	public Users getCareEmail(Long id) {
		Users dto = usersRepository.findById(id); 
				//dao.getCareEmail(inputId);
		return dto;
	}
	@Override
	public void deleteProfile(Users inputId) {
		usersRepository.delete(inputId);
		//dao.deleteProfile(inputId);
	}

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

}