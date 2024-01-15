package ot.team1.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.IProductDao;

@Service
public class ProductService {
	@Autowired
	IProductDao pdao;

	public ArrayList<HashMap<String, Object>> getCatSetList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		
		pdao.getMainCatSetList(paramMap);
		
		ArrayList<HashMap<String, Object>> mainCategoryList = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		for(HashMap<String, Object> mainCategory : mainCategoryList) {
			paramMap.put("pmcsseq", Integer.parseInt(mainCategory.get("PMCSSEQ").toString()));
			paramMap.put("ref_cursor", null);
			
			pdao.getSubCatSetList(paramMap);
			
			mainCategory.put("subCategoryList", paramMap.get("ref_cursor"));
		}
		
		return mainCategoryList;
	}

	public Object getProductList(String keyword) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);
		paramMap.put("keyword", keyword);

		pdao.getProductList(paramMap);

		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		for (HashMap<String, Object> pvo : result) {
			//optionList start
			pvo.put("ref_cursor", null);

			pdao.getProductDetailList(pvo);

			ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>) pvo.get("ref_cursor");

			pvo.put("optionList", optionList);
			//optionList end
			
			//price set
			pvo.put("price", Integer.parseInt(optionList.get(0).get("PRICE2").toString()));
			
			//category start
			pvo.put("ref_cursor", null);
			
			pdao.getProductMainCatList(pvo);
			
			ArrayList<HashMap<String, Object>> mainCategoryList = (ArrayList<HashMap<String, Object>>) pvo.get("ref_cursor");
			
			pvo.put("mainCategoryList", mainCategoryList);
			
			pvo.put("ref_cursor", null);
			
			pdao.getProductSubCatList(pvo);
			
			ArrayList<HashMap<String, Object>> subCategoryList = (ArrayList<HashMap<String, Object>>) pvo.get("ref_cursor");
			
			pvo.put("subCategoryList", subCategoryList);
			//category end
		}
		
		return result;
	}
}
