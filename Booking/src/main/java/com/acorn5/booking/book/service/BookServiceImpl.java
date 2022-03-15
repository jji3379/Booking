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

@Service
public class BookServiceImpl implements BookService {
	
	@PersistenceContext
	EntityManager em;

	@Autowired
	private ReviewRepository reviewRepository;

	@Autowired
	private SearchRepository searchRepository;  
	
	@Override
	public List<BookDto> pagingCategory(String d_cont, int display, int start, String d_catg, HttpServletRequest request,
			ModelAndView mView, String sort) {
		
		String clientID = "hqIK81ATna87kVfkpjD9"; 
		String clientSecret = "pXqyhElpGp"; 

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
            
    		final int PAGE_ROW_COUNT=display; 
    		final int PAGE_DISPLAY_COUNT=5;
    		
    		int pageNum=1;
    		String strPageNum=request.getParameter("pageNum");
    		
			if (strPageNum != null) {
				pageNum = Integer.parseInt(strPageNum);
			}
    		
    		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
    		int endRowNum=pageNum*PAGE_ROW_COUNT;
    		
    		int totalRow=1000; //by 준익, 네이버 api start 최대값이 1000_2021.02.28
    		
    		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
    		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
    		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
    		
			if (endPageNum > totalPageCount) {
				endPageNum = totalPageCount;
			}
    		
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
	public List<BookDto> searchBookList(String keyword, int display, int start, HttpServletRequest request, ModelAndView mView) {
		String clientId = "g77o0632rEdwZNPM9S2i"; 
		String clientSecret = "ZbTjii_qWZ"; 

		String condition = request.getParameter("condition"); 
		start = Integer.parseInt(request.getParameter("start")); 
		List<BookDto> list = null; 

		BufferedReader br = null; 
		XmlParsing par1 = new XmlParsing(); 
		String total = null; 
		
		try {
			// total parsing start 
			URL url = null;
			if (condition == null || condition.equals("title_content") || condition.equals("")) { 
				url = new URL("https://openapi.naver.com/v1/search/" + "book.xml?query=" 
						+ URLEncoder.encode(keyword, "UTF-8") 
						+ ("&display=" + display) 
						+ ("&start=" + start));
			} else if (condition.equals("title")) { 
				url = new URL("https://openapi.naver.com/v1/search/" + "book_adv.xml?d_titl=" 
						+ URLEncoder.encode(keyword, "UTF-8") 
						+ ("&display=" + display) 
						+ ("&start=" + start));
			} else if (condition.equals("writer")) { 
				url = new URL("https://openapi.naver.com/v1/search/" + "book_adv.xml?d_auth=" 
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

			if (responseCode == 200) { 
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { 
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String result = "";
			String line;
			while ((line = br.readLine()) != null) {
				result = result + line.trim();
			}

			InputSource is = new InputSource(new StringReader(result));

			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(is); 

			NodeList nList = doc.getElementsByTagName("channel");

			for (int temp = 0; temp < nList.getLength(); temp++) {
				Node nNode = nList.item(temp);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					total = par1.getTagValue("total", eElement); 
				} 
			} 

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
				case XmlPullParser.END_DOCUMENT: 
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

		String encodedK = null;
		try {
			encodedK = URLEncoder.encode(keyword, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		keyword = request.getParameter("keyword");

		if (keyword == null) {
			keyword = "";
		}


		final int PAGE_ROW_COUNT = display; 
		final int PAGE_DISPLAY_COUNT = 5;

		int pageNum = 1;
		String strPageNum = request.getParameter("pageNum");

		if (strPageNum != null) {
			pageNum = Integer.parseInt(strPageNum);
		}

		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;

		int totalRow = 0; 

		if (Integer.parseInt(total) >= 1000) { 
			totalRow = 1000;   
		} else {   
			totalRow = Integer.parseInt(total);  
		}

		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount; 
		}
		
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
		mView.addObject("condition", condition); 
		mView.addObject("keyword", keyword); 

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
            //하여 eventType에 저장 
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

        return list; 
    }
	
	@Override
	public Page<BookDto> conditionSearch(String keyword, int display, Pageable pageable){
		String clientId = "g77o0632rEdwZNPM9S2i"; 
		String clientSecret = "ZbTjii_qWZ"; 

		List<BookDto> list = null; 

		BufferedReader br = null; 
		XmlParsing par1 = new XmlParsing(); 
		String total = null; 
		
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
				url = new URL("https://openapi.naver.com/v1/search/" + "book.xml?query=" 
						+ URLEncoder.encode(keyword, "UTF-8") 
						+ ("&display=" + display) 
						+ ("&start=" + (pageable.getPageNumber()*display+Integer.valueOf(1)))
						+ ("&sort=" + sort));
				
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();

			if (responseCode == 200) { 
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { 
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String result = "";
			String line;
			while ((line = br.readLine()) != null) {
				result = result + line.trim();
			}

			InputSource is = new InputSource(new StringReader(result));
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(is); 

			NodeList nList = doc.getElementsByTagName("channel");

			for (int temp = 0; temp < nList.getLength(); temp++) {
				Node nNode = nList.item(temp);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					total = par1.getTagValue("total", eElement); 
				} 
			} 

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
				case XmlPullParser.END_DOCUMENT: 
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
		
		String encodedK = null;
		try {
			encodedK = URLEncoder.encode(keyword, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		if (keyword == null) {
			keyword = "";
		}
		
		return new PageImpl<BookDto>(list, pageable, Integer.parseInt(total));
	}

	@Override
	public void recentSearchInput(String keyword, Long id) {
		Users userId = new Users();
		userId.setId(id);
		
		Search recentSearch = new Search();
		recentSearch.setKeyword(keyword);
		recentSearch.setUserId(userId);
		
		searchRepository.save(recentSearch);
	}
}