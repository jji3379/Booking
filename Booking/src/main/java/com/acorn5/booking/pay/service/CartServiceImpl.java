package com.acorn5.booking.pay.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.dao.CartDao;
import com.acorn5.booking.pay.dto.CartDto;

@Service
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDao cartDao;
	//by준영, 장바구니 담기(저장) 처리_210308
	@Override
	public void insertCart(CartDto dto,HttpServletRequest request) {
		String id=(String)request.getParameter("id");
		String image=(String)request.getParameter("image");
		String title=(String)request.getParameter("title");
		int price=Integer.parseInt(request.getParameter("price"));
		int d_price=Integer.parseInt(request.getParameter("d_price"));
		int count=Integer.parseInt(request.getParameter("count"));
		dto.setId(id);
		dto.setImage(image);
		dto.setTitle(title);
		dto.setD_price(d_price);
		dto.setPrice(d_price);
		dto.setCount(count);
		cartDao.insert(dto);	
	}
	//by준영, 북카트 리스트_210308
	@Override
	public void listCart(ModelAndView mView, HttpServletRequest request) {
		String id=request.getParameter("id");
		List<CartDto> list = cartDao.getlist(id);
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);
	}
	//by, 카트 개별 삭제 요청처리_210310
	@Override
	public void deleteCart(int c_id) {
		cartDao.delete(c_id);
	}
	//by준영, 체크된 카트 삭제_210313
	@Override
	public void deleteChk(String[] ajaxMsg) {
		String[] c_id=ajaxMsg;
		for(int i = 0; i < c_id.length; i++) {
			cartDao.chk_delete(c_id[i]);
		}
	}
	//by준영, 북카트 내 도서 수량변경_210310
	@Override
	public void update(CartDto dto) {
		cartDao.update(dto);
		
	}
	//by_준영, 결제완료시 해당상품 삭제_210314
	@Override
	public void deletPay(String id) {
		cartDao.pay_delete(id);
	}
	

	
}