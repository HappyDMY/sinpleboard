package com.semipject.board.member;

public interface MemberMapper {


	//<select id="login">
	public MemberDTO login(MemberDTO dto);
	
	public MemberDTO profile(String m_id);
	
	public int modify(MemberDTO dto);

}