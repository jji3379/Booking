### *도서 추천 웹 서비스 Booking* (www.acornsbook.me)

### 개발 목적
- 사용자의 관심사 위주의 정보들을 제공해 주는 것을 목표로 개발되었습니다.

### Backend 
- Java 
- Spring 
- JPA
### DevOps
- Mysql 
- AWS EC2 
- AWS RDS 
- AWS Route 53

### 제공 서비스
Home | 전체도서 | 도서 리뷰 | 지도 | 회원 관리 | 결제
-- | - | - | - | - | -
도서 검색          | 장르별 도서 분류 | 리뷰 목록    | 서점 위치 검색 | 개인 정보 수정 | 장바구니
사용자 맞춤 책 추천 | 인기 도서       | 리뷰 작성    |               | 내가 쓴 리뷰 | 배송비 추가
랜덤 책 추천        | 최신 도서      | 별점         |               | 내가 쓴 댓글 | 결제
|                  | 추천 도서      | 스포일러 여부 |               | 주문 내역 | 바로 결제
|                  | 책 상세 정보   | 댓글, 답글    |               | 회원 탈퇴
|                  |               | 조회수        |               |

### Rest Api
### API 샘플 정보
Method | Url           | 출력 포맷     | 설명
--     | -             | -            | -
GET    | v1/reviews    | JSON         | 전체 리뷰 조회     
GET    | v1/review/{id}| JSON         | 리뷰 상세 조회     
POST   | v1/review     | JSON         | 리뷰 등록     
PUT    | v1/review/{id}| JSON         | 리뷰 수정     
DELETE | v1/review/{id}| JSON         | 리뷰 삭제     

****
## Home
### - 메인 추천 -

<img src="https://i.ibb.co/PTMXQnv/image.png" border="0">
  
### - 책 랜덤 추천 -

<img src="https://i.ibb.co/Zzt9jDr/2.png" border="0">

## 도서 리뷰

### - 책의 별점 평균,리뷰 수 -

<img src="https://i.ibb.co/r4h7rS6/image.png" border="0">

### - 스포일러 유무 -

<img src="https://i.ibb.co/CJddzxc/image.png" border="0">

## 회원 관리
### - 마이페이지 -

<img src="https://i.ibb.co/zQnfx1s/image.png" alt="info" border="0">
