package com.acorn5.booking.review.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.exception.DBFailException;
import com.acorn5.booking.review.dao.ReviewCommentDao;
import com.acorn5.booking.review.dao.ReviewDao;
import com.acorn5.booking.review.dto.ReviewCommentDto;
import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	// by남기, 빈에서 핵심 의존객체(ReviewDao)를 DI 할 준비를 한다_210303
	@Autowired
	private ReviewDao reviewDao;
	
	// by남기, 빈에서 핵심 의존객체(ReviewDao)를 DI 할 준비를 한다_210303
	@Autowired
	private ReviewCommentDao reviewCommentDao;
	
	// by남기, 새 리뷰를 저장하는 메소드_210303
	@Override
	public void saveContent(ReviewDto dto, HttpServletRequest request) {
		// by남기, dto 에 업로드된 파일의 정보를 담는다_210303
		String id=(String)request.getSession().getAttribute("id");
		String imagePath=request.getParameter("imagePath");
		String spoCheck=request.getParameter("spoCheck");
		int rating=Integer.parseInt(request.getParameter("rating"));
		dto.setWriter(id); // by남기, 세션에서 읽어낸 파일 업로더의 아이디 _210303
		dto.setImagePath(imagePath);

		dto.setSpoCheck(spoCheck);
		dto.setRating(rating);
		// by남기, ReviewDao 를 이용해서 DB 에 저장하기_210303
		reviewDao.insert(dto);	
	}
	// by남기, 글목록을 얻어오고 페이징 처리에 필요한 값들을 ModelAndView 객체에 담아주는 메소드 _210303
	@Override
	public List<ReviewDto> getList(ModelAndView mView, HttpServletRequest request) {
		// by남기, 한 페이지에 몇개씩 표시할 것인지_210303
		final int PAGE_ROW_COUNT=5;
		// by남기, 하단 페이지를 몇개씩 표시할 것인지_210303
		final int PAGE_DISPLAY_COUNT=5;
		
		// by남기, 보여줄 페이지의 번호를 일단 1이라고 초기값 지정_210303
		int pageNum=1;
		// by남기, 페이지 번호가 파라미터로 전달되는지 읽어와 본다_210303
		String strPageNum=request.getParameter("pageNum");
		// by남기, 만일 페이지 번호가 파라미터로 넘어 온다면_210303
		if(strPageNum != null){
			// by남기, 숫자로 바꿔서 보여줄 페이지 번호로 지정한다_210303
			pageNum=Integer.parseInt(strPageNum);
		}
		
		// by남기, 보여줄 페이지의 시작 ROWNUM_210303
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		// by남기, 보여줄 페이지의 끝 ROWNUM_210303
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		/*
		 *  by남기, 
			[ 검색 키워드에 관련된 처리 ]
			-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다 _210303	
		*/
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		// by남기, 만일 키워드가 넘어오지 않는다면 _210303
		if(keyword==null){
			// by남기, 키워드와 검색 조건에 빈 문자열을 넣어준다 _210303
			// by남기, 클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  _210303
			keyword="";
			condition=""; 
		}
		
		// by남기, 특수기호를 인코딩한 키워드를 미리 준비한다 _210303
		String encodedK=URLEncoder.encode(keyword);
		
		// by남기, startRowNum 과 endRowNum  을 ReviewDto 객체에 담는다 _210303

		ReviewDto dto=new ReviewDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		// by남기, ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다 _210303
		List<ReviewDto> list=null;
		// by남기, 전체 row 의 갯수를 담을 지역변수를 미리 만든다 _210303
		int totalRow=0;
		// by남기, 만일 검색 키워드가 넘어온다면 _210303
		if(!keyword.equals("")){
			// by남기, 검색 조건이 무엇이냐에 따라 분기 하기_210303
			if(condition.equals("reviewTitle_content")){// by남기, 제목 + 내용 검색인 경우_210303
				// by남기, 검색 키워드를 ReviewDto 에 담아서 전달한다_210303
				dto.setReviewTitle(keyword);
				dto.setContent(keyword);	
			}else if(condition.equals("reviewTitle")){ // by남기, 제목 검색인 경우_210303
				dto.setReviewTitle(keyword);			
			}else if(condition.equals("writer")){ // by남기, 작성자 검색인 경우_210303
				dto.setWriter(keyword);	
			}else if(condition.equals("isbn")){ // by남기, 고유번호 검색인 경우_210303
				dto.setIsbn(keyword);	
			}// by남기, 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다_210303
		}
		// by남기, 글목록 얻어오기_210303
		list=reviewDao.getList(dto);
		// by남기, 글의 갯수_210303
		totalRow=reviewDao.getCount(dto);
		
		// by남기, 하단 시작 페이지 번호_210303 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		// by남기, 하단 끝 페이지 번호_210303
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		
		// by남기, 전체 페이지의 갯수 구하기_210303
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		// by남기, 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다_210303
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; // by남기, 만약 끝 번호가 전체보다 크다면 보정해준다_210303
		}		
		
		// by남기, view page 에서 필요한 내용을 ModelAndView 객체에 담아준다_210303
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("condition", condition);
		mView.addObject("keyword", keyword);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);
		
		return list;
	}
	// by남기, 저장된 이미지를 얻어오고 이미지 파일을 MultipartFile 객체에 담아주는 메소드 _210303
	@Override
	public String saveImage(MultipartFile image, HttpServletRequest request) {
		// by남기, 원본 파일명 _210303
		String orgFileName=image.getOriginalFilename();
		// by남기, webapp/upload 폴더 까지의 실제 경로(서버의 파일시스템 상에서의 경로) _210303
		String realPath=request.getServletContext().getRealPath("/upload");
		// by남기, 저장할 파일의 상세 경로 _210303
		String filePath=realPath+File.separator;
		// by남기, 디렉토리를 만들 파일 객체 생성 _210303
		File upload=new File(filePath);
		if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면 
			upload.mkdir(); //만들어 준다.
		}
		// by남기, 저장할 파일 명을 구성한다 _210303
		String saveFileName=
				System.currentTimeMillis()+orgFileName;
		try {
			// by남기, upload 폴더에 파일을 저장한다 _210303
			image.transferTo(new File(filePath+saveFileName));
			System.out.println(filePath+saveFileName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		// by남기, 업로드 경로를 리턴한다 _210303
		return "/upload/"+saveFileName;
	}
	// by남기, 리뷰를 수정하는 메소드_210303
	@Override
	public void updateContent(ReviewDto dto) {
		reviewDao.update(dto);
	}
	// by남기, 리뷰를 삭제하는 메소드_210303
	@Override
	public void deleteContent(int num) {
		reviewDao.delete(num);
	}
	// by남기, 리뷰 하나의 정보를 ModelAndView 객체에 담아주는 메소드_210303
	@Override
	public void getDetail(int num, ModelAndView mView) {
		// by남기, 글번호를 이용해서 글정보를 얻어오고  _210303
		ReviewDto dto=reviewDao.getData(num);
		// by남기, 글정보를 ModelAndView 객체에 담고 _210303
		mView.addObject("dto", dto);
		// by남기, 글 조회수를 증가 시킨다 _210303
		reviewDao.addViewCount(num);
		/*  by남기, 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다  _210303 */
		final int PAGE_ROW_COUNT=5;

		// by남기, 보여줄 페이지의 번호 _210303
		int pageNum=1;

		// by남기, 보여줄 페이지 데이터의 시작 ResultSet row 번호 _210303
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		// by남기, 보여줄 페이지 데이터의 끝 ResultSet row 번호 _210303
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		// by남기, 전체 row 의 갯수를 읽어온다 _210303
		int totalRow=reviewCommentDao.getCount(num);
		// by남기, 전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// by남기, CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다 _210303
		ReviewCommentDto reviewCommentDto=new ReviewCommentDto();
		reviewCommentDto.setStartRowNum(startRowNum);
		reviewCommentDto.setEndRowNum(endRowNum);
		// by남기, ref_group 번호도 담는다 _210303
		reviewCommentDto.setRef_group(num);

		// by남기, DB 에서 댓글 목록을 얻어온다 _210303
		List<ReviewCommentDto> reviewCommentList=reviewCommentDao.getList(reviewCommentDto);
		// by남기, ModelAndView 객체에 댓글 목록도 담아준다 _210303
		mView.addObject("reviewCommentList", reviewCommentList);
		mView.addObject("totalPageCount", totalPageCount);
		
	}
	// by남기, 리뷰의 댓글을 저장하는 메소드 _210303
	@Override
	public void saveComment(HttpServletRequest request) {
		// by남기, 댓글 작성자(로그인된 아이디) _210303
		String writer=(String)request.getSession().getAttribute("id");
		// by남기, 폼 전송되는 댓글의 정보 얻어내기 _210303
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		String target_id=request.getParameter("target_id");
		String content=request.getParameter("content");
		/*
		 *  by남기, 
		 * 원글의 댓글은 comment_group 번호가 전송이 안되고
		 * 댓글의 댓글은 comment_group 번호가 전송이 된다.
		 * 따라서 null 여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판별할수 있다  _210303
		 */
		String comment_group=request.getParameter("comment_group");
		// by남기, 새 댓글의 글번호는 미리 얻어낸다  _210303
		int seq=reviewCommentDao.getSequence();
		// by남기, 저장할 새 댓글 정보를 dto 에 담기 _210303
		ReviewCommentDto dto=new ReviewCommentDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_id(target_id);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		if(comment_group == null) {// by남기, 원글의 댓글인 경우 _210303 
			// by남기, 댓글의 글번호와 comment_group 번호를 같게 한다 _210303
			dto.setComment_group(seq);
		}else {// by남기, 댓글의 댓글인 경우  _210303
			// by남기, 폼 전송된 comment_group 번호를 숫자로 바꿔서 dto 에 넣어준다 _210303
			dto.setComment_group(Integer.parseInt(comment_group));
		}
		// by남기, 댓글 정보를 DB 에 저장한다 _210303
		reviewCommentDao.insert(dto);
	}

	// by남기, 리뷰의 댓글을 삭제하는 메소드 _210303
	@Override
	public void deleteComment(HttpServletRequest request) {
		// by남기, GET 방식 파라미터로 전달되는 삭제할 댓글 번호  _210303
		int num=Integer.parseInt(request.getParameter("num"));
		// by남기, 세션에 저장된 로그인된 아이디 _210303
		String id=(String)request.getSession().getAttribute("id");
		// by남기, 댓글의 정보를 얻어와서 댓글의 작성자와 같은지 비교 한다 _210303
		String writer=reviewCommentDao.getData(num).getWriter();
		if(!writer.equals(id)) {
			throw new DBFailException("남의 댓글을 삭제 할수 없습니다.");
		}
		reviewCommentDao.delete(num);
	}
	// by남기, 리뷰의 댓글을 수정하는 메소드 _210303
	@Override
	public void updateComment(ReviewCommentDto dto) {
		reviewCommentDao.update(dto);
	}
	// by남기, 리뷰의 댓글들을 추가로 응답하는 메소드 _210303
	@Override
	public void moreCommentList(HttpServletRequest request) {
		// by남기, 파라미터로 전달된 pageNum 과 ref_group 번호를 읽어온다 _210303
		int pageNum=Integer.parseInt(request.getParameter("pageNum"));
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));

		ReviewDto dto=reviewDao.getData(ref_group);
		request.setAttribute("dto", dto);

		/* by남기, 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다 _210303*/
		final int PAGE_ROW_COUNT=5;

		// by남기, 보여줄 페이지 데이터의 시작 ResultSet row 번호 _210303
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		// by남기, 보여줄 페이지 데이터의 끝 ResultSet row 번호 _210303
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		// by남기, 전체 row 의 갯수를 읽어온다 _210303
		int totalRow=reviewCommentDao.getCount(ref_group);
		// by남기, 전체 페이지의 갯수 구하기 _210303
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// by남기, CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다 _210303
		ReviewCommentDto reviewCommentDto=new ReviewCommentDto();
		reviewCommentDto.setStartRowNum(startRowNum);
		reviewCommentDto.setEndRowNum(endRowNum);
		// by남기, ref_group 번호도 담는다 _210303
		reviewCommentDto.setRef_group(ref_group);

		// by남기, DB 에서 댓글 목록을 얻어온다 _210303
		List<ReviewCommentDto> reviewCommentList=reviewCommentDao.getList(reviewCommentDto);
		// by남기, request 에 담아준다 _210303
		request.setAttribute("reviewCommentList", reviewCommentList);
		request.setAttribute("totalPageCount", totalPageCount);		
	}
	
	@Autowired
	private UsersDao usersdao;
	
	//by욱현. 내가쓴리뷰 모아보기 비즈니스로직(내부 코드는 남기꺼 복붙)_2021309
	@Override
	public List<ReviewDto> getMyReview(HttpSession session, ModelAndView mView, HttpServletRequest request) {
		
		String id = (String) session.getAttribute("id");
		UsersDto usersDto = usersdao.getData(id);
		mView.addObject("dto", usersDto);
		
		
		// by남기, 한 페이지에 몇개씩 표시할 것인지_210303
		final int PAGE_ROW_COUNT=4;
		// by남기, 하단 페이지를 몇개씩 표시할 것인지_210303
		final int PAGE_DISPLAY_COUNT=5;
				
		// by남기, 보여줄 페이지의 번호를 일단 1이라고 초기값 지정_210303
		int pageNum=1;
		// by남기, 페이지 번호가 파라미터로 전달되는지 읽어와 본다_210303
		String strPageNum=request.getParameter("pageNum");
		// by남기, 만일 페이지 번호가 파라미터로 넘어 온다면_210303
		if(strPageNum != null){
			// by남기, 숫자로 바꿔서 보여줄 페이지 번호로 지정한다_210303
			pageNum=Integer.parseInt(strPageNum);
		}				
				
		// by남기, 보여줄 페이지의 시작 ROWNUM_210303
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		// by남기, 보여줄 페이지의 끝 ROWNUM_210303
		int endRowNum=pageNum*PAGE_ROW_COUNT;
				
		
		// by남기, startRowNum 과 endRowNum  을 ReviewDto 객체에 담는다 _210303
		ReviewDto dto=new ReviewDto();
		dto.setWriter((String)session.getAttribute("id"));
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
				
		// by남기, ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다 _210303
		List<ReviewDto> list=null;
		// by남기, 전체 row 의 갯수를 담을 지역변수를 미리 만든다 _210303
		int totalRow=0;
		// by남기, 글목록 얻어오기_210303
		list=reviewDao.getList(dto);
		// by남기, 글의 갯수_210303
		totalRow=reviewDao.getCount(dto);
				
		// by남기, 하단 시작 페이지 번호_210303 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		// by남기, 하단 끝 페이지 번호_210303
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
				
		// by남기, 전체 페이지의 갯수 구하기_210303
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		// by남기, 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다_210303
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; // by남기, 만약 끝 번호가 전체보다 크다면 보정해준다_210303
		}	
				
		// by남기, view page 에서 필요한 내용을 ModelAndView 객체에 담아준다_210303
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("totalRow", totalRow);
				
		return list;
		
	}
}

