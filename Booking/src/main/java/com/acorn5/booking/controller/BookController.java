package com.acorn5.booking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.service.NaverBookService;
 
 
@Controller
public class BookController {
    @Autowired
    private NaverBookService service; 
    
    //키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("bookList.do")
    public ModelAndView bookList(@RequestParam(required=false)String d_cont, String d_catg){
        ModelAndView mav = new ModelAndView();
        
        if(d_cont !=null)
        {
            mav.addObject("bookList",service.searchBook(d_cont, 10, 1, d_catg));
        }
        mav.setViewName("bookList");
        return mav;
    }
}