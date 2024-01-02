package ot.team1.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.IAdminDao;

@Service
public class AdminService {
	@Autowired
	IAdminDao adao;

	public HashMap<String, Object> getAdmin(String adminid) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("adminid", adminid);
		paramMap.put("ref_cursor", null);
		
		adao.getAdmin(paramMap);
		
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		return (list==null || list.size()==0)?null:list.get(0);
	}
}
