<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
   div>.dropright:hover>.dropdown-menu {
      display: block;
      border-color:#0f4c81;
   }
   
   .dropdown-toggle {
      display: none;
   }
   
   .Main-Category {
      font-weight:bold;
      color: #0f4c81;
      width: 155px;
      font-size: 18px;
      text-align: left;
      margin-left: 15px;
      line-height :29px;
      margin-right: -10px;
   }
</style>
<div style="border: 2px solid #0f4c81; height: 740px;" class="col-2">
	<div class="btn-group dropright">
		<a  style="margin-top:10px;"  class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=100&start=1&sort=count">소설</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=100010&start=1&sort=count">나라별 소설 </a>
				<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=100020&start=1&sort=count">고전 / 문학</a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=100030&start=1&sort=count">장르소설</a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=100040&start=1&sort=count">테마소설</a>
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category" 
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110&start=1&sort=count">시 / 에세이</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110010&start=1&sort=count">한국시 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110020&start=1&sort=count">외국시 </a>
			 <a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110030&start=1&sort=count">인물 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110040&start=1&sort=count">여행 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110050&start=1&sort=count">성공 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110060&start=1&sort=count">독서 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110070&start=1&sort=count">명상 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110080&start=1&sort=count">그림 / 포토 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110090&start=1&sort=count">연애 / 사랑 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=110100&start=1&sort=count">삶의 지혜 / 명언 </a>
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120&start=1&sort=count">인문</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120010&start=1&sort=count">인문일반 </a>
				<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120020&start=1&sort=count">심리 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120030&start=1&sort=count">교육학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120040&start=1&sort=count">철학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120050&start=1&sort=count">문학론 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120060&start=1&sort=count">언어학 / 기호학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120070&start=1&sort=count">종교학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=120080&start=1&sort=count">신화 </a>
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=130&start=1&sort=count">가정/생활/요리</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=130010&start=1&sort=count">결혼 / 가족 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=130020&start=1&sort=count">임신 / 출산 / 육아 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=130030&start=1&sort=count">자녀교육 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=130040&start=1&sort=count">집 / 살림 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=130050&start=1&sort=count">요리  </a>
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=140&start=1&sort=count">건강</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=140010&start=1&sort=count">건강정보 / 에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=140020&start=1&sort=count">질병치료 / 예방 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=140030&start=1&sort=count">다이어트 / 미용 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=140040&start=1&sort=count">요가 / 헬스 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=140050&start=1&sort=count">건강운동 기타 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150&start=1&sort=count">취미/레저</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-105px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150010&start=1&sort=count">뜨개질 / 퀼트 / 십자수 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150020&start=1&sort=count">비즈 / 구슬공예 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150030&start=1&sort=count">선물포장 / 리본공예 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150040&start=1&sort=count">옷만들기 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150050&start=1&sort=count">꽃꽂이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150060&start=1&sort=count">퍼즐 / 스도쿠 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150070&start=1&sort=count">바둑 / 장기 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150080&start=1&sort=count">애완동물 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150090&start=1&sort=count">사진 / 비디오 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150100&start=1&sort=count">원예 / 조경 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150110&start=1&sort=count">가구 / DIY </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150120&start=1&sort=count">취미기타 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150130&start=1&sort=count">골프 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150140&start=1&sort=count">등산 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150150&start=1&sort=count">낚시 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150160&start=1&sort=count">달리기 / 마라톤 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=150170&start=1&sort=count">레저 / 스포츠기타 </a>
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=160&start=1&sort=count">경제/경영</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=160010&start=1&sort=count">경제 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=160020&start=1&sort=count">경영 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=160030&start=1&sort=count">마케팅 / 세일즈 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=160040&start=1&sort=count">재테크 / 투자 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=160050&start=1&sort=count">창업 / 취업 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=170&start=1&sort=count">자기계발</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=170010&start=1&sort=count">성공 / 처세 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=170020&start=1&sort=count">시간관리 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=170030&start=1&sort=count">자기능력계발 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=170040&start=1&sort=count">인간관계 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=170050&start=1&sort=count">대화 / 협상 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180&start=1&sort=count">사회</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180010&start=1&sort=count">정치 / 외교 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180020&start=1&sort=count">행정 / 정책 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180030&start=1&sort=count">국방 / 군사 / 경찰 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180040&start=1&sort=count">법 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180050&start=1&sort=count">사회학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180060&start=1&sort=count">사회복지 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=180070&start=1&sort=count">언론 / 신문 / 방송 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=190&start=1&sort=count">역사/문화</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=190010&start=1&sort=count">역사 / 문화일반 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=190020&start=1&sort=count">세계사 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=190030&start=1&sort=count">서양사 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=190040&start=1&sort=count">동양사 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=190050&start=1&sort=count">한국사 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=200&start=1&sort=count">종교</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=200010&start=1&sort=count">종교일반 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=200020&start=1&sort=count">기독교 (개신교) </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=200030&start=1&sort=count">가톨릭 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=200040&start=1&sort=count">불교 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=200050&start=1&sort=count">기타 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210&start=1&sort=count">예술/대중문화</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210010&start=1&sort=count">예술일반 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210020&start=1&sort=count">미술 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210030&start=1&sort=count">음악 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210040&start=1&sort=count">건축 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210050&start=1&sort=count">만화 / 애니메이션 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210060&start=1&sort=count">사진 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210070&start=1&sort=count">연극 / 영화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=210080&start=1&sort=count">TV / 대중문화 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=220&start=1&sort=count">학습/참고서</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=220010&start=1&sort=count">고등학교 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=220020&start=1&sort=count">중학교 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=220030&start=1&sort=count">초등학교 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=220040&start=1&sort=count">논술 / 면접대비 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=220050&start=1&sort=count">공부방법 / 진학 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=230&start=1&sort=count">국어/외국어</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=230010&start=1&sort=count">국어 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=230020&start=1&sort=count">영어 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=230030&start=1&sort=count">일본어 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=230040&start=1&sort=count">중국어 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=230050&start=1&sort=count">기타 외국어 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240&start=1&sort=count">사전</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-100px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240010&start=1&sort=count">한영 / 영한 / 영영사전 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240020&start=1&sort=count">일한 / 한일사전 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240030&start=1&sort=count">중한 / 한중사전 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240040&start=1&sort=count">한자사전 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240050&start=1&sort=count">국어사전 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240060&start=1&sort=count">기타나라어사전 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=240070&start=1&sort=count">백과 / 전문사전 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250&start=1&sort=count">과학/공학</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-200px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250010&start=1&sort=count">쉽게 읽는 과학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250020&start=1&sort=count">과학기본서 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250030&start=1&sort=count">수학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250040&start=1&sort=count">물리학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250050&start=1&sort=count">화학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250060&start=1&sort=count">생물학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250070&start=1&sort=count">천문 / 지구과학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250080&start=1&sort=count">도시 / 토목 / 건설 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250090&start=1&sort=count">공학일반 / 산업공학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250100&start=1&sort=count">기계 / 전기 / 전자 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250110&start=1&sort=count">농수산 / 축산 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=250120&start=1&sort=count">의학 / 식품 / 생활과학 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=260&start=1&sort=count">취업/수험서</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=260010&start=1&sort=count">취업 / 상식 / 적성검</a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=260020&start=1&sort=count">공무원 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=260030&start=1&sort=count">고시 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=260040&start=1&sort=count">전문직 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=260050&start=1&sort=count">편입 / 검정고시 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=270&start=1&sort=count">여행/지도</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div class="dropdown-menu" style="top:-10px">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=270010&start=1&sort=count">국내여행 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=270020&start=1&sort=count">해외여행 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=270030&start=1&sort=count">테마여행 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=270040&start=1&sort=count">지도 / 지리 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=280&start=1&sort=count">컴퓨터/IT</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-45px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=280010&start=1&sort=count">웹 / 컴퓨터입문 / 활용 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=280020&start=1&sort=count">IT 전문서 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=280030&start=1&sort=count">그래픽 / 멀티미디어 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=280040&start=1&sort=count">오피스활용도서 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=280050&start=1&sort=count">컴퓨터수험서 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290&start=1&sort=count">잡지</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-200px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290010&start=1&sort=count">여성 / 패션 / 리빙 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290020&start=1&sort=count">인문 / 사회 / 종교 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290030&start=1&sort=count">문예 / 교양지 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290040&start=1&sort=count">자연 / 공학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290050&start=1&sort=count">컴퓨터 / 게임 / 그래픽 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290060&start=1&sort=count">어학 / 교육 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290070&start=1&sort=count">예술 / 대중문화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290080&start=1&sort=count">취미 / 여행 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=290090&start=1&sort=count">외국잡지 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300&start=1&sort=count">청소년</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-205px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300010&start=1&sort=count">논술대비 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300020&start=1&sort=count">공부방법 / 진학가이드 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300030&start=1&sort=count">진로 / 진학가이드 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300040&start=1&sort=count">청소년 경제 / 자기계발 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300050&start=1&sort=count">청소년 문학 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300060&start=1&sort=count">청소년 인문 / 사회 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300070&start=1&sort=count">청소년 예술 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=300080&start=1&sort=count">청소년 과학 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=310&start=1&sort=count">유아</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-135px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=310010&start=1&sort=count">0 ~ 3세 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=310020&start=1&sort=count">4 ~ 7세 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=310030&start=1&sort=count">유아놀이책 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=310040&start=1&sort=count">유아그림책 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=310050&start=1&sort=count">유아학습 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=320&start=1&sort=count">어린이</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-140px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=320010&start=1&sort=count">초등 1 ~ 2학년 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=320020&start=1&sort=count">초등 3 ~ 4학년 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=320030&start=1&sort=count">초등  5 ~ 6학년 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=320040&start=1&sort=count">어린이 (공통)</a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=320050&start=1&sort=count">어린이영어 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330&start=1&sort=count">만화</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-400px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330010&start=1&sort=count">교양만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330020&start=1&sort=count">드라마 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330030&start=1&sort=count">성인만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330040&start=1&sort=count">순정만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330050&start=1&sort=count">스포츠만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330060&start=1&sort=count">SF / 판타지 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330070&start=1&sort=count">액션 / 무협만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330080&start=1&sort=count">명랑 / 코믹만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330090&start=1&sort=count">공포 / 추리 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330100&start=1&sort=count">학원만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330110&start=1&sort=count">웹툰 / 카툰에세이 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330120&start=1&sort=count">기타만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330130&start=1&sort=count">일본어판 만화 </a>
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=330140&start=1&sort=count">영문판 만화 </a>
				
		</div>
	</div>
	<div class="btn-group dropright">
		<a class="Main-Category"
			href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340&start=1&sort=count">해외도서</a>
		<span class="dropdown-toggle" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"></span>
		<div style="top:-525px" class="dropdown-menu">
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340010&start=1&sort=count">문학 / 소설 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340020&start=1&sort=count">유아청소년 / 교육 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340030&start=1&sort=count">경영경제 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340040&start=1&sort=count">건축 / 예술 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340050&start=1&sort=count">컴퓨터 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340060&start=1&sort=count">요리 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340070&start=1&sort=count">취미 / 여행 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340080&start=1&sort=count">가족 / 생활 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340090&start=1&sort=count">언어 / 외국어 / 사전 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340100&start=1&sort=count">철학 / 심리 / 역사 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340110&start=1&sort=count">종교 / 명상 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340120&start=1&sort=count">과학 / 공학 / 수학 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340130&start=1&sort=count">사회 / 정치 / 법 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340140&start=1&sort=count">독일 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340150&start=1&sort=count">프랑스 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340160&start=1&sort=count">스페인 </a> 
			<a class="dropdown-item"
				href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=340700&start=1&sort=count">일본도서 </a> 
		</div>
	</div>
</div>