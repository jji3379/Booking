package com.acorn5.booking.map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.service.CartService;

@Controller
public class MapController {
	//by우석, navbar cartitem count 보이기위한 cartservice 주입_20210315
	@Autowired
    private CartService cartservice;
	
	@RequestMapping("/map/mapsearch")
	public ModelAndView mapsearch(ModelAndView mView,HttpServletRequest request) {
		String id=(String)request.getSession().getAttribute("id");
    	if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	cartservice.listCart(mView, request);
    	}
		mView.setViewName("map/mapsearch");
        return mView;
		
	}
}