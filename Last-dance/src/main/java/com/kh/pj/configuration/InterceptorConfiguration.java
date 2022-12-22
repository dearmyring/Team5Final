package com.kh.pj.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.pj.interceptor.MemberInterceptor;


@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	
//	@Autowired
//	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
//	@Autowired
//	private RecipeWriteCheckInterceptor recipeWriteCheckInterceptor;
//	
//	@Autowired
//	private MemberBoardOwnerCheckInterceptor ownerCheckInterceptor;
//
//	@Autowired
//	private MemberReplyOwnerCheckInterceptor ownerCheckInterceptor2;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {

	
	
	//회원용 인터셉터
		registry.addInterceptor(memberInterceptor)
						.addPathPatterns(//인터셉터가 감시할 주소
								"/member/**"//회원 전체
								
					)
			.excludePathPatterns(//위의 주소에서 제외할 주소
								"/member/join*",//회원가입
								"/member/login",//로그인
								"/recipe/list",//전체보기
								"/recipe/detail", //전체보기(레시피)상세
								"/board/list", //유저게시판
								"/board/detail", //유저게시판 상세
								"/recipe/searchList",//통합검색
								"/notice/detail" //공지 상세
				);
	
	
//	//관리자용 인터셉터
//				registry.addInterceptor(adminInterceptor)
//				.addPathPatterns(//인터셉터가 감시할 주소
//								"/admin/**"
//							)
//							.excludePathPatterns(//위의 주소에서 제외할 주소
//									"admin/login"
//
//							);
//				
//	//관리자만 레시피를 등록할 수 있도록 검사하는 인터셉터
//				registry.addInterceptor(recipeWriteCheckInterceptor)
//							.addPathPatterns(
//									"/recipe/write", 
//									"/recipe/update", 
//									"/recipe/delete"
//							);
//				
//	//소유자 또는 관리자만 글 수정/삭제를 할 수 있도록 검사하는 인터셉터
//				registry.addInterceptor(ownerCheckInterceptor)
//							.addPathPatterns(
//									"/board/edit",
//									"/board/delete"
//							);
//				
//	//소유자만 댓글 수정/삭제 가능하도록 검사하는 인터셉터
//				registry.addInterceptor(ownerCheckInterceptor2)
//							.addPathPatterns(
//								"/board/reply/edit",
//								"/board/reply/delete"
//							);			
//
//		
//	
	
	
	}
}
