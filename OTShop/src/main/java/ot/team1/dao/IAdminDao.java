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

}