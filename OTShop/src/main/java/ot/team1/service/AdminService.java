package ot.team1.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Transactional(rollbackFor = {RuntimeException.class, Error.class})
	public boolean insertProduct(HashMap<String, Object> paramMap) {
		ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>)paramMap.get("optionList");
		boolean result = true;
		
		paramMap.put("pseq", 0);
		
		try {
			adao.insertProduct(paramMap);

			int pseq = Integer.parseInt(paramMap.get("pseq").toString());
			
			for(HashMap<String, Object> ovo : optionList) {
				ovo.put("PSEQ", pseq);
				
				System.out.println("pseq:" + ovo.get("pseq") + " optname:" + ovo.get("optname") + " price1:" + ovo.get("price1") + 
						" price2:" + ovo.get("price2") + " price3:" + ovo.get("price3") + " stock:" + ovo.get("stock"));
				
				adao.insertProductDetail(ovo);
			}
		} catch(Exception e) {
			System.out.println("Service insertProduct Error");
			
			result = false;
			
			throw new RuntimeException();
		}
		
		return result;
	}

	public ArrayList<HashMap<String, Object>> getProductList(String keyword) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		paramMap.put("keyword", keyword);
		
		adao.getProductList(paramMap);
		
		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		
		//각 product의 detail을 추가
		for(HashMap<String, Object> pvo : result) {
			pvo.put("ref_cursor", null);
			
			adao.getProductDetailList(pvo);
			
			ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>)pvo.get("ref_cursor");
			
			pvo.put("optionList", optionList);
		}
		
		return result;
	}

	public ArrayList<HashMap<String, Object>> getProductCatListwithCount() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		adao.getProductCatList(paramMap);
		
		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		for(HashMap<String, Object> vo : result) {
			paramMap.put("tablename", "product");
			paramMap.put("keynum", Integer.parseInt(vo.get("PCSEQ").toString()));
			paramMap.put("count", 0);
			
			adao.getCount(paramMap);
			
			String count = paramMap.get("count").toString();
			
			vo.put("COUNT", Integer.parseInt(count.equals("")?"0":count));
		}
		
		return result;
	}

	public void insertProductCat(String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("name", name);
		
		adao.insertProductCat(paramMap);
	}

	public void deleteProductCat(int pcseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("pcseq", pcseq);
		
		adao.deleteProductCat(paramMap);
		
	}
	
	public void updateProductCat(int pcseq, String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("pcseq", pcseq);
		paramMap.put("name", name);
		
		adao.updateProductCat(paramMap);
		
	}

	public HashMap<String, Object> getProduct(int pseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("pseq", pseq);
		paramMap.put("ref_cursor", null);
		
		adao.getProduct(paramMap);
		
		HashMap<String, Object> result = ((ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor")).get(0);
		
		result.put("ref_cursor", null);
		
		adao.getProductDetailList(result);
		
		//옵션 저장
		result.put("optionList", result.get("ref_cursor"));
		
		return result;

	}

	@Transactional(rollbackFor = {RuntimeException.class, Error.class})
	public boolean updateProduct(HashMap<String, Object> paramMap) {
		boolean result = true;
		
		try {
			adao.updateProduct(paramMap);
			System.out.println("Service updateProduct PSEQ : " + (int)paramMap.get("PSEQ"));
			int pseq = (int)paramMap.get("PSEQ");
			
			//ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>)paramMap.get("optionList");
			
			for(HashMap<String, Object> ovo : (ArrayList<HashMap<String, Object>>)paramMap.get("optionList")) {
				System.out.println("Service updateProduct PDSEQ : " + (int)ovo.get("PDSEQ"));
				ovo.put("PSEQ", pseq);
				
				System.out.println("pseq:" + ovo.get("PSEQ") + "pdseq:" + ovo.get("PDSEQ") + " optname:" + ovo.get("OPTNAME") + " price1:" + ovo.get("PRICE1") + 
						" price2:" + ovo.get("PRICE2") + " price3:" + ovo.get("PRICE3") + " stock:" + ovo.get("STOCK"));
				if((int)ovo.get("PDSEQ") != 0)
					adao.updateProductDetail(ovo);
				else
					adao.insertProductDetail(ovo);
					
			}
		} catch(Exception e) {
			System.out.println("Service updateProduct Error");
			
			result = false;
			
			throw new RuntimeException();
		}
		
		return result;
	}

	public ArrayList<HashMap<String, Object>> getFaqList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		
		adao.getFaqList(paramMap);
		
		return (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
	}

	public ArrayList<HashMap<String, Object>> getFaqCatListwithCount() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		adao.getFaqCatList(paramMap);
		
		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		for(HashMap<String, Object> vo : result) {
			paramMap.put("tablename", "faq");
			
			String keynumStr = vo.get("FCSEQ") == null ? "0" : vo.get("FCSEQ").toString();
			
			paramMap.put("keynum", Integer.parseInt(keynumStr));
			paramMap.put("count", 0);
			
			adao.getCount(paramMap);
			
			String count = paramMap.get("count").toString();
			
			vo.put("COUNT", Integer.parseInt(count.equals("")?"0":count));
		}
		
		return result;
	}

	public void insertFaqCat(String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("name", name);
		
		adao.insertFaqCat(paramMap);
	}

	public void deleteFaqCat(int fcseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("fcseq", fcseq);
		
		adao.deleteFaqCat(paramMap);
		
	}
	
	public void updateFaqCat(int fcseq, String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("fcseq", fcseq);
		paramMap.put("name", name);
		
		adao.updateFaqCat(paramMap);
		
	}
	
}
