--재료 분류
create table category(
main_category varchar2(30) primary key
);

--음식 재료
create table ingredient(
ingredient_name varchar2(30) primary key,
ingredient_category 
    references ingredient_category(main_category) 
    on delete set null
);

--검색어 저장
create table search(
search_ingredient references ingredient(ingredient_name) on delete cascade,
search_time date default sysdate
);

--관리자
create table admin(
admin_id varchar2(60) primary key,
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
hashtag_food_name varchar2(30) primary key,
hashtag_time date default sysdate not null
);

--레시피
create table recipe(
recipe_no number primary key,
admin_nick references admin(admin_nick) on delete set null,
recipe_title varchar2(60) not null,
recipe_info varchar2(300) not null,
recipe_content varchar2(4000) not null,
recipe_like number not null check(recipe_like >= 0),
hashtag_food_name references hashtag(hashtag_food_name) on delete set null,
recipe_upload date default sysdate not null,
recipe_edit date,
recipe_time number not null check(recipe_time >= 0)
);

--레시피 시퀀스
create sequence recipe_seq;

--레시피 재료
create table recipe_ingredient(
recipe_ingredient_name references ingredient(ingredient_name) on delete set null,
recipe_origin_no references recipe(reipe_no) on delete cascade
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

--회원
create table member(
member_id varchar2(60) primary key,
member_pw 
);
