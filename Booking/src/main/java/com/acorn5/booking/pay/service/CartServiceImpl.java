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
		String id=(String)request.getSession().getAttribute("id");
		cartDao.insert(dto);	
	}
	//by준영, 북카트 리스트_210308
	@Override
	public void listCart(ModelAndView mView, HttpServletRequest request) {
		String id=(String)request.getSession().getAttribute("id");
		List<CartDto> list = cartDao.getlist(id);
		//장바구니에 담긴 배열의 size를 담을 basketCount
		int basketCount=list.size();
		//id 값이 null이 아니고 리스트의 사이즈가 0이 아니면 count 객체에 담기 
		//navbar에 담기 위한 작업
		if(id != null && basketCount!=0) {
			mView.addObject("count",basketCount);
		}
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
	public void deletPay(String id,HttpServletRequest request) {
		cartDao.pay_delete(id);
	}
	

	
}
