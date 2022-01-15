package com.acorn5.booking;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.logging.Logger;
import java.util.stream.Collectors;

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

import com.acorn5.booking.book.dto.BookDto;
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
		
			
		Users userId = new Users();
		List<BookDto> searchRecommendList = new ArrayList<BookDto>();
		if (id != null) { // 로그인을 한 경우
			userId.setId(id);
			
			// 중복을 제거한 리스트
			List<Search> searchList = searchRepository.findByUserId(userId).stream().distinct().collect(Collectors.toList());
			Users users = usersRepository.findById(id);
			String careList[] = users.getCare().split(",");
			
			// 2. 로그인 해서 최근 검색어 기반으로 추천
			cartservice.listCart(mView, request);

			if (searchList.size() > 5) { // 최근 검색어가 5개 이상 있을 경우
				System.out.println("검색어 5개 이상");
				for (int i = 0; i < 5; i++) {
					if (searchList.get(i).getKeyword() != null) {
						searchRecommendList.addAll(service.searchRecommendBook(50, 1, "count", searchList.get(i).getKeyword(), mView));
					} 
				}
			} else if(searchList.size() > 0 && searchList.size() < 5) { // 최근 검색 기록이 0보다 크고 5보다 작을 때
				System.out.println("검색어 5개 이하");
				for (int i = 0; i < searchList.size(); i++) {
					if (searchList.get(i).getKeyword() != null) {
						searchRecommendList.addAll(service.searchRecommendBook(50, 1, "count", searchList.get(i).getKeyword(), mView));
					}
				}
				// 나머지는 관심사로 채우기
				for (int i = 0; i < careList.length; i++) {
					searchRecommendList.addAll(service.careRecommendBook(careList[i], 50, 1, "count", mView));		
				}
			} else if(searchList.isEmpty()){ // 최근 검색어가 없을 경우
				System.out.println("검색어 없는 경우");
				for (int i = 0; i < careList.length; i++) {
					searchRecommendList.addAll(service.careRecommendBook(careList[i], 50, 1, "count", mView));
				}
			}

		} else { // 로그인 안한 경우 그냥 추천
			System.out.println("로그인 안한 경우");
			searchRecommendList.addAll(service.bestSeller("1", 10, 1, "count"));
		}
		Collections.shuffle(searchRecommendList);
		mView.addObject("list", searchRecommendList);
			
		//mView.addObject("dto", dto);//by욱현. 뷰페이지로 로그인된 회원의 회원정보 전달_2021225
		mView.setViewName("home.page");
		
		return mView;
	}
	
	@RequestMapping("/booking.do")
	@ResponseBody
	public Map<String, Object> booking(HttpServletRequest request) {
		ModelAndView mView = new ModelAndView();
		Long id = (Long) request.getSession().getAttribute("id");

		String[] categoryNum = {
				"100","110","120","130","140","150","160","170","180","190",
				"200","210","220","230","240","250","260","270","280","290",
				"300","310","320","330","340"
		};
		Collections.shuffle(Arrays.asList(categoryNum));
		Map<String, Object> data = new HashMap<String, Object>();
		if (id != null) { // 로그인 했을 경우 관심사로 추천
			Users users = usersRepository.findById(id);
			String careList[] = users.getCare().split(",");
			for (int i = 0; i < careList.length; i++) {
				data = service.bookingRecommendBook(careList[i], 100, 1, "count", mView);
			}
		} else { // 로그인 안했을 경우 종류 별로 랜덤으로 추천
		}		
		data = service.bookingRecommendBook(categoryNum[0].toString(), 100, 1, "count", mView);
		// 뷰페이지로 이동 후 자바스크립트로 추출 (ajax로 그부분만 뿌려주기)

		return data;
	}
	
}
