package com.acorn5.booking.book.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.SearchRepository;
import com.acorn5.booking.users.repository.UsersRepository;
 
@Controller
public class BookViewController {

	@Autowired
    private BookService bookService; 

    @Autowired
    private UsersRepository usersRepository;
    
	@Autowired
	private SearchRepository searchRepository; 
    
	@RequestMapping("/category") 
	public ModelAndView getCategoryList(@RequestParam("d_catg") String d_catg, int start, String sort,
			HttpServletRequest request, ModelAndView mView) {

		mView.addObject("categoryList", bookService.pagingCategory("1", 10, start, d_catg, request, mView, sort));
		mView.setViewName("bookList/CategoryList.page");

		return mView;
	}
	
	@RequestMapping("/bestSeller")
	public String bestSeller() {

		return "bookList/bestSeller.page";
	}
    
    @RequestMapping("/book/{isbn}")
    public ModelAndView getBookDetail(@PathVariable String isbn){
    	ModelAndView mView = new ModelAndView();
		if (isbn != null) {
			mView.addObject("bookDetail", bookService.bookDetail(isbn, 1));
		}
		
		mView.setViewName("detail/bookDetail.page");
        return mView;
    }
    
    @RequestMapping("/detailAjax.do")
    public ModelAndView bookAjax(@RequestParam(required=false)String d_auth,String sort){
    	ModelAndView mView = new ModelAndView();
		
    	if (d_auth != null) {
			mView.addObject("detailAjax", bookService.detailAjax(d_auth, 30, sort));
		}
		mView.setViewName("detail/detailAjax");
		
        return mView;
    }
	
    
    @RequestMapping("/review/book")
    public ModelAndView getReviewBookList(@RequestParam(required=false)String keyword, HttpServletRequest request,HttpSession session){    
		ModelAndView mView = new ModelAndView();
		Long id = (Long) session.getAttribute("id");
		
		if (keyword != null) {
			mView.addObject("reviewBookList", bookService.searchBookList(keyword, 8, 1, request, mView));
		} else {
			Users userId = new Users();
			List<BookDto> searchRecommendList = new ArrayList<BookDto>();
			if (id != null) { 
				userId.setId(id);
				
				// 중복을 제거한 리스트
				List<Search> searchList = searchRepository.findByUserId(userId).stream().distinct().collect(Collectors.toList());
				Users users = usersRepository.findById(id);
				String careList[] = users.getCare().split(",");
				

				if (searchList.size() > 5) { // 최근 검색어가 5개 이상 있을 경우
					for (int i = 0; i < 5; i++) {
						if (searchList.get(i).getKeyword() != null) {
							searchRecommendList.addAll(bookService.searchRecommendBook(50, 1, "count", searchList.get(i).getKeyword(), mView));
						} 
					}
				} else if(searchList.size() > 0 && searchList.size() < 5) { // 최근 검색 기록이 0보다 크고 5보다 작을 때
					for (int i = 0; i < searchList.size(); i++) {
						if (searchList.get(i).getKeyword() != null) {
							searchRecommendList.addAll(bookService.searchRecommendBook(50, 1, "count", searchList.get(i).getKeyword(), mView));
						}
					}
					// 나머지는 관심사
					for (int i = 0; i < careList.length; i++) {
						searchRecommendList.addAll(bookService.careRecommendBook(careList[i], 50, 1, "count", mView));		
					}
				} else if(searchList.isEmpty()){ // 최근 검색어가 없을 경우
					for (int i = 0; i < careList.length; i++) {
						searchRecommendList.addAll(bookService.careRecommendBook(careList[i], 50, 1, "count", mView));
					}
				}
			}
			Collections.shuffle(searchRecommendList);
			mView.addObject("reviewBookList", searchRecommendList);
		}
		
		mView.setViewName("review/reviewBookList");
        return mView;
    }
    
	@RequestMapping("/book/search")
	public ModelAndView conditionSearch(@RequestParam(required = false) String keyword, int start,
			HttpServletRequest request, ModelAndView mView) {
		if (keyword != null) {
			HttpSession session = request.getSession();
			Long id = (Long) session.getAttribute("id");
			
			if (id != null) {
				bookService.recentSearchInput(keyword, id);
			}
			mView.addObject("keyword", keyword);
		}
		
		mView.setViewName("bookList/conditionSearch.page");
		
		return mView;
	}
}

