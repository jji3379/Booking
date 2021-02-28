package com.acorn5.booking;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;

@Controller
public class HomeController {
	
	@Autowired
    private BookService service;//by욱현. 홈페이지에 추천도서를 불러오는 메소드가 담긴 서비스_2021223
	
	@Autowired
	private UsersDao dao;
	
	@RequestMapping("/home.do")
	public ModelAndView home(HttpSession session) {
		
		ModelAndView mView = new ModelAndView();
		                                               
		String id = (String) session.getAttribute("id");
		UsersDto dto = null;
		if(id != null) { //세션에 로그인된 아이디가 저장되어 있으면
			dto = dao.getData(id); // 로그인된 회원의 정보 얻어오기
			String query = dto.getCare(); // 회원의 관심사를 query로 설정
			service.recommendBook(12, 1,"count", query, mView);
		}else {
			service.recommendBook("1",12, 1,"count", mView);
		}
		
		mView.addObject("dto", dto);//by욱현. 뷰페이지로 로그인된 회원의 회원정보 전달_2021225
		mView.setViewName("home");
		
		return mView;
	}
	
	@RequestMapping("/booking.do")
	@ResponseBody
	public Map<String, Object> booking() {
		//책을 랜덤으로 추천해야 하니까
		int ran = (int) (Math.random()*100 + 1);
		// 부킹버튼을 눌러 요청하는순간 올랜덤 검색 로직 실행 및 이미지경로와 isbn만 맵객체에 넣어서 받기
		Map<String, Object> data = service.recommendBook("1",1, ran);
		// 뷰페이지로 이동 후  자바스크립트로 추출 (ajax로 그부분만 뿌려주기) 
		
		return data;
	}
	
}