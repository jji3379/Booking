package com.acorn5.booking.book.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.BookService;
 
@Controller
public class BookController {
    @Autowired
    private BookService service; 
    
    //by 준익, 카테고리별 페이징 검색을 위한 컨트롤러_2021.02.28
    @RequestMapping("/bookList/CategoryList.do") //by 준익, bookList 폴더에 있는 CategoryList 파일에 적용_2021.02.28 
    public ModelAndView categoryList(@RequestParam("d_catg")String d_catg, int start, //by 준익, 카테고리별로 적용 받기 위해서 d_catg, 페이징 값을 얻기 위한 start 값 받기_2021.02.28
    								HttpServletRequest request, ModelAndView mav){
    	mav.addObject("categoryList", service.pagingCategory("1", 10, start, d_catg, request, mav)); //by 준익, categoryList 에 pagingCategory 서비스를 거친 값들을 넣어준다 (목차 : 1, 화면에 출력할 개수 : 10)_2021.02.28 
    	mav.setViewName("bookList/CategoryList");
        return mav;
    }
}