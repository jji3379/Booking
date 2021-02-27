package com.acorn5.booking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.book.service.ReviewBookService;
 
 
@Controller
public class BookController {
	//의존객체 DI 을 필드에 선언해둔다.
    @Autowired
    private BookService service; 
    
    //키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("/review/bookList.do")
    public ModelAndView bookList(@RequestParam(required=false)String keyword){
        ModelAndView mav = new ModelAndView();
        
        if(keyword !=null)
        {
            mav.addObject("bookList", service.searchBook(keyword, 10, 1));
        }
        mav.setViewName("review/bookList");
        return mav;
    }
	//의존객체 DI 을 필드에 선언해둔다.
    @Autowired
    private ReviewBookService b_service; 
    
    //키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("/review/private/insertform.do")
    public ModelAndView reviewBook(@RequestParam(required=false)String d_isbn){
        ModelAndView mav = new ModelAndView();
        
        if(d_isbn !=null)
        {
            mav.addObject("reviewBook", b_service.bookReview(d_isbn, 1));
        }
        mav.setViewName("review/private/insertform");
        return mav;
    }
}