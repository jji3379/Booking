package com.acorn5.booking.book.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;
 
@Controller
public class BookController {
    @Autowired
    private BookService service; 
    //by우석, navbar cartitem count 보이기위한 cartservice 주입_20210315
    @Autowired
    private CartService cartservice;
    @Autowired
	private UsersDao dao;
    
    //by 준익, 카테고리별 페이징 검색을 위한 컨트롤러_2021.02.28
    @RequestMapping("/bookList/CategoryList.do") //by 준익, bookList 폴더에 있는 CategoryList 파일에 적용_2021.02.28 
    public ModelAndView categoryList(@RequestParam("d_catg")String d_catg, int start, String sort, //by 준익, 카테고리별로 적용 받기 위해서 d_catg, 페이징 값을 얻기 위한 start 값 받기_2021.02.28
    								HttpServletRequest request, ModelAndView mView){
    	String id=(String)request.getSession().getAttribute("id");
    	if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	cartservice.listCart(mView, request);
    	}
    	
    	mView.addObject("categoryList", service.pagingCategory("1", 8, start, d_catg, request, mView, sort)); //by 준익, categoryList 에 pagingCategory 서비스를 거친 값들을 넣어준다 (목차 : 1, 화면에 출력할 개수 : 10)_2021.02.28 
    	mView.setViewName("bookList/CategoryList");
        return mView;
    }
	
    //by준영, bookList.jsp 에 cont, sort 를 인자로 리스트 검색하는 서비스_210222
    @RequestMapping("/bookList/bestSeller.do")
    public ModelAndView bestSeller(@RequestParam(required=false)String d_cont,String sort, HttpServletRequest request, int start, ModelAndView mView){
    	String id=(String)request.getSession().getAttribute("id");
    	if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	cartservice.listCart(mView, request);
    	}
        if(d_cont !=null)
        {
            mView.addObject("bestSeller",service.bestSeller(d_cont, 8, start, "count", request, mView));
        }
        mView.setViewName("bookList/bestSeller");
        return mView;
    }
    
    //by준영, bookDetail.jsp 에 isbn 을 인자로 리스트(리스트지만 한권) 검색하는 서비스_210222
    @RequestMapping("/detail/bookDetail.do")
    public ModelAndView bookDetail(@RequestParam(required=false)String d_isbn){
    	ModelAndView mView = new ModelAndView();
        
        if(d_isbn !=null)
        {
            mView.addObject("bookDetail",service.bookDetail(d_isbn,1));
        }
        mView.setViewName("detail/bookDetail");
        return mView;
    
    }
    //by준영, bookAjax.jsp 에 저자를 인자로 리스트 검색하는 서비스_210222
    @RequestMapping("/detail/detailAjax.do")
    public ModelAndView bookAjax(@RequestParam(required=false)String d_auth,String sort){
    	ModelAndView mView = new ModelAndView();
        
        if(d_auth !=null)
        {
            mView.addObject("detailAjax",service.detailAjax(d_auth,30,sort));
        }
        mView.setViewName("detail/detailAjax");
        return mView;
        }
	
    
    //by남기, reviewBookList.jsp 에 keyword 를 인자로 리스트 검색하는 서비스_210303 
    @RequestMapping("/review/reviewBookList.do")
    public ModelAndView reviewBookList(@RequestParam(required=false)String keyword, HttpServletRequest request,HttpSession session){    
        ModelAndView mView = new ModelAndView();
        String id = (String) session.getAttribute("id");
        UsersDto dto = null;
        if(keyword !=null)
        {
            mView.addObject("reviewBookList", service.searchBookList(keyword, 8, 1, request, mView));
        }else {
        	if(id != null && dao.getData(id).getRecentSearch() != null) { //세션에 로그인된 아이디가 저장되어 있으면
    			int nansu = new Random().nextInt(2); // 0 or 1 난수 얻기
    			//by 우석, view page 에서 cartitem 불러오기_210315
    			if(nansu==0) { //난수가 0이면 관심사 기반
    				dto = dao.getData(id); // 로그인된 회원의 정보 얻어오기
    				String query = dto.getCare(); // 회원의 관심사를 query로 설정
    				mView.addObject("reviewBookList", service.recommendBook(8, 1,"count", query, mView));
    			} else { //난수가 1이면 최근검색어 기반_210310
    				dto = dao.getData(id);
    				String query = dto.getRecentSearch();
    				System.out.println(query);
    				mView.addObject("reviewBookList", service.recommendBook(8, 1,"count", query, mView));
    			}
    		}else if (id==null) { // 로그인을 안한경우 
    			mView.addObject("reviewBookList", service.recommendBook("1",8, 1,"count", mView));
    		}else if (id!=null && dao.getData(id).getRecentSearch() == null) {// 로그인된 아이디의 최근검색어가 없는경우
    			dto = dao.getData(id); 
    			String query = dto.getCare(); 
    			mView.addObject("reviewBookList", service.recommendBook(8, 1,"count", query, mView));
    		}
        }
		//by 우석, view page 에서 cartitem 불러오기_210315
		if(id!=null) {			
			cartservice.listCart(mView, request);
		}
        mView.setViewName("review/reviewBookList");
        return mView;
    }
    
    //by남기, reviewInsertform.jsp 에 d_isbn 을 인자로 도서 정보를 가져오는 서비스_210303
    @RequestMapping("/review/private/reviewInsertform.do")
    public ModelAndView reviewBook(@RequestParam(required=false)String d_isbn, HttpServletRequest request){
        ModelAndView mView = new ModelAndView();
    	cartservice.listCart(mView, request);
        if(d_isbn !=null)
        {
            mView.addObject("reviewBook", service.bookReview(d_isbn, 1));
        }
        mView.setViewName("review/private/reviewInsertform");
        return mView;
    }
    // by 준익, 조건 검색 페이징 컨트롤러_2021.03.09
    @RequestMapping("/bookList/conditionSearch.do")
    public ModelAndView conditionSearch(@RequestParam(required=false)String keyword,int start,
          HttpServletRequest request, ModelAndView mView){    
       if(keyword !=null) { 
    	 //by욱현.검색시 최근검색어 칼럼에 검색키워드를 담기_2021308
          HttpSession session = request.getSession();
          String id = (String) session.getAttribute("id");
          if(id != null) {
         	 service.recentSearchInput(keyword, id);
         	 //by 우석, view page 에서 cartitem 불러오기_210315
         	 cartservice.listCart(mView, request); 
          }
          mView.addObject("conditionSearch",service.conditionSearch(keyword, 8, start, request, mView));
       }
        mView.setViewName("bookList/conditionSearch");
        return mView;
    }
}