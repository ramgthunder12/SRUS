package kr.co.srus.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	public void insert(Member member) throws Exception;

	public List<Member> selectAll(Member member) throws Exception;
	
	public List<Member> selectAllById(Member member) throws Exception;

	public Member select(Member member) throws Exception;

	public int update(Member member) throws Exception;
}