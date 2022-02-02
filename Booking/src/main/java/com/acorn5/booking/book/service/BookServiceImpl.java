package com.acorn5.booking.book.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.book.parsing.XmlParsing;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.repository.ReviewRepository;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.SearchRepository;
import com.acorn5.booking.users.repository.UsersRepository;

@Service
public class BookServiceImpl implements BookService {
	
	@PersistenceContext
	EntityManager em;
	
	@Autowired
	private UsersRepository usersRepository;

	@Autowired
	private ReviewRepository reviewRepository;

	@Autowired
	private SearchRepository searchRepository;  
	
	//by 준익, 페이징 처리된 카테고리별 검색 리스트_2021.02.28
	@Override
	public List<BookDto> pagingCategory(String d_cont, int display, int start, String d_catg, HttpServletRequest request,
			ModelAndView mView, String sort) {
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
                    + (start !=0 ? "&start=" +start :"")
                    + (sort !=null ? "&sort=" +sort :"")); //by 준익, 화면 시작값_2021.02.28
 
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
    		mView.addObject("list",list);
    		mView.addObject("d_catg",d_catg);
    		mView.addObject("sort",sort);
    		mView.addObject("start",start);
    		mView.addObject("display",display);
    		mView.addObject("PAGE_DISPLAY_COUNT",PAGE_DISPLAY_COUNT);
    		mView.addObject("pageNum",pageNum);
    		mView.addObject("startPageNum",startPageNum);
    		mView.addObject("endPageNum",endPageNum);
    		mView.addObject("totalPageCount",totalPageCount);
    		mView.addObject("PAGE_ROW_COUNT",PAGE_ROW_COUNT);
            
            
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
            List<Review> reviewAllList = reviewRepository.findAll();
            List<String> reviewIsbnList = new ArrayList();
            for (int i = 0; i < reviewAllList.size(); i++) {
				reviewIsbnList.add(reviewAllList.get(i).getIsbn());
			}
           
            int eventType = parser.getEventType();
            BookDto b = null;
            String isbn = null;
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
                        	isbn = parser.nextText();
                            b.setIsbn(isbn);
                            
