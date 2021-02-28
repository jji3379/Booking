package com.acorn5.booking.exception;

public class NotAllowException extends RuntimeException{
	//생성자
	public NotAllowException(String msg) {
		super(msg);
	}
}