package com.acorn5.booking.book.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.book.service.BookService;

@RestController
@RequestMapping("/v1")
public class BookApiController {
	@Autowired
    private BookService service; 
	
    //by준영, bookList.jsp 에 cont, sort 를 인자로 리스트 검색하는 서비스_210222
    @RequestMapping("/bestSeller")
    public List<BookDto> bestSeller(HttpServletRequest request){
    	Long id=(Long)request.getSession().getAttribute("id");
    	//if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	//cartservice.listCart(mView, request);
    	//}
            //service.bestSeller("1", 10, 1, "count");
        return service.bestSeller("1", 10, 1, "count");
    }
}
