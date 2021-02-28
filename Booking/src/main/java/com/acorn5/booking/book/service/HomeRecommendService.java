package com.acorn5.booking.book.service;

import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import com.acorn5.booking.book.dto.BookDto;

@Service
public class HomeRecommendService {
	 private static String clientID = "Wp0rct7jHFnQmQ6dv44f";
	  private static String clientSecret = "zSBrAXrY3q";
	   
	  	//by욱현. 네이버 api 요청 메소드_2021223
	    public List<BookDto> recommendBook(String d_cont,int display, int start,String sort, ModelAndView mView){
	    	d_cont = "1";
	    	display = 12;
	    	
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
	    
	    
	    //by욱현. 오버로딩된 recommendBookDto 메소드(로그인 되었을 시 사용)_2021224
	    public List<BookDto> recommendBook(int display, int start, String sort, String query, ModelAndView mView){
	    	display = 12;
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
	    
	  //by욱현. 부킹서비스를 위해 오버로딩된 recommendBookDto메소드_2021226
	    public Map<String, Object> recommendBook(String d_cont, int display, int start){
	    	display = 12;
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