                            if(reviewIsbnList.contains(isbn)) {
                            	b.setReviewRating(reviewAllList.get(reviewIsbnList.indexOf(isbn)).getRatingAvg());
                            	b.setReviewCount((long) Collections.frequency(reviewIsbnList, isbn));
                            }
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
	//by준영, bookDetail.jsp 에 isbn 을 인자로 리스트(리스트지만 한권) 검색하는 서비스_210222
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
                    + (display != 0 ? "&display=" +display :""));
    
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
	//by준영, bookAjax.jsp 에 저자를 인자로 리스트 검색하는 서비스_210222
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
	//by 남기, 리뷰를 추가할 도서 검색 리스트_2021.03.03
	@Override
	public List<BookDto> searchBookList(String keyword, int display, int start, HttpServletRequest request, ModelAndView mView) {
		String clientId = "g77o0632rEdwZNPM9S2i"; // 애플리케이션 클라이언트 아이디값"
		String clientSecret = "ZbTjii_qWZ"; // 애플리케이션 클라이언트 시크릿값"

		String condition = request.getParameter("condition"); // by 준익, 조건 상태 얻어오기_2021.03.09
		start = Integer.parseInt(request.getParameter("start")); // by 준익, 페이징 적용을 위한 start 값 얻어오기_2021.03.09
		List<BookDto> list = null; // by 준익, XmlPullparser로 parsing 한 값 집어 넣을 list(item)_2021.03.09

		BufferedReader br = null; // by 준익, api 정보를 읽어올 BufferedReader 필드_2021.03.09
		XmlParsing par1 = new XmlParsing(); // by 준익, total 태그를 얻어오기 위해 새로 만든 클래스_2021.03.09
		String total = null; // by 준익, total 값을 담아서 넘겨주기 위한 필드_2021.03.09
		
		try {
			// total parsing start 
			URL url = null;
			// by 준익, 검색조건에 따른 url 값 적용_2021.03.09
			if (condition == null || condition.equals("title_content") || condition.equals("")) { // by 준익, 네비바에서 바로 검색한경우 이거나 제목+내용 검색인 경우_2021.03.09
				url = new URL("https://openapi.naver.com/v1/search/" + "book.xml?query=" // by 준익, 일반검색 query keyword 사용_2021.03.09
						+ URLEncoder.encode(keyword, "UTF-8") 
						+ ("&display=" + display) 
						+ ("&start=" + start));
			} else if (condition.equals("title")) { // by 준익, 검색 조건을 제목으로 한 경우_2021.03.09
				url = new URL("https://openapi.naver.com/v1/search/" + "book_adv.xml?d_titl=" // by 준익, 상세검색 d_titlk eyword 사용_2021.03.09
						+ URLEncoder.encode(keyword, "UTF-8") 
						+ ("&display=" + display) 
						+ ("&start=" + start));
			} else if (condition.equals("writer")) { // by 준익, 검색 조겅르 저자로 한 경우_2021.03.09
				url = new URL("https://openapi.naver.com/v1/search/" + "book_adv.xml?d_auth=" // by 준익, 상세 검색 d_auth keyword 사용_2021.03.09
						+ URLEncoder.encode(keyword, "UTF-8") 
						+ ("&display=" + display) 
						+ ("&start=" + start));
			}

			// by 준익, parsing에 필요한 responseCode 를 사용하기 위한 접근 제어_2021.03.09
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();

			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			// 응답 읽기
			String result = "";
			String line;
			while ((line = br.readLine()) != null) {
				result = result + line.trim();// by 준익, result = URL로 XML을 읽은 값_2021.03.09
			}

			// by 준익, xml 파싱하기 위해 result 값 가져오기_2021.03.09
			InputSource is = new InputSource(new StringReader(result));
			// by 준익, url 요소를 읽어 들일 Document 객체 생성
			// (http만 가능해서 https를 사용하려면 인증키를 얻어 xml로 결과를 뽑아낸 것을 얻어와야 한다 )_2021.03.09
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(is); //by 준익, url 에서 읽어온 xml 값 넣기_2021.03.09

			// by 준익, 파싱할 tag 입력(total은 channel tag 안에 존재)
			NodeList nList = doc.getElementsByTagName("channel");

			// by 준익, 불러온 xml 값 파싱_2021.03.09
			for (int temp = 0; temp < nList.getLength(); temp++) {
				Node nNode = nList.item(temp);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					total = par1.getTagValue("total", eElement); //by 준익, total 에 파싱해서 얻은 total 값을 담는다_2021.03.09
				} // if end
			} // for end
			// total parsing End 

			// item parsing Start 
			URLConnection urlConn = url.openConnection();
			urlConn.setRequestProperty("X-Naver-Client-Id", clientId);
			urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));

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
					if (tag.equals("item")) {
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
						if (b != null)
							b.setTitle(parser.nextText());
						break;
					case "link":
						if (b != null)
							b.setLink(parser.nextText());
						break;
					case "image":
						if (b != null)
							b.setImage(parser.nextText());
						break;
					case "author":
						if (b != null)
							b.setAuthor(parser.nextText());
						break;
					case "price":
						if (b != null)
							b.setPrice(parser.nextText());
						break;
					case "discount":
						if (b != null)
							b.setDiscount(parser.nextText());
						break;
					case "publisher":
						if (b != null)
							b.setPublisher(parser.nextText());
						break;
					case "pubdate":
						if (b != null)
							b.setPubdate(parser.nextText());
						break;
					case "isbn":
						if (b != null)
							b.setIsbn(parser.nextText());
						break;
					case "description":
						if (b != null)
							b.setDescription(parser.nextText());
						break;
					}
				}
				}
				eventType = parser.next();

			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		// item parsing End 
		
		// by 준익, 페이징 처리에 사용할 인코딩한 키워드_2021.03.09
		String encodedK = null;
		try {
			encodedK = URLEncoder.encode(keyword, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		keyword = request.getParameter("keyword");
		// 만일 키워드가 넘어오지 않는다면
		if (keyword == null) {
			// 키워드와 검색 조건에 빈 문자열을 넣어준다.
			// 클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서
			keyword = "";
		}

		// < 페이징 처리 > -----------------------------------------------------
		// 한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT = display; // by 준익, 한 페이지에 표시할 개수 display 넣어줌_2021.02.28
		// 하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT = 5;

		// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum = 1;
		// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum = request.getParameter("pageNum");

		// 만일 페이지 번호가 파라미터로 넘어 온다면
		if (strPageNum != null) {
			// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum = Integer.parseInt(strPageNum);
		}

		// 보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		// 하단 시작 페이지 번호
		int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		// 하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;

		// 전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow = 0; // by 준익, totalRow 를 담을 변수 선언_2021.03.09

		if (Integer.parseInt(total) >= 1000) { // by 준익, 검색 개수가 1000이 넘을 경우_2021.03.09
			totalRow = 1000; // by 준익, 네이버 도서 api start 값이 최대 1000 이므로 totalRow=1000 으로 고정_2021.03.09  
		} else { // by 준익, total 이 1000을 넘지 않는경우_2021.03.09  
			totalRow = Integer.parseInt(total); // by 준익, 검색 개수에 대한 페이징 처리를 위해 totalRow=검색 개수로 지정_2021.03.09 
		}

		// 전체 페이지의 갯수 구하기
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
		// 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount; // 보정해 준다.
		}
		// view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);
		mView.addObject("total", total);
		mView.addObject("start", start);
		mView.addObject("display", display);
		mView.addObject("PAGE_DISPLAY_COUNT", PAGE_DISPLAY_COUNT);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("PAGE_ROW_COUNT", PAGE_ROW_COUNT);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);
		mView.addObject("condition", condition); // 검색 조건이 있을 경우
		mView.addObject("keyword", keyword); // 검색 조건이 있을 경우

		return list;
		
	}
	//by 남기, 리뷰를 추가할 도서 정보 d_isbn 값으로 가져오기_2021.03.03
	@Override
	public List<BookDto> bookReview(String d_isbn, int display) {
		String clientID = "RFTx71xgYkvn9AtCl3sH"; //by 남기, 네이버 도서 검색 api Client ID_2021.03.03
	    String clientSecret = "5i1UxM9vSW"; //by 남기, 네이버 도서 검색 api Client Secret_2021.02.03
	 
    	List<BookDto> list = null;
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "book_adv.xml?d_isbn=" //by 남기, 도서 상세 검색을 담당하는 book_adv.xml 작성_2021.03.03
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
	public List<BookDto> careRecommendBook(String d_catg, int display, int start, String sort, ModelAndView mView) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
		String clientSecret = "zSBrAXrY3q";
		   
        List<BookDto> list = null; //책데이터를 담을 List배열 선언
        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
            		+ "book_adv.xml?d_cont="  
                    + URLEncoder.encode("1", "UTF-8") 
                    + (d_catg !=null ? "&d_catg=" +d_catg :"")
                    + (sort !=null ? "&sort=" + sort : "")
					+ (display != 0 ? "&display=" + display : "") 
					+ (start != 0 ? "&start=" + start : ""));

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
        //mView.addObject("list", list);
        
        return list;
    }
	

	@Override
	public List<BookDto> searchRecommendBook(int display, int start, String sort, String query, ModelAndView mView) {
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
        //mView.addObject("list", list);
        
        return list;
    }
	

	@Override
	public List<BookDto> bookingRecommendBook(String d_catg, int display, int start, String sort, ModelAndView mView) {
		String clientID = "Wp0rct7jHFnQmQ6dv44f";
		String clientSecret = "zSBrAXrY3q";
		
		List<BookDto> list = null;

        try {
            URL url;
            url = new URL("https://openapi.naver.com/v1/search/"
            		+ "book_adv.xml?d_cont="  
                    + URLEncoder.encode("1", "UTF-8") 
                    + (d_catg !=null ? "&d_catg=" +d_catg :"")
                    + (sort !=null ? "&sort=" + sort : "")
					+ (display != 0 ? "&display=" + display : "") 
					+ (start != 0 ? "&start=" + start : ""));
  

 
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
                    case "image":
                        if(b != null)
                            b.setImage(parser.nextText());
                        break;
                    case "isbn":
                        if(b != null)
                            b.setIsbn(parser.nextText());
                            
                        break;
                    }
                    
                }
                }
                eventType = parser.next();
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        } 

        return list; //해쉬맵객체를 리턴
    }
	
	@Override
	public Page<BookDto> conditionSearch(String keyword, int display, Pageable pageable){
		String clientId = "g77o0632rEdwZNPM9S2i"; // 애플리케이션 클라이언트 아이디값"
		String clientSecret = "ZbTjii_qWZ"; // 애플리케이션 클라이언트 시크릿값"

		//String condition = request.getParameter("condition"); // by 준익, 조건 상태 얻어오기_2021.03.09
		//start = Integer.parseInt(request.getParameter("start")); // by 준익, 페이징 적용을 위한 start 값 얻어오기_2021.03.09
		List<BookDto> list = null; // by 준익, XmlPullparser로 parsing 한 값 집어 넣을 list(item)_2021.03.09

		BufferedReader br = null; // by 준익, api 정보를 읽어올 BufferedReader 필드_2021.03.09
		XmlParsing par1 = new XmlParsing(); // by 준익, total 태그를 얻어오기 위해 새로 만든 클래스_2021.03.09
		String total = null; // by 준익, total 값을 담아서 넘겨주기 위한 필드_2021.03.09
		
		List<Review> reviewAllList = reviewRepository.findAll();
        List<String> reviewIsbnList = new ArrayList();
        for (int i = 0; i < reviewAllList.size(); i++) {
			reviewIsbnList.add(reviewAllList.get(i).getIsbn());
		}
		
		try {
			// total parsing start 
			URL url = null;
			String sort = "";
			if(pageable.getSort().toString().contains("sim")) {
				sort = "sim";
			} else if(pageable.getSort().toString().contains("count")) {
				sort = "count";
			} else if(pageable.getSort().toString().contains("date")) {
				sort = "date";
			}
			// by 준익, 검색조건에 따른 url 값 적용_2021.03.09
				url = new URL("https://openapi.naver.com/v1/search/" + "book.xml?query=" // by 준익, 일반검색 query keyword 사용_2021.03.09
						+ URLEncoder.encode(keyword, "UTF-8") 
						+ ("&display=" + display) 
						+ ("&start=" + (pageable.getPageNumber()*display+Integer.valueOf(1)))
						+ ("&sort=" + sort));
			// by 준익, parsing에 필요한 responseCode 를 사용하기 위한 접근 제어_2021.03.09
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();

			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			// 응답 읽기
			String result = "";
			String line;
			while ((line = br.readLine()) != null) {
				result = result + line.trim();// by 준익, result = URL로 XML을 읽은 값_2021.03.09
			}

			// by 준익, xml 파싱하기 위해 result 값 가져오기_2021.03.09
			InputSource is = new InputSource(new StringReader(result));
			// by 준익, url 요소를 읽어 들일 Document 객체 생성
			// (http만 가능해서 https를 사용하려면 인증키를 얻어 xml로 결과를 뽑아낸 것을 얻어와야 한다 )_2021.03.09
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(is); //by 준익, url 에서 읽어온 xml 값 넣기_2021.03.09

			// by 준익, 파싱할 tag 입력(total은 channel tag 안에 존재)
			NodeList nList = doc.getElementsByTagName("channel");

			// by 준익, 불러온 xml 값 파싱_2021.03.09
			for (int temp = 0; temp < nList.getLength(); temp++) {
				Node nNode = nList.item(temp);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					total = par1.getTagValue("total", eElement); //by 준익, total 에 파싱해서 얻은 total 값을 담는다_2021.03.09
				} // if end
			} // for end
			// total parsing End 

			// item parsing Start 
			URLConnection urlConn = url.openConnection();
			urlConn.setRequestProperty("X-Naver-Client-Id", clientId);
			urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));

			int eventType = parser.getEventType();
			BookDto b = null;
			String isbn = "";
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT: // 문서의 끝
					break;
				case XmlPullParser.START_DOCUMENT:
					list = new ArrayList<BookDto>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
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
						if (b != null)
							b.setTitle(parser.nextText());
						break;
					case "link":
						if (b != null)
							b.setLink(parser.nextText());
						break;
					case "image":
						if (b != null)
							b.setImage(parser.nextText());
						break;
					case "author":
						if (b != null)
							b.setAuthor(parser.nextText());
						break;
					case "price":
						if (b != null)
							b.setPrice(parser.nextText());
						break;
					case "discount":
						if (b != null)
							b.setDiscount(parser.nextText());
						break;
					case "publisher":
						if (b != null)
							b.setPublisher(parser.nextText());
						break;
					case "pubdate":
						if (b != null)
							b.setPubdate(parser.nextText());
						break;
					case "isbn":
						if (b != null)
	                    	isbn = parser.nextText();
	                        b.setIsbn(isbn);
	                        
                        if(reviewIsbnList.contains(isbn)) {
                        	b.setReviewRating(reviewAllList.get(reviewIsbnList.indexOf(isbn)).getRatingAvg());
                        	b.setReviewCount((long) Collections.frequency(reviewIsbnList, isbn));
                        }
						break;
					case "description":
						if (b != null)
							b.setDescription(parser.nextText());
						break;
					}
				}
				}
				eventType = parser.next();

			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		// item parsing End 
		
		// by 준익, 페이징 처리에 사용할 인코딩한 키워드_2021.03.09
		String encodedK = null;
		try {
			encodedK = URLEncoder.encode(keyword, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//keyword = request.getParameter("keyword");
		// 만일 키워드가 넘어오지 않는다면
		if (keyword == null) {
			// 키워드와 검색 조건에 빈 문자열을 넣어준다.
			// 클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서
			keyword = "";
		}

		// < 페이징 처리 > -----------------------------------------------------
/*
		// 한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT = display; // by 준익, 한 페이지에 표시할 개수 display 넣어줌_2021.02.28
		// 하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT = 5;

		// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum = 1;
		// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum = request.getParameter("pageNum");

		// 만일 페이지 번호가 파라미터로 넘어 온다면
		if (strPageNum != null) {
			// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum = Integer.parseInt(strPageNum);
		}

		// 보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		// 하단 시작 페이지 번호
		int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		// 하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;

		// 전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow = 0; // by 준익, totalRow 를 담을 변수 선언_2021.03.09

		if (Integer.parseInt(total) >= 1000) { // by 준익, 검색 개수가 1000이 넘을 경우_2021.03.09
			totalRow = 1000; // by 준익, 네이버 도서 api start 값이 최대 1000 이므로 totalRow=1000 으로 고정_2021.03.09  
		} else { // by 준익, total 이 1000을 넘지 않는경우_2021.03.09  
			totalRow = Integer.parseInt(total); // by 준익, 검색 개수에 대한 페이징 처리를 위해 totalRow=검색 개수로 지정_2021.03.09 
		}

		// 전체 페이지의 갯수 구하기
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
		// 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount; // 보정해 준다.
		}
		*/
		// view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		/*
		mView.addObject("list", list);
		mView.addObject("total", total);
		mView.addObject("start", start);
		mView.addObject("display", display);
		mView.addObject("PAGE_DISPLAY_COUNT", PAGE_DISPLAY_COUNT);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("PAGE_ROW_COUNT", PAGE_ROW_COUNT);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);
		mView.addObject("condition", condition); // 검색 조건이 있을 경우
		mView.addObject("keyword", keyword); // 검색 조건이 있을 경우
*/
		
		return new PageImpl<BookDto>(list, pageable, Integer.parseInt(total));
	}

	@Override
	public void recentSearchInput(String keyword, Long id) {
		Users userId = new Users();
		userId.setId(id);
		//Users dto = usersRepository.findById(id);
		Search recentSearch = new Search();
		recentSearch.setKeyword(keyword);
		recentSearch.setUserId(userId);
		searchRepository.save(recentSearch);
	}
}