package com.acorn5.booking.map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.service.CartService;

@Controller
public class MapController {
	
	@RequestMapping("/map")
	public String mapsearch(ModelAndView mView) {
		
		//mView.setViewName("map/mapsearch.page");
        return "map/mapsearch.page";
	}
}