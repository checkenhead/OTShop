package ot.team1.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ot.team1.dao.ICartDao;

@Service
public class CartService {
	@Autowired
	ICartDao cdao;

	public ArrayList<HashMap<String, Object>> getCartList(String userid) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("userid", userid);
		paramMap.put("ref_cursor", null);
		
		cdao.getCartList(paramMap);
		
		return (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
	}
	
	@Transactional(rollbackFor = { RuntimeException.class, Error.class })
	public boolean insertCart(String userid, int[] pdseq, int[] qty) {
		boolean result = true;
		
		try {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			for(int i = 0; i < pdseq.length; i++) {
				paramMap.put("userid", userid);
				paramMap.put("pdseq", pdseq[i]);
				paramMap.put("qty", qty[i]);
				
				cdao.insertCart(paramMap);
			}
			
		} catch (Exception e) {
			result = false;
			throw new RuntimeException();
		}

		return result;
		
	}
}
