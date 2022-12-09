package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.ReplyDto;
import com.kh.pj.vo.ReplyListVO;

public interface ReplyDao {
	void insert(ReplyDto replyDto);
	List<ReplyListVO> selectList(int replyBoardPostNo);
	ReplyDto selectOne(int replyNo);
	boolean update(ReplyDto replyDto);
	boolean delete(int replyNo);
}
