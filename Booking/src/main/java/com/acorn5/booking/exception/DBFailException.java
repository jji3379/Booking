package com.acorn5.booking.exception;

public class DBFailException extends RuntimeException{
	//생성자
	public DBFailException(String message) {
		super(message);
	}
}