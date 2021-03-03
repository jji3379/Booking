package com.acorn5.booking.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/* 
 * Spring Framework 가 동작하는 중에 특정 예외가 발생하면 여기에서 직접 응답하고자 할때 사용한다.
 */
@ControllerAdvice
public class ExceptionController {
	// by 남기, NowAllowException type 의 예외가 발생하면 호출되는 메소드_210303 
	@ExceptionHandler(NotAllowException.class)
	public ModelAndView notAllow(NotAllowException ne) {
		ModelAndView mView=new ModelAndView();
		mView.addObject("exception", ne);
		mView.setViewName("error/not_allow");
		return mView;
	}
	
	// DBFailException type 의 예외가 발생하면 호출되는 메소드 
	@ExceptionHandler(DBFailException.class)
	public ModelAndView dbFail(DBFailException e) {
		ModelAndView mView=new ModelAndView();
		// "exception"  이라는 키값으로 예외객체의 참조값을 담고
		// 담은 예외객체는 view page 에서  ${exception.message } 형태로 사용한다.
		mView.addObject("exception", e);
		mView.setViewName("error/db_fail");
		return mView;
	}
}