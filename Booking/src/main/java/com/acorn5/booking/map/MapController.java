package com.acorn5.booking.map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {
	@RequestMapping("/map/mapsearch")
	public String mapsearch() {
		return "map/mapsearch";
	}

}