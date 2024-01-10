package ot.team1.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.IMemberDao;

@Service
public class MemberService {
	
	@Autowired
	IMemberDao mdao;

	public void getMember(HashMap<String, Object> paramMap) {
		mdao.getMember(paramMap);
	}

	public void joinKakao(HashMap<String, Object> paramMap) {
		mdao.joinKakao(paramMap);
	}

	public void insertMember(HashMap<String, Object> paramMap) {
		mdao.insertMember(paramMap);
	}

	public void updateMember(HashMap<String, Object> paramMap) {
		mdao.updateMember(paramMap);
		
	}

	public void deleteMember(HashMap<String, Object> paramMap) {
		mdao.deleteMember(paramMap);
		
	}

	public void findId(HashMap<String, Object> paramMap) {
		mdao.findId(paramMap);		
	}

	public void findPwd(HashMap<String, Object> paramMap) {
		mdao.findPwd(paramMap);
		
	}



}
