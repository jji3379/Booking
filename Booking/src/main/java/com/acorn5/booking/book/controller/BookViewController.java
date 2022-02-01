package com.acorn5.booking.book.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.SearchRepository;
import com.acorn5.booking.users.repository.UsersRepository;
 
@Controller
public class BookViewController {
    @Autowired
    private BookService service; 

    //@Autowired
	//private UsersDao dao;

    @Autowired
    private UsersRepository usersRepository;
    
	@Autowired
	private SearchRepository searchRepository; 
    
	// by 준익, 카테고리별 페이징 검색을 위한 컨트롤러_2021.02.28
	@RequestMapping("/category") 
	public ModelAndView categoryList(@RequestParam("d_catg") String d_catg, int start, String sort,
			HttpServletRequest request, ModelAndView mView) {

		// by 준익, categoryList 에 pagingCategory 서비스를 거친 값들을 넣어준다 (목차 : 1, 화면에 출력할 개수 :10)_2021.02.28
		mView.addObject("categoryList", service.pagingCategory("1", 10, start, d_catg, request, mView, sort));
		mView.setViewName("bookList/CategoryList.page");

		return mView;
	}
	
	@RequestMapping("/bestSeller")
	public String bestSeller() {

		return "bookList/bestSeller.page";
	}
    
    //by준영, bookDetail.jsp 에 isbn 을 인자로 리스트(리스트지만 한권) 검색하는 서비스_210222
    @RequestMapping("/book/{isbn}")
    public ModelAndView bookDetail(@PathVariable String isbn){
    	ModelAndView mView = new ModelAndView();
		if (isbn != null) {
			mView.addObject("bookDetail", service.bookDetail(isbn, 1));
		}
		
		mView.setViewName("detail/bookDetail.page");
        return mView;
    }
    
    //by준영, bookAjax.jsp 에 저자를 인자로 리스트 검색하는 서비스_210222
    @RequestMapping("/detailAjax")
    public ModelAndView bookAjax(@RequestParam(required=false)String d_auth,String sort){
    	ModelAndView mView = new ModelAndView();
		
    	if (d_auth != null) {
			mView.addObject("detailAjax", service.detailAjax(d_auth, 30, sort));
		}
		mView.setViewName("detail/detailAjax");
        return mView;
    }
	
    
    //by남기, reviewBookList.jsp 에 keyword 를 인자로 리스트 검색하는 서비스_210303 
    @RequestMapping("/review/reviewBookList.do")
    public ModelAndView reviewBookList(@RequestParam(required=false)String keyword, HttpServletRequest request,HttpSession session){    
		ModelAndView mView = new ModelAndView();
		Long id = (Long) session.getAttribute("id");
		if (keyword != null) {
			mView.addObject("reviewBookList", service.searchBookList(keyword, 8, 1, request, mView));
		} else {
			Users userId = new Users();
			List<BookDto> searchRecommendList = new ArrayList<BookDto>();
			if (id != null) { // 로그인을 한 경우
				userId.setId(id);
				
				// 중복을 제거한 리스트
				List<Search> searchList = searchRepository.findByUserId(userId).stream().distinct().collect(Collectors.toList());
				Users users = usersRepository.findById(id);
				String careList[] = users.getCare().split(",");
				
				// 2. 로그인 해서 최근 검색어 기반으로 추천

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
			}
			Collections.shuffle(searchRecommendList);
			mView.addObject("reviewBookList", searchRecommendList);
		}
		
		mView.setViewName("review/reviewBookList");
        return mView;
    }
    
    //by남기, reviewInsertform.jsp 에 d_isbn 을 인자로 도서 정보를 가져오는 서비스_210303
    @RequestMapping("/review/private/reviewInsertform.do")
    public ModelAndView reviewBook(@RequestParam(required=false)String d_isbn, HttpServletRequest request){
        ModelAndView mView = new ModelAndView();
		
        if(d_isbn !=null)
        {
            mView.addObject("reviewBook", service.bookReview(d_isbn, 1));
        }
        mView.setViewName("review/private/reviewInsertform.page");
        return mView;
    }
    // by 준익, 조건 검색 페이징 컨트롤러_2021.03.09
    @RequestMapping("/bookList/conditionSearch.do")
    public ModelAndView conditionSearch(@RequestParam(required=false)String keyword,int start,
          HttpServletRequest request, ModelAndView mView){    
       if(keyword !=null) { 
			// by욱현.검색시 최근검색어 칼럼에 검색키워드를 담기_2021308
			HttpSession session = request.getSession();
			Long id = (Long) session.getAttribute("id");
			if (id != null) {
				service.recentSearchInput(keyword, id);
			}
          //mView.addObject("conditionSearch",service.conditionSearch(keyword, 10, pageable);
			mView.addObject("keyword", keyword);
       }
        mView.setViewName("bookList/conditionSearch.page");
        return mView;
    }
}

