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

	public ArrayList<HashMap<String, Object>> getProductCatList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		
		adao.getProductCatList(paramMap);
		
		return (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
	}

	public void insertProduct(HashMap<String, Object> paramMap) {
		ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>)paramMap.get("optionList");
		
		paramMap.put("pseq", 0);
		
		adao.insertProduct(paramMap);
		
		int pseq = Integer.parseInt(paramMap.get("pseq").toString());
		
		for(HashMap<String, Object> ovo : optionList) {
			ovo.put("pseq", pseq);
			System.out.println("pseq:" + ovo.get("pseq") + " optname:" + ovo.get("optname") + " price1:" + ovo.get("price1") + 
					" price2:" + ovo.get("price2") + " price3:" + ovo.get("price3") + " stock:" + ovo.get("stock"));
			adao.insertProductDetail(ovo);
		}
	}

	public ArrayList<HashMap<String, Object>> getProductList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		
		adao.getProductList(paramMap);
		
		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		
		//각 product의 detail을 추가
		for(HashMap<String, Object> pvo : result) {
			pvo.put("ref_cursor", null);
			//System.out.println("name : " + pvo.get("NAME"));
			
			adao.getProductDetailList(pvo);
			
			ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>)pvo.get("ref_cursor");
			
			pvo.put("optionList", optionList);
			
//			for(HashMap<String, Object> ovo : optionList) {
//				System.out.println("pseq:" + ovo.get("PSEQ") + " optname:" + ovo.get("OPTNAME") + " price1:" + ovo.get("PRICE1") + 
//						" price2:" + ovo.get("PRICE2") + " price3:" + ovo.get("PRICE3") + " stock:" + ovo.get("STOCK"));
//			}
			
		}
		
		return result;
	}
}
