package com.acorn5.booking.book.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.AjaxService;
import com.acorn5.booking.book.service.DetailService;
import com.acorn5.booking.book.service.NaverBookService;

@Controller
public class BookController {
    @Autowired
    private NaverBookService n_service;//by준영, bookList.jsp 에 cont, sort 를 인자로 리스트 검색하는 서비스_210222
   
  
    @RequestMapping("/bookList")
    public ModelAndView bookList(@RequestParam(required=false)String d_cont,String sort){
        ModelAndView mav = new ModelAndView();
        
        if(d_cont !=null)
        {
            mav.addObject("bookList",n_service.searchBook(d_cont,12, 1,sort));
        }
        mav.setViewName("bookList");
        return mav;
    }
    @Autowired
    private DetailService d_service;//by준영, bookDetail.jsp 에 isbn 을 인자로 리스트(리스트지만 한권) 검색하는 서비스_210222
  
    @RequestMapping("/bookDetail")
    public ModelAndView bookDetail(@RequestParam(required=false)String d_isbn){
    	ModelAndView mav = new ModelAndView();
        
        if(d_isbn !=null)
        {
            mav.addObject("bookDetail",d_service.DetailBook(d_isbn,1));
        }
        mav.setViewName("bookDetail");
        return mav;
    
    }
    @Autowired
    private AjaxService a_service;//by준영, bookAjax.jsp 에 저자를 인자로 리스트 검색하는 서비스_210222
    
    @RequestMapping("/bookAjax")
    public ModelAndView bookAjax(@RequestParam(required=false)String d_auth,String sort){
    	ModelAndView mav = new ModelAndView();
        
        if(d_auth !=null)
        {
            mav.addObject("bookAjax",a_service.AjaxBook(d_auth,30,sort));
        }
        mav.setViewName("bookAjax");
        return mav;
        }
    
    
    //글 목록 요청처리
  	@RequestMapping("/cafe/list")
  	public ModelAndView list(ModelAndView mView, 
  			HttpServletRequest request) {
  		
  		service.getList(mView, request);
  		
  		mView.setViewName("cafe/list");
  		return mView;
  	}
    
}


