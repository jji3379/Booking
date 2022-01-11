package com.acorn5.booking.order.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.order.dao.OrderDao;
import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.order.dto.OrderSum;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.QOrder;
import com.acorn5.booking.order.repository.OrderRepository;
import com.acorn5.booking.review.dao.ReviewDao;
import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.users.entity.QUsers;
import com.acorn5.booking.users.entity.Users;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class OrderServiceImpl implements OrderService {
	//@Autowired
	//private OrderDao dao;
	
	@PersistenceContext
	EntityManager em;
	
	//@Autowired
	//private ReviewDao reviewDao;
	
	@Autowired
	private OrderRepository orderRepository; 
	
	//by욱현, my_order에 테이블에 담기_210317
	@Override
	public Order orderInsert(Order dto, HttpServletRequest request) {
		// 전송된 파라미터들을 받는다.
		// form 으로 전송하면 안되는건가???
		/*
		Long id = Long.parseLong(request.getParameter("o_id"));
		Long buyer = Long.parseLong(request.getParameter("buyer"));
		String image = request.getParameter("image");
		String title = request.getParameter("title");
		int price = Integer.parseInt(request.getParameter("price"));
		int d_price = Integer.parseInt(request.getParameter("d_price"));
		int count = Integer.parseInt(request.getParameter("count"));
		String isbn = request.getParameter("isbn");
		*/
		// dto객체에 담기
		/*
		dto.setId(id);
		dto.setBuyer(buyer);
		dto.setImage(image);
		dto.setTitle(title);
		dto.setPrice(price);
		dto.setD_price(d_price);
		dto.setCount(count);
		dto.setIsbn(isbn);
		*/
		Users users = new Users();
		Long loginId=(Long)request.getSession().getAttribute("id");
		if(loginId != null) {
			users.setId(loginId);
			dto.setBuyer(users);
			//dto객체 전달해서 db수정
		}
		return orderRepository.save(dto);
		//dao.insertOrder(dto);
	}

	//by욱현, my_order에서 구매자 주문내역 불러오기 로직 _2021317
	@Override
	public List<Order> getMyOrder(Long id, HttpServletRequest request) {
		
		//Long id = (Long) session.getAttribute("id");
		//회원의 주문내역 전체 얻기 
		Users buyerId = new Users();
		buyerId.setId(id);
		//List<Order> list = orderRepository.findByBuyer(buyerId); 
				//dao.getMyOrder((String)session.getAttribute("id"));
		//주문번호 끼리 묶기
		//List<OrderSum> orderList = new ArrayList<OrderSum>();
		
		JPAQueryFactory query = new JPAQueryFactory(em);
		QOrder qOrder = QOrder.order;
		QUsers qUsers = QUsers.users;
		
		List<Order> orderGroupList = query.selectFrom(qOrder)
				.join(qOrder.buyer, qUsers)
				.fetchJoin()
				.where(qOrder.buyer.eq(buyerId))
				.groupBy(qOrder.o_date)
				.fetch();
		
		/*
		Long preO_id = (long) 0; //이전인덱스의 책의 주문번호
		for (int i = 0; i < list.size(); i++) {
			Order orderDto = list.get(i); //주문내역 하나를 얻어냄
			Long o_id = orderDto.getId(); //하나의 주문내역의 주문번호를 얻어냄
			if(o_id!= preO_id) { // 현제인덱스의 책의 주문번호가 이전인덱스의 책의 주문번호와 같지 않다면
				preO_id = o_id; // 현재인덱스의 책의 주문번호를 preO_id에  넣어주고
				//같은 주문번호를 가진 주문책내역들을 불러와서 하나의 OrderSum객체에 담는다. 
				List<Order> olist = orderRepository.findById(o_id); 
						//dao.getMyOrder2(o_id); //같은 주문번호의 주문내역들을 불러냄
				OrderSum os = new OrderSum(); // 주문번호 별 row
				int totalPayment = 0;
				int totalNum = 0;
				for(int j=0;j<olist.size();j++) {
					Order oDto = olist.get(j); 
					//os.setId(oDto.getId()); //주문번호
					os.setO_date(oDto.getO_date()); //주문날짜
					totalPayment += oDto.getD_price(); //총주문금액
					totalNum += oDto.getCount(); //책갯수
					
				}
				os.setTotalPayment(totalPayment);
				os.setTotalNum(totalNum);
				orderList.add(os);
			} 
			
		}
		*/
		/*
		final int DISPLAY_COUNT = 5;
		final int PAGE_DISPLAY_COUNT=5;

		
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){//만일 페이지 번호가 파라미터로 넘어 온다면
			pageNum=Integer.parseInt(strPageNum);
		}
		
		int endRow = (pageNum-1)*DISPLAY_COUNT+4;
		int startRow =  (pageNum*DISPLAY_COUNT) - DISPLAY_COUNT;
		int totalRow = orderList.size();

		List<OrderSum> osslist = new ArrayList<>();
		OrderSum oss = null;
		if(totalRow<= endRow) {
			for(int i=startRow; i<=totalRow-1; i++) {
				oss = orderList.get(i);
				osslist.add(oss);
			}
		} else {
			for(int i=startRow; i<=endRow; i++) {
				oss = orderList.get(i);
				osslist.add(oss);
			}
		}
		
		int startPageNum = 1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT-1;
	
		
		int totalPageCount=(int)Math.ceil(totalRow/(double)DISPLAY_COUNT);
		// by남기, 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다_210303
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; // by남기, 만약 끝 번호가 전체보다 크다면 보정해준다_210303
		}
		*/
		//mView.addObject("oslist", osslist);
		/*
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("totalRow", totalRow);
		*/
		return orderGroupList;
	}
	
	//by욱현, order_detail에서 주문내역 디테일 불러오는 로직_2021320
	@Override
	public List<Order> getOrderDetail(Long id, HttpServletRequest request) {
		Long orderId = Long.parseLong(request.getParameter("o_id"));
		if (orderId != null) {
			//mView.addObject("list", list);
			//dao.getOrderDetail(o_id);
		}
		// 이거 수정해야됨
		List<Order> list = orderRepository.findAll();
		return list;
	}
}
