package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {

	public void getAdmin(HashMap<String, Object> paramMap);

	public void getProductCatList(HashMap<String, Object> paramMap);

	public void insertProduct(HashMap<String, Object> paramMap);

	public void insertProductDetail(HashMap<String, Object> ovo);

	public void getProductList(HashMap<String, Object> paramMap);

	public void getProductDetailList(HashMap<String, Object> paramMap);

	public String getCount(HashMap<String, Object> paramMap);

	public void insertProductCat(HashMap<String, Object> paramMap);

	public void deleteProductCat(HashMap<String, Object> paramMap);

	public void updateProductCat(HashMap<String, Object> paramMap);

	public void getProduct(HashMap<String, Object> paramMap);

	public void updateProduct(HashMap<String, Object> paramMap);

	public void updateProductDetail(HashMap<String, Object> ovo);

	public void getFaqList(HashMap<String, Object> paramMap);

	public void getFaqCatList(HashMap<String, Object> paramMap);

	public void insertFaqCat(HashMap<String, Object> paramMap);

	public void deleteFaqCat(HashMap<String, Object> paramMap);

	public void updateFaqCat(HashMap<String, Object> paramMap);

	public void insertFaq(HashMap<String, Object> paramMap);

	public void updateFaq(HashMap<String, Object> paramMap);

	public void deleteFaq(HashMap<String, Object> paramMap);

	public void getMemberList(HashMap<String, Object> paramMap);

	public void changeMemberUseyn(HashMap<String, Object> paramMap);

	public void getQnaList(HashMap<String, Object> paramMap);

	public void getQnaCatList(HashMap<String, Object> paramMap);

	public void insertQnaCat(HashMap<String, Object> paramMap);

	public void deleteQnaCat(HashMap<String, Object> paramMap);

	public void updateQnaCat(HashMap<String, Object> paramMap);

	public void getQna(HashMap<String, Object> paramMap);

	public void updateQnaReply(HashMap<String, Object> paramMap);

	public void deleteQna(HashMap<String, Object> paramMap);

	public void insertBannerImage(HashMap<String, Object> paramMap);

	public void getBannerImageList(HashMap<String, Object> paramMap);

	public void deleteBannerImage(HashMap<String, Object> paramMap);

	public void getImageByBiseq(HashMap<String, Object> paramMap);

	public void insertBanner(HashMap<String, Object> paramMap);

	public void getBannerList(HashMap<String, Object> paramMap);

	public void deleteBanner(HashMap<String, Object> paramMap);

	public void updateBanner(HashMap<String, Object> paramMap);

	public void getMaxPriority(HashMap<String, Object> paramMap);

	public void getBannerPriorityList(HashMap<String, Object> paramMap);

	public void updateBannerPriority(HashMap<String, Object> paramMap);

	public void getMainCatList(HashMap<String, Object> paramMap);

	public void getSubCatList(HashMap<String, Object> paramMap);

}