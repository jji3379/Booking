package com.acorn5.booking.order.dto;

import java.util.Date;

public class OrderSum {
   private int o_id; //주문번호
   private Date o_date; //주문일자
   private int totalPayment; //주문금액
   private int totalNum; //주문갯수
   private int startRowNum; // 시작 번호
   private int endRowNum; // 마지막 번호
   
   public int getO_id() {
      return o_id;
   }
   public void setO_id(int o_id) {
      this.o_id = o_id;
   }
   public Date getO_date() {
      return o_date;
   }
   public void setO_date(Date o_date) {
      this.o_date = o_date;
   }
   public int getTotalPayment() {
      return totalPayment;
   }
   public void setTotalPayment(int totalPayment) {
      this.totalPayment = totalPayment;
   }
   public int getTotalNum() {
      return totalNum;
   }
   public void setTotalNum(int totalNum) {
      this.totalNum = totalNum;
   }
   public int getStartRowNum() {
      return startRowNum;
   }
   public void setStartRowNum(int startRowNum) {
      this.startRowNum = startRowNum;
   }
   public int getEndRowNum() {
      return endRowNum;
   }
   public void setEndRowNum(int endRowNum) {
      this.endRowNum = endRowNum;
   }
   
   
}