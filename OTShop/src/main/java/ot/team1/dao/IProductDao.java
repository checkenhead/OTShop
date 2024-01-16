package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IProductDao {

	public void getMainCatSetList(HashMap<String, Object> paramMap);

	public void getSubCatSetList(HashMap<String, Object> paramMap);
	
	public void getProductList(HashMap<String, Object> paramMap);

	public void getProductDetailList(HashMap<String, Object> paramMap);

	public void getProductMainCatList(HashMap<String, Object> paramMap);
	
	public void getProductSubCatList(HashMap<String, Object> paramMap);
	
	public void getProduct(HashMap<String, Object> paramMap);

	public void getProductListByPmcseq(HashMap<String, Object> paramMap);

	public void getProductListByPscseq(HashMap<String, Object> paramMap);
}
