package com.kh.pj.vo;

import java.util.List;

import lombok.Data;
import lombok.ToString;
@Data
public class RecipeKeywordListSearchVO {
	//필드
	private String keyword; // 검색어
	private List<String> submitList;
	
	@ToString.Include
	// 검색 조회인지 반환
	public boolean isSearch() {
		
	// 분류와 검색어가 모두 존재한다면(둘 다 null이 아니라면)
		return keyword != null;
	}
	
	//현재 페이지 게시글 rownum의 시작과 끝 번호 관련
	//필드
	private int p = 1;  		//현재 페이지 번호(기본값 1이 되도록)
	private int size = 10; // 페이지에 표시할 게시글의 수
	
	// 메소드
	// 현재 페이지 첫 게시글 rownum
	@ToString.Include
	public int startRow() {
		return endRow() - (size - 1);
	}
	
	//현재 페이지 마지막 게시글
	@ToString.Include
	public int endRow() {
		return p * size;
	}
	
	//총 게시글 수
	private int count;

	//화면에 표시할 블럭 개수
	private int blockSize = 10;
	
	//마지막 게시글이 속한 블럭 번호(마지막 페이지 번호)
	@ToString.Include
	public int pageCount() {
		return (count + size - 1) / size;
	}
	
	//현재 페이지에 표시할 블럭의 시작번호
	@ToString.Include
	public int startBlock() {
		return (p - 1) / blockSize * blockSize + 1;
	}
	
	//현재 페이지에 표시할 블럭의 끝번호
	@ToString.Include
	public int endBlock() {
		int value = startBlock() + blockSize - 1;
		return Math.min(value, lastBlock());
	}
	
	//이전 블럭의 번호 반환
	@ToString.Include
	public int prevBlock() {
		return startBlock() - 1;
	}
	
	//다음 블럭으 번호 반환
	@ToString.Include
	public int nextBlock() {
		return endBlock() + 1;
	}
	
	//현재 블럭이 첫 번째 블럭인지 반환
	@ToString.Include 
	public int firstBlock() {
		return 1;
	}
	
	//현재 블럭이 마지막 블럭인지 반환
	@ToString.Include
	public int lastBlock() {
		return pageCount();
	}
	
	//현재 블럭이 첫 번째 블럭인지 여부 반환
	@ToString.Include
	public boolean isFirst() {
		return p == 1;
	}
	
	//현재 블럭이 마지막 블럭인지 여부 반환
	@ToString.Include
	public boolean isLast() {
		return endBlock() == lastBlock();
	}
	
	//이전 블럭 구간이 존재하는지의 여부 반환
	@ToString.Include
	public boolean hasPrev() {
		return startBlock() > 1;
	}
	//다음 블럭 구간
	@ToString.Include
	public boolean hasNext() {
		return endBlock() < lastBlock();
	}
	
//	//검색이나 크기 등이 유지될 수 있도록 Query String을 생성
//	//- p(페이지 번호)를 제외한 나머지 항목들에 대한 파라미터 생성, 그 값을 반환
//	@ToString.Include
//	public String parameter() {
//		if(isSearch()) { //검색조회일 경우
//			return "size="+size+"&type="+type+"&keyword="+keyword;
//		}
//		else { //전체 조회일 경우
//			return "size="+size;
//		}
//		
//	}

}
