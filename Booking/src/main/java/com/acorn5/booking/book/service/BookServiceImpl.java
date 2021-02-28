<<<<<<< HEAD
package com.acorn5.booking.book.service;

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

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.acorn5.booking.book.dto.BookDto;


@Service
public class BookServiceImpl implements BookService{

	//의존 객체 DI
	
	//by 준익, 페이징 처리된 카테고리별 검색 리스트_2021.02.28
	@Override
	public List<BookDto> pagingCategory(String d_cont, int display, int start, String d_catg, HttpServletRequest request,
			ModelAndView mav) {
		//필드 
		String clientID = "hqIK81ATna87kVfkpjD9"; //by 준익, 네이버 도서 검색 api Client ID_2021.02.28
		String clientSecret = "pXqyhElpGp"; //by 준익, 네이버 도서 검색 api Client Secret_2021.02.28

		List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book_adv.xml?d_cont=" //by 준익, 상세검색을 받기 위한 book_adv.xml 작성_2021.02.28 
                    + URLEncoder.encode(d_cont, "UTF-8") //by 준익, 전체 검색을 하기 위한 목차 "1" 받기_2021.02.28
                    + (d_catg !=null ? "&d_catg=" +d_catg :"") //by 준익, 카테고리 검색 코드 받기_2021.02.28
                    + (display !=0 ? "&display=" +display :"") //by 준익, 화면에 표시할 개수_2021.02.28
                    + (start !=0 ? "&start=" +start :"")); //by 준익, 화면 시작값_2021.02.28
 
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(b);
                        b = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new BookDto();
                        break;
                    case "title":
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
            // < 페이징 처리 > -----------------------------------------------------
            //한 페이지에 몇개씩 표시할 것인지
    		final int PAGE_ROW_COUNT=display; //by 준익, 한 페이지에 표시할 개수 display 넣어줌_2021.02.28
    		//하단 페이지를 몇개씩 표시할 것인지
    		final int PAGE_DISPLAY_COUNT=5;
    		
    		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
    		int pageNum=1;
    		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
    		String strPageNum=request.getParameter("pageNum");
    		
    		//만일 페이지 번호가 파라미터로 넘어 온다면
    		if(strPageNum != null){
    			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
    			pageNum=Integer.parseInt(strPageNum);
    		}
    		
    		//보여줄 페이지의 시작 ROWNUM
    		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
    		//보여줄 페이지의 끝 ROWNUM
    		int endRowNum=pageNum*PAGE_ROW_COUNT;
    		
    		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
    		int totalRow=1000; //by 준익, 네이버 api start 최대값이 1000_2021.02.28
    		
    		
    		//하단 시작 페이지 번호 
    		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
    		//하단 끝 페이지 번호
    		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
    		
    		//전체 페이지의 갯수 구하기
    		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
    		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
    		if(endPageNum > totalPageCount){
    			endPageNum=totalPageCount; //보정해 준다. 
    		}
    		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
    		mav.addObject("list",list);
    		mav.addObject("d_catg",d_catg);
    		mav.addObject("start",start);
    		mav.addObject("display",display);
    		mav.addObject("PAGE_DISPLAY_COUNT",PAGE_DISPLAY_COUNT);
    		mav.addObject("pageNum",pageNum);
    		mav.addObject("startPageNum",startPageNum);
    		mav.addObject("endPageNum",endPageNum);
    		mav.addObject("totalPageCount",totalPageCount);
    		mav.addObject("PAGE_ROW_COUNT",PAGE_ROW_COUNT);
            
            
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list; //by 준익, 정보를 담은 list return_2021.02.28
	}
	

}
=======
package com.acorn5.booking.book.service;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.acorn5.booking.book.dto.BookDto;

@Service
public class BookServiceImpl implements BookService {
	//의존 객체 DI
	
	//by 준익, 페이징 처리된 카테고리별 검색 리스트 
	@Override
	public List<BookDto> pagingCategory(String d_isbn, int display, int start, String d_catg, HttpServletRequest request,
			ModelAndView mav) {
		//필드 
		String clientID = "hqIK81ATna87kVfkpjD9"; //by 준익, 네이버 도서 검색 api Client ID
		String clientSecret = "pXqyhElpGp"; //by 준익, 네이버 도서 검색 api Client Secret

		List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book_adv.xml?d_cont="
                    + URLEncoder.encode(d_isbn, "UTF-8")
                    + (d_catg !=null ? "&d_catg=" +d_catg :"")
                    + (display !=0 ? "&display=" +display :"")
                    + (start !=0 ? "&start=" +start :""));
 
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(b);
                        b = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new BookDto();
                        break;
                    case "title":
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
            // < 페이징 처리 > -----------------------------------------------------
            //한 페이지에 몇개씩 표시할 것인지
    		final int PAGE_ROW_COUNT=display;
    		//하단 페이지를 몇개씩 표시할 것인지
    		final int PAGE_DISPLAY_COUNT=5;
    		
    		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
    		int pageNum=1;
    		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
    		String strPageNum=request.getParameter("pageNum");
    		
