package com.acorn5.booking.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.service.BookService;
import com.acorn5.booking.service.BookServiceImpl; 
 
@Controller
public class BookController {
    @Autowired
    private BookService service; 
    
    @RequestMapping(value = "/bookList/CategoryList.do", method = RequestMethod.GET)
    public ModelAndView categoryList(@RequestParam("d_catg")String d_catg, 
    		HttpServletRequest request, int start, ModelAndView mav){
    		mav.addObject("categoryList", service.pagingCategory("9", 10, start, d_catg, request, mav));
    	mav.setViewName("bookList/CategoryList");
        return mav;
    }
}