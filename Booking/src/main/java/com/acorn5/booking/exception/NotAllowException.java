package com.acorn5.booking.exception;

public class NotAllowException extends RuntimeException{
	// by 남기, NotAllowException 이 발생했을때 관리하는 생성자_210303

	public NotAllowException(String msg) {
		super(msg);
	}
}