    		//만일 페이지 번호가 파라미터로 넘어 온다면
    		if(strPageNum != null){
    			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
    			pageNum=Integer.parseInt(strPageNum);
    		}
    		
    		//보여줄 페이지의 시작 ROWNUM
    		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
    		//보여줄 페이지의 끝 ROWNUM
    		int endRowNum=pageNum*PAGE_ROW_COUNT;
    		
    		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
    		int totalRow=1000;
    		
    		
    		//하단 시작 페이지 번호 
    		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
    		//하단 끝 페이지 번호
    		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
    		
    		//전체 페이지의 갯수 구하기
    		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
    		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
    		if(endPageNum > totalPageCount){
    			endPageNum=totalPageCount; //보정해 준다. 
    		}
    		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
    		mav.addObject("list",list);
    		mav.addObject("start",start);
    		mav.addObject("startPageNum",startPageNum);
    		mav.addObject("endPageNum",endPageNum);
    		mav.addObject("totalPageCount",totalPageCount);
    		mav.addObject("display",display);
    		mav.addObject("pageNum",pageNum);
    		mav.addObject("PAGE_DISPLAY_COUNT",PAGE_DISPLAY_COUNT);
            
            
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
	}

	@Override
	public List<BookDto> bestSeller(String d_cont, int display, int start, String sort) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
	    String clientSecret = "zSBrAXrY3q";
	   
	    
        List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book_adv.xml?d_cont="
                    + URLEncoder.encode(d_cont, "UTF-8")
                    + (sort !=null ? "&sort=" +sort :"")
                    + (display !=0 ? "&display=" +display :"")
                    + (start !=0 ? "&start=" +start :""));

 
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            //Test에서 했던 방식은 DOM방식이기때문에? 
            //그래서 이렇게 해도 된다?!??!??!? 
           
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(b);
                        b = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new BookDto();
                        break;
                    case "title":
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
        
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
	    
	}

	@Override
	public List<BookDto> bookDetail(String d_isbn, int display) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
	    String clientSecret = "zSBrAXrY3q";
	  
        List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book_adv.xml?d_isbn="
                    + URLEncoder.encode(d_isbn, "UTF-8")
                    + (display !=0 ? "&display=" +display :""));
    
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            //Test에서 했던 방식은 DOM방식이기때문에? 
            //그래서 이렇게 해도 된다?!??!??!? 
       
            
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(b);
                        b = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new BookDto();
                        break;
                    case "title":
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
      
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
	    
	}

	@Override
	public List<BookDto> detailAjax(String d_auth, int display, String sort) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
	    String clientSecret = "zSBrAXrY3q";
	   
        List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book_adv.xml?d_auth="
                    + URLEncoder.encode(d_auth, "UTF-8")
                    + (sort !=null ? "&sort=" +sort :"")
                    + (display !=0 ? "&display=" +display :""));
                    

 
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            //Test에서 했던 방식은 DOM방식이기때문에? 
            //그래서 이렇게 해도 된다?!??!??!? 
            
            
            
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(b);
                        b = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new BookDto();
                        break;
                    case "title":
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
       
            
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
	}
	//여기서부터 남기(내가 테스트로함)
	@Override
	public List<BookDto> searchBook(String keyword, int display, int start) {
		String clientID = "RFTx71xgYkvn9AtCl3sH";
	    String clientSecret = "5i1UxM9vSW";
	 
        List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book.xml?query="
                    + URLEncoder.encode(keyword, "UTF-8")
                    + (display !=0 ? "&display=" +display :"")
                    + (start !=0 ? "&start=" +start :""));
 
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(b);
                        b = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new BookDto();
                        break;
                    case "title":
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
            
            
            
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
	}

	@Override
	public List<BookDto> bookReview(String d_isbn, int display) {
		String clientID = "RFTx71xgYkvn9AtCl3sH";
	    String clientSecret = "5i1UxM9vSW";
	 
    	List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book_adv.xml?d_isbn="
                    + URLEncoder.encode(d_isbn, "UTF-8")
                    + (display !=0 ? "&display=" +display :""));
 
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(b);
                        b = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        b = new BookDto();
                        break;
                    case "title":
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
   
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
    }

	@Override
	public List<BookDto> recommendBook(String d_cont, int display, int start, String sort, ModelAndView mView) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
		String clientSecret = "zSBrAXrY3q";
		   
        List<BookDto> list = null; //책데이터를 담을 List배열 선언
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "Book_adv.xml?d_cont="
                    + URLEncoder.encode(d_cont, "UTF-8") //d_cont는 지정변수가 아니여서 인코딩을 해준다.
                    + (sort !=null ? "&sort=" +sort :"") 
                    + (display !=0 ? "&display=" +display :"")
                    + (start !=0 ? "&start=" +start :""));
  

 
            URLConnection urlConn = url.openConnection(); //요청할 url을 URLConnection 객체에 담는다.
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID); //아이디, 비번인증
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance(); //출력결과를 xml로 파싱하기 위한 객체 생성
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
            //Test에서 했던 방식은 DOM방식이기때문에? 
            //그래서 이렇게 해도 된다?!??!??!? 
           
            
            int eventType = parser.getEventType(); //받은 xml을 읽다가 이벤트에서 특정 상수를 반환 
            //하여 eventType에 저장 
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) { //문서의 끝이 아니라면 계속 반복
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝 
                    break;
                case XmlPullParser.START_DOCUMENT: // 문서의 시작
                    list = new ArrayList<BookDto>(); // 이면, BookDto모델 타입의 리스트배열 생성
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item")) //태그의 끝 </> 인데 이게 </item> 이면
                    {
                        list.add(b); // BookDto타입 객체 b를 List배열에 추가한다.
                        b = null; 
                    }
                }
                case XmlPullParser.START_TAG: { // < > 태그시작이면
                    String tag = parser.getName(); // 시작인 태그의 이름을 얻어서
                    switch (tag) { 
                    case "item": //그 태그가 아이템이면 BookDto타입 객체를 새로 생성하고
                        b = new BookDto();
                        break;
                    case "title": //title이면  출력결과를 가지고 있는 parser에 nextText메소드를 호출시켜 읽어들인걸 모델에 저장
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link": //링크태그의 내용을 nextText()로 읽어서 모델에 저장
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
         
        } catch (Exception e) {
            e.printStackTrace();
        } 
        mView.addObject("list", list);
        
        return list;
    }
	

	@Override
	public List<BookDto> recommendBook(int display, int start, String sort, String query, ModelAndView mView) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
		String clientSecret = "zSBrAXrY3q";
		
        List<BookDto> list = null; 
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/" 
                    + "Book.xml?query="
                    + URLEncoder.encode(query, "UTF-8")
                    + (sort !=null ? "&sort=" +sort :"") 
                    + (display !=0 ? "&display=" +display :"")
                    + (start !=0 ? "&start=" +start :""));
  

 
            URLConnection urlConn = url.openConnection(); 
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID); 
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
         
            
            int eventType = parser.getEventType();
            BookDto b = null;
            while (eventType != XmlPullParser.END_DOCUMENT) { 
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT:
                    break;
                case XmlPullParser.START_DOCUMENT: 
                    list = new ArrayList<BookDto>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item")) 
                    {
                        list.add(b);
                        b = null; 
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName(); 
                    switch (tag) { 
                    case "item": 
                        b = new BookDto();
                        break;
                    case "title": 
                        if(b != null)
                            b.setTitle(parser.nextText());
                        break;
                    case "link": 
                        if(b != null)
                            b.setLink(parser.nextText());
                        break;
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "author":
                        if(b != null)
                            b.setAuthor(parser.nextText());
                        break;
                    case "price":
                        if(b != null)
                            b.setPrice(parser.nextText());
                        break;
                    case "discount":
                        if(b != null)
                            b.setDiscount(parser.nextText());
                        break;
                    case "publisher":
                        if(b != null)
                            b.setPublisher(parser.nextText());
                        break;
                    case "pubdate":
                        if(b != null)
                            b.setPubdate(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                        break;
                    case "description":
                        if(b != null)
                            b.setDescription(parser.nextText());
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        } 
        mView.addObject("list", list);
        
        return list;
    }
	

	@Override
	public Map<String, Object> recommendBook(String d_cont, int display, int start) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
		String clientSecret = "zSBrAXrY3q";
		
		Map<String, Object> data = null;
        String image = null;
        String isbn = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "Book_adv.xml?d_cont="
                    + URLEncoder.encode(d_cont, "UTF-8") //d_cont는 지정변수가 아니여서 인코딩을 해준다.
                    + (display !=0 ? "&display=" +display :"")
                    + (start !=0 ? "&start=" +start :""));
  

 
            URLConnection urlConn = url.openConnection(); 
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID); 
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            parser.setInput(
                    new InputStreamReader(urlConn.getInputStream()));
         
           
            int eventType = parser.getEventType();
            while (eventType != XmlPullParser.END_DOCUMENT) { 
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT:
                    break;
                case XmlPullParser.START_DOCUMENT: //문서의 시작이면 해쉬맵객체 생성
                    data = new HashMap<String, Object>();
                    break;
                case XmlPullParser.END_TAG: {
                    break;
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName(); // < > 이면 태그이름을 얻음
                    switch (tag) { 
                    case "image": //태그이름이 image이면
                        image = parser.nextText(); //String 값을 저장
                        break;
                    case "isbn": //태그이름이 isbn이면 
                        isbn = parser.nextText(); //값을 String 으로 저장
                  
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        } 
        data.put("image", image);
        data.put("isbn", isbn);  //해쉬맵객체에 put해주고
         
        return data; //해쉬맵객체를 리턴
    }
	
}
>>>>>>> aaabdbfa4d7c429e094458570e48308b633467ae
