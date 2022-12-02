--재료 분류
create table category(
category_main varchar2(30) primary key
);

--음식 재료
create table ingredient(
ingredient_name varchar2(30) primary key,
ingredient_category 
    references category(category_main) 
    on delete set null
);

--검색어 저장
create table search(
search_ingredient references ingredient(ingredient_name) on delete cascade,
search_time date default sysdate not null
);

--관리자
create table admin(
admin_id varchar2(60) primary key 
check(
    regexp_like(admin_id,'^[a-z][a-z0-9_-]{4,19}$')
),
admin_pw varchar2(48) not null 
check(
    regexp_like(admin_pw, '^[a-zA-Z0-9!@#$]{8,16}$')
    and
    regexp_like(admin_pw, '[a-z]')
    and
    regexp_like(admin_pw, '[0-9]')
    and
    regexp_like(admin_pw, '[!@#$]')
),
admin_nick varchar2(30) not null unique
check(
    regexp_like(admin_nick, '^[a-zA-Z0-9가-힣]{1,10}$')
)
);

--취향 해시태그
create table hashtag(
hashtag_name varchar2(60) primary key,
hashtag_time date default sysdate not null
);

--레시피
create table recipe(
recipe_no number primary key,
recipe_nick references admin(admin_nick) on delete set null,
recipe_title varchar2(60) not null,
recipe_info varchar2(300) not null,
recipe_time number not null check(recipe_time >= 0),
recipe_click number default 0 not null check(recipe_click >= 0),
recipe_like number default 0 not null check(recipe_like >= 0),
recipe_hashtag references hashtag(hashtag_name) on delete set null,
recipe_writetime date default sysdate not null,
recipe_edittime date,
recipe_difficulty varchar2(15) not null check(recipe_difficulty in('쉬워요', '보통이에요', '어려워요'))
);

--레시피 시퀀스
create sequence recipe_seq;

--레시피 내용
create table recipe_content(
recipe_content_no number primary key,
recipe_no number references recipe(recipe_no) on delete cascade,
recipe_content_text varchar2(4000) not null
);

--레시피 내용 시퀀스
create sequence recipe_content_seq;

--레시피 재료
create table recipe_ingredient(
recipe_ingredient_name references ingredient(ingredient_name) on delete set null,
recipe_no references recipe(recipe_no) on delete cascade
);

--첨부파일
create table attachment(
attachment_no number primary key,
attachment_name varchar2(256) not null,
attachment_type varchar2(30) not null,
attachment_size number not null check(attachment_size >= 0),
attachment_date date default sysdate not null
);

--첨부파일 시퀀스
create sequence attachment_seq;

--레시피 썸네일 이미지
create table recipe_img(
recipe_attachment_no references attachment(attachment_no) on delete cascade,
recipe_no references recipe(recipe_no) on delete cascade
);

--레시피 내용 이미지
create table recipe_content_img(
recipe_content_attachment_no references attachment(attachment_no) on delete cascade,
recipe_content_no references recipe_content(recipe_content_no) on delete cascade
);

--회원
create table member(
member_id varchar2(60) primary key
/* check(
    regexp_like(member_id,'^[@]$')
)*/,
member_pw varchar2(48) not null 
check(
    regexp_like(member_pw, '^[a-zA-Z0-9!@#$]{8,16}$')
    and
    regexp_like(member_pw, '[a-z]')
    and
    regexp_like(member_pw, '[0-9]')
    and
    regexp_like(member_pw, '[!@#$]')
),
member_phone varchar2(11) not null unique 
check(
    regexp_like(member_phone,'^010\d{7,8}$')
),
member_nick varchar2(30) not null unique 
check(
    regexp_like(member_nick,'^[a-zA-Z0-9가-힣]{1,10}$')
),
member_gender char(1) not null check(member_gender in('M', 'F')),
member_point number default 0 not null check(member_point >= 0),
member_disabled char(1) default 'N' not null check(member_disabled in('Y', 'N')),
member_badge varchar2(20)/* not null default */,
member_join date default sysdate not null,
member_login date
);

--회원 프로필
create table profile_img(
profile_id references member(member_id) on delete cascade,
profile_attachment_no references attachment(attachment_no) on delete cascade,
profile_time date default sysdate not null
);

--레시피 좋아요
create table recipe_like(
recipe_like_no references recipe(recipe_no) on delete cascade,
recipe_like_id references member(member_id) on delete cascade,
recipe_like_time date default sysdate not null,
primary key(recipe_like_no, recipe_like_id)
);

--내가 본 레시피
create table recipe_view(
recipe_view_id references member(member_id) on delete cascade,
recipe_view_no references recipe(recipe_no) on delete cascade,
recipe_view_time date default sysdate not null
);

--1대1 문의
create table center(
center_member_id references member(member_id) on delete set null,
center_id varchar2(60) not null,
center_content varchar2(4000) not null, 
center_time date default sysdate not null
);

--게시판
create table board(
board_no number primary key,
board_id references member(member_id) on delete set null,
board_title varchar2(60) not null,
board_content varchar2(4000) not null,
board_click number default 0 not null check(board_click >= 0),
board_like number default 0 not null check(board_like >= 0),
board_writetime date default sysdate not null,
board_edittime date,
board_blind char(1) default 'N' not null check(board_blind in('Y', 'N'))
);

--게시판 시퀀스
create sequence board_seq;

--게시판 이미지
create table board_img(
board_attachment_no references attachment(attachment_no) on delete cascade,
board_no references board(board_no) on delete cascade
);

--게시판 좋아요
create table board_like(
board_like_no references board(board_no) on delete cascade,
board_like_id references member(member_id) on delete cascade,
board_like_time date default sysdate not null,
primary key(board_like_no, board_like_id)
);

--댓글
create table reply(
reply_no number primary key,
reply_board_no references board(board_no) on delete cascade,
reply_id references member(member_id) on delete set null,
reply_content varchar2(300) not null,
reply_writetime date default sysdate not null,
reply_edittime date,
reply_blind char(1) default 'N' check(reply_blind in('Y', 'N'))
);

--댓글 시퀀스
create sequence reply_seq;

--공지사항
create table notice(
notice_no number primary key,
notice_nick references admin(admin_nick) on delete set null,
notice_title varchar2(60) not null,
notice_content varchar2(4000) not null,
notice_click number default 0 not null check(notice_click >= 0),
notice_writetime date default sysdate not null,
notice_edittime date
);

--공지사항 시퀀스
create sequence notice_seq;

--회원가입 인증
create table cert(
cert_who varchar2(60) primary key,
cert_serial char(6) not null,
cert_when date default sysdate not null
);

--비밀번호 인증
create table find_cert(
find_cert_who references member(member_id) on delete cascade,
find_cert_serial char(6) not null,
find_cert_when date default sysdate not null
);
