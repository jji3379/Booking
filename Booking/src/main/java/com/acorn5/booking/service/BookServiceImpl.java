package com.acorn5.booking.service;

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

import com.acorn5.booking.book.BookDto;


@Service
public class BookServiceImpl implements BookService{

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
	

}
