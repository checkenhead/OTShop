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

		return (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
	}

	@Transactional(rollbackFor = { RuntimeException.class, Error.class })
	public boolean insertCart(String userid, int[] pdseq, int[] qty) {
		boolean result = true;

		try {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();

			for (int i = 0; i < pdseq.length; i++) {
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

	public void deleteCart(int cseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("cseq", cseq);

		cdao.deleteCart(paramMap);
	}

	public void deleteCartByCheckbox(int[] cseq) {
		for(int i = 0; i < cseq.length; i++)
			deleteCart(cseq[i]);
	}
	
	@Transactional(rollbackFor = { RuntimeException.class, Error.class })
	public boolean insertOrderByCart(String userid, int[] cseq) {
		boolean result = true;

		try {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();

			//cart -> order
			//1. 해당 userid를 orders에 insert
			//아래를 cseq.length 만큼 반복
			//2. cseq로 cart 레코드를 가져옴
			//3. orders에 insert한 oseq와 cart의 pdseq, qty 레코드를 order_detail에 insert
			//4. cseq의 레코드를 cart에서 삭제
			
			paramMap.put("userid", userid);
			paramMap.put("oseq", 0);
			
			cdao.insertOrders(paramMap);
			
			//int oseq = Integer.parseInt(paramMap.get("oseq").toString());
			
			for(int i = 0; i < cseq.length; i++) {
				paramMap.put("cseq", cseq[i]);
				paramMap.put("ref_cursor", null);
				
				cdao.getCart(paramMap);
				
				paramMap.put("pdseq", ((ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor")).get(0).get("PDSEQ"));
				paramMap.put("qty", ((ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor")).get(0).get("QTY"));
				
				cdao.insertOrderDetail(paramMap);
				
				cdao.deleteCart(paramMap);
			}
			
		} catch (Exception e) {
			result = false;
			throw new RuntimeException();
		}

		return result;
		
	}
}
