package ot.team1.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.ILogisDao;

@Service
public class LogisService {
	
	@Autowired
	ILogisDao ldao;

	public HashMap<String, Object> getLogis(String logisid) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("logisid", logisid);
		paramMap.put("rfcursor", null);
		
		ldao.getLogis(paramMap);
		
		ArrayList<HashMap<String, Object>> list =
				(ArrayList<HashMap<String, Object>>) paramMap.get("rfcursor");
		
		return ( list == null || list.size() == 0 ) ? null : list.get(0);
	}


}
