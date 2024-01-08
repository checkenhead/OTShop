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

}