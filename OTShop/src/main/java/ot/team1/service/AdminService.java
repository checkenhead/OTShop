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

		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		return (list == null || list.size() == 0) ? null : list.get(0);
	}

	@Transactional(rollbackFor = { RuntimeException.class, Error.class })
	public boolean insertProduct(HashMap<String, Object> paramMap) {
		ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>) paramMap.get("optionList");
		boolean result = true;

		paramMap.put("pseq", 0);

		try {
			adao.insertProduct(paramMap);
			
			int pseq = Integer.parseInt(paramMap.get("pseq").toString());

			for (HashMap<String, Object> ovo : optionList) {
				ovo.put("PSEQ", pseq);

				//System.out.println("pseq:" + ovo.get("pseq") + " optname:" + ovo.get("optname") + " price1:"
						//+ ovo.get("price1") + " price2:" + ovo.get("price2") + " price3:" + ovo.get("price3")
						//+ " stock:" + ovo.get("stock"));

				adao.insertProductDetail(ovo);
			}
		} catch (Exception e) {
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

		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		// 각 product의 detail을 추가
		for (HashMap<String, Object> pvo : result) {
			pvo.put("ref_cursor", null);

			adao.getProductDetailList(pvo);

			ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String, Object>>) pvo.get("ref_cursor");

			pvo.put("optionList", optionList);
		}

		return result;
	}

	public ArrayList<HashMap<String, Object>> getProductCatList(String categoryClass) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);
		paramMap.put("categoryClass", categoryClass);

		adao.getProductCatList(paramMap);

		return (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
	}
	
	public ArrayList<HashMap<String, Object>> getProductCatListwithCount(String categoryClass) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);
		paramMap.put("categoryClass", categoryClass);
		
		adao.getProductCatList(paramMap);

		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		for (HashMap<String, Object> vo : result) {
			paramMap.put("tablename", "product_" + categoryClass + "_category");
			paramMap.put("keynum", Integer.parseInt(vo.get(categoryClass.equals("main") ? "PMCSEQ" : "PSCSEQ").toString()));
			paramMap.put("count", 0);

			adao.getCount(paramMap);

			String count = paramMap.get("count").toString();

			vo.put("COUNT", Integer.parseInt(count.equals("") ? "0" : count));
		}

		return result;
	}

	/* 상품 카테고리 변경
	public void insertProductCat(String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("name", name);

		adao.insertProductCat(paramMap);
	}
	*/
	
	public void insertProductCat(String categoryClass, String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("tablename", categoryClass);
		paramMap.put("name", name);

		adao.insertProductCat(paramMap);
	}

	public void deleteProductCat(String categoryClass, int index) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("tablename", categoryClass);
		paramMap.put("index", index);

		adao.deleteProductCat(paramMap);

	}

	public void updateProductCat(String categoryClass, int index, String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("tablename", categoryClass);
		paramMap.put("index", index);
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

		// 옵션 저장
		result.put("optionList", result.get("ref_cursor"));

		return result;

	}

	@Transactional(rollbackFor = { RuntimeException.class, Error.class })
	public boolean updateProduct(HashMap<String, Object> paramMap) {
		boolean result = true;

		try {
			adao.updateProduct(paramMap);
			System.out.println("Service updateProduct PSEQ : " + (int) paramMap.get("PSEQ"));
			int pseq = (int) paramMap.get("PSEQ");

			// ArrayList<HashMap<String, Object>> optionList = (ArrayList<HashMap<String,
			// Object>>)paramMap.get("optionList");

			for (HashMap<String, Object> ovo : (ArrayList<HashMap<String, Object>>) paramMap.get("optionList")) {
				System.out.println("Service updateProduct PDSEQ : " + (int) ovo.get("PDSEQ"));
				ovo.put("PSEQ", pseq);

				System.out.println("pseq:" + ovo.get("PSEQ") + "pdseq:" + ovo.get("PDSEQ") + " optname:"
						+ ovo.get("OPTNAME") + " price1:" + ovo.get("PRICE1") + " price2:" + ovo.get("PRICE2")
						+ " price3:" + ovo.get("PRICE3") + " stock:" + ovo.get("STOCK"));
				if ((int) ovo.get("PDSEQ") != 0)
					adao.updateProductDetail(ovo);
				else
					adao.insertProductDetail(ovo);

			}
		} catch (Exception e) {
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

		return (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
	}

	public ArrayList<HashMap<String, Object>> getFaqCatListwithCount() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);
		adao.getFaqCatList(paramMap);

		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		for (HashMap<String, Object> vo : result) {
			paramMap.put("tablename", "faq");

			String keynumStr = vo.get("FCSEQ") == null ? "0" : vo.get("FCSEQ").toString();

			paramMap.put("keynum", Integer.parseInt(keynumStr));
			paramMap.put("count", 0);

			adao.getCount(paramMap);

			String count = paramMap.get("count").toString();

			vo.put("COUNT", Integer.parseInt(count.equals("") ? "0" : count));
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

	public Object getFaqCatList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);

		adao.getFaqCatList(paramMap);

		return (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
	}

	public void insertFaq(int fcseq, String title, String content) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("fcseq", fcseq);
		paramMap.put("title", title);
		paramMap.put("content", content);

		adao.insertFaq(paramMap);
	}

	public void updateFaq(int fseq, int fcseq, String title, String content) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("fseq", fseq);
		paramMap.put("fcseq", fcseq);
		paramMap.put("title", title);
		paramMap.put("content", content);

		adao.updateFaq(paramMap);
	}

	public void deleteFaq(int fseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("fseq", fseq);

		adao.deleteFaq(paramMap);
	}

	public ArrayList<HashMap<String, Object>> getMemberList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);

		adao.getMemberList(paramMap);

		return (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
	}

	public void changeMemberUseyn(String userid, String useyn) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("userid", userid);
		paramMap.put("useyn", useyn);

		adao.changeMemberUseyn(paramMap);

	}

	public Object getQnaList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);

		adao.getQnaList(paramMap);

		return (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
	}

	public Object getQnaCatListwithCount() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);
		adao.getQnaCatList(paramMap);

		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		for (HashMap<String, Object> vo : result) {
			paramMap.put("tablename", "qna");

			String keynumStr = vo.get("QCSEQ") == null ? "0" : vo.get("QCSEQ").toString();

			paramMap.put("keynum", Integer.parseInt(keynumStr));
			paramMap.put("count", 0);

			adao.getCount(paramMap);

			String count = paramMap.get("count").toString();

			vo.put("COUNT", Integer.parseInt(count.equals("") ? "0" : count));
		}

		return result;
	}

	public void insertQnaCat(String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("name", name);

		adao.insertQnaCat(paramMap);
	}

	public void deleteQnaCat(int qcseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("qcseq", qcseq);

		adao.deleteQnaCat(paramMap);

	}

	public void updateQnaCat(int qcseq, String name) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("qcseq", qcseq);
		paramMap.put("name", name);

		adao.updateQnaCat(paramMap);

	}

	public HashMap<String, Object> getQna(int qseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("qseq", qseq);
		paramMap.put("ref_cursor", null);

		adao.getQna(paramMap);

		return ((ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor")).get(0);
	}

	public void updateQnaReply(int qseq, String reply) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("qseq", qseq);
		paramMap.put("reply", reply);

		adao.updateQnaReply(paramMap);
	}

	public void deleteQna(int qseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("qseq", qseq);

		adao.deleteQna(paramMap);
	}

	public void insertBannerImage(String name, String image) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("name", name);
		paramMap.put("image", image);

		adao.insertBannerImage(paramMap);
	}

	public Object getBannerImageListwithCount() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);
		adao.getBannerImageList(paramMap);

		ArrayList<HashMap<String, Object>> result = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		for (HashMap<String, Object> vo : result) {
			paramMap.put("tablename", "banner");

			String keynumStr = vo.get("BISEQ") == null ? "0" : vo.get("BISEQ").toString();

			paramMap.put("keynum", Integer.parseInt(keynumStr));
			paramMap.put("count", 0);

			adao.getCount(paramMap);

			String count = paramMap.get("count").toString();

			vo.put("COUNT", Integer.parseInt(count.equals("") ? "0" : count));
		}

		return result;
	}

	public void deleteBannerImage(int biseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("biseq", biseq);

		adao.deleteBannerImage(paramMap);

	}

	public String getImageByBiseq(int biseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("biseq", biseq);
		paramMap.put("image", "");

		adao.getImageByBiseq(paramMap);

		return (String) paramMap.get("image");
	}

	public void insertBanner(int biseq, String uri, String useyn) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		// useyn이 Y이면 priority 최대 값 + 1

		paramMap.put("maxpriority", 0);

		adao.getMaxPriority(paramMap);

		paramMap.put("biseq", biseq);
		paramMap.put("uri", uri);
		paramMap.put("useyn", useyn);
		paramMap.put("priority",
				useyn.equals("N") ? 0 : (Integer.parseInt(paramMap.get("maxpriority").toString()) + 1));

		adao.insertBanner(paramMap);
	}

	public Object getBannerList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ref_cursor", null);

		adao.getBannerList(paramMap);

		return (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
	}

	@Transactional(rollbackFor = { RuntimeException.class, Error.class })
	public boolean deleteBanner(int bseq) {
		boolean result = true;

		try {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("bseq", bseq);

			adao.deleteBanner(paramMap);

			// 삭제된 banner 레코드의 priority가 공백이 생기므로 shift 필요
			// 1. priorty가 0이 아닌 레코드 리스트 저장(priority는 오름차순 정렬)
			// 2. for 1부터 index와 같지 않은 priority를 가진 레코드 업데이트

			paramMap.put("ref_cursor", null);

			adao.getBannerPriorityList(paramMap);

			ArrayList<HashMap<String, Object>> priorityList = (ArrayList<HashMap<String, Object>>) paramMap
					.get("ref_cursor");

			for (int i = 0; i < priorityList.size(); i++) {
				if (Integer.parseInt(priorityList.get(i).get("PRIORITY").toString()) != (i + 1)) {
					paramMap.put("bseq", Integer.parseInt(priorityList.get(i).get("BSEQ").toString()));
					paramMap.put("priority", i + 1);

					adao.updateBannerPriority(paramMap);
				}
			}

		} catch (Exception e) {
			result = false;
			throw new RuntimeException();
		}

		return result;
	}

	public void updateBanner(int bseq, int priority, String uri, String useyn) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bseq", bseq);
		paramMap.put("uri", uri);
		paramMap.put("useyn", useyn);
		
		//priority가 없으면 부여
		if(priority != 0) {
			paramMap.put("priority", priority);
		} else {
			paramMap.put("maxpriority", 0);

			adao.getMaxPriority(paramMap);
			// useyn이 Y이면 priority 최대 값 + 1
			paramMap.put("priority", useyn.equals("N") ? 0 : (Integer.parseInt(paramMap.get("maxpriority").toString()) + 1));
		}

		adao.updateBanner(paramMap);
	}

	public int getBannerMaxPriority() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		// useyn이 Y이면 priority 최대 값 + 1

		paramMap.put("maxpriority", 0);

		adao.getMaxPriority(paramMap);
		
		return Integer.parseInt(paramMap.get("maxpriority").toString());
	}

	@Transactional(rollbackFor = { RuntimeException.class, Error.class })
	public boolean swapBannerPriority(int priority, String swapTo) {
		boolean result = true;
		
		try {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("ref_cursor", null);

			adao.getBannerPriorityList(paramMap);

			ArrayList<HashMap<String, Object>> priorityList = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			//Integer.parseInt(priorityList.get(priority).get("BSEQ").toString()); // raise 일 경우 교체되는 배너의 bseq
			//Integer.parseInt(priorityList.get(priority - 2).get("BSEQ").toString()); // lower 일 경우 교체되는 배너의 bseq
			//Integer.parseInt(priorityList.get(priority - 1).get("BSEQ").toString()); //이동하는 배너의 bseq
			if(swapTo.equals("raise")) {
				paramMap.put("bseq", Integer.parseInt(priorityList.get(priority - 1).get("BSEQ").toString()));
				paramMap.put("priority", priority - 1);
				
				adao.updateBannerPriority(paramMap);
				
				paramMap.put("bseq", Integer.parseInt(priorityList.get(priority -2).get("BSEQ").toString()));
				paramMap.put("priority", priority);
				
				adao.updateBannerPriority(paramMap);
				
			} else if(swapTo.equals("lower")) {
				paramMap.put("bseq", Integer.parseInt(priorityList.get(priority - 1).get("BSEQ").toString()));
				paramMap.put("priority", priority + 1);
				
				adao.updateBannerPriority(paramMap);
				
				paramMap.put("bseq", Integer.parseInt(priorityList.get(priority).get("BSEQ").toString()));
				paramMap.put("priority", priority);
				
				adao.updateBannerPriority(paramMap);
			}
			
		} catch (Exception e) {
			result = false;
			throw new RuntimeException();
		}

		return result;
		
	}

}
