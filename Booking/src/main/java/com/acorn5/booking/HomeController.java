package com.acorn5.booking;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.entity.QReview;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;
import com.acorn5.booking.users.entity.QSearch;
import com.acorn5.booking.users.entity.QUsers;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.SearchRepository;
import com.acorn5.booking.users.repository.UsersRepository;
import com.acorn5.booking.users.service.UsersService;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Controller
public class HomeController {
private static final org.slf4j.Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private UsersRepository usersRepository;

	@Autowired
	private SearchRepository searchRepository; 
	
	@Autowired
    private CartService cartservice;
	
    /**
     * Tiles를 사용하지 않은 일반적인 형태
     */    
    @RequestMapping("/test.do")
    public String test() {
        return "test";
    }    
    
    /**
     * Tiles를 사용(header, footer 포함)
     */        
    @RequestMapping("/testPage.do")
    public String testPage() {
        return "test.page";
    }
    
    /**
     * Tiles를 사용(header, left, footer 포함)
     */        
    @RequestMapping("/testSide.do")
    public String testSide() {
        return "test.side";
    }
    
    
    /**
     * Tiles를 사용(header, left, footer 제외)
     */    
    @RequestMapping("/testPart.do")
    public String testPart() {
        return "test.part";
    }        
    
	@Autowired
    private BookService service;//by욱현. 홈페이지에 추천도서를 불러오는 메소드가 담긴 서비스_2021223
	
	//@Autowired
	//private UsersDao dao;
	
	//by우석, navbar cartitem count 보이기위한 cartservice 주입_20210315
	//@Autowired
	//private CartService cartservice;
	
	@RequestMapping("/") 
	public ModelAndView home(HttpSession session,HttpServletRequest request) {
		
		ModelAndView mView = new ModelAndView();
		Long id = (Long) session.getAttribute("id");
		//by 우석, view page 에서 cartitem 불러오기_210315
		if (id != null) {
			cartservice.listCart(mView, request);
			Users userId = new Users();
			userId.setId(id);
			
			List<Search> searchList = searchRepository.findByUserId(userId);
			
			
			String recentKeyword = null; 
					//searchList.get(0).getKeyword();

			/*
			for (int i = 0; i < searchList.size(); i++) {
				recentKeyword = searchList.get(i).getKeyword();
				System.out.println("recentKeyword : "+recentKeyword);
			}
			*/
			if (recentKeyword == null) { // 최근 검색어가 없을 경우 관심사로 추천
				String query = usersRepository.findById(id).getCare();// 회원의 관심사를 query로 설정
				service.recommendBook(10, 1, "count", query, mView);
			} else { // 최근 검색어가 있을 경우 최근 검색어 기준 추천
				service.recommendBook(10, 1, "count", recentKeyword, mView);
			}
		} else if (id == null) { // 로그인을 안한경우
			service.recommendBook("1", 10, 1, "count", mView);
		}
		
		//mView.addObject("dto", dto);//by욱현. 뷰페이지로 로그인된 회원의 회원정보 전달_2021225
		mView.setViewName("home.page");
		
		return mView;
	}
	
	@RequestMapping("/booking.do")
	@ResponseBody
	public Map<String, Object> booking() {
		// 책을 랜덤으로 추천해야 하니까
		int ran = (int) (Math.random() * 300);
		// 부킹버튼을 눌러 요청하는순간 올랜덤 검색 로직 실행 및 이미지경로와 isbn만 맵객체에 넣어서 받기
		Map<String, Object> data = service.recommendBook("sim", 1, ran);
		// 뷰페이지로 이동 후 자바스크립트로 추출 (ajax로 그부분만 뿌려주기)

		return data;
	}
	
}