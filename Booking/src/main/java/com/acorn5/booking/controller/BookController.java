package com.acorn5.booking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.BookSelectService;
import com.acorn5.booking.book.service.BookService;
 
 
@Controller
public class BookController {
	
    @Autowired
    private BookService service; 
    
    @Autowired
    private BookSelectService s_service;
    
    //키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("bookList.do")
    public ModelAndView bookList(@RequestParam(required=false)String keyword){
        ModelAndView mav = new ModelAndView();
        
        if(keyword !=null)
        {
            mav.addObject("bookList", service.searchBook(keyword, 10, 1));
        }
        mav.setViewName("bookList");
        return mav;
    }
    @RequestMapping("/review/private/insertform.do")
    public ModelAndView bookSelect(@RequestParam(required=false)String d_isbn) {
    	ModelAndView mav=new ModelAndView();
    	// 만약 d_isbn 에 값이 들어온다면
    	if(d_isbn !=null)
        {
            mav.addObject("bookList", s_service.selectBook(d_isbn, 5, 1, mav));
        }
        mav.setViewName("bookList");
        return mav;
    }
    
}