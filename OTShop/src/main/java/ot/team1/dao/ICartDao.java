package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICartDao {

	void getCartList(HashMap<String, Object> paramMap);

	void insertCart(HashMap<String, Object> paramMap);

	void deleteCart(HashMap<String, Object> paramMap);

	void insertOrders(HashMap<String, Object> paramMap);

	void getCart(HashMap<String, Object> paramMap);

	void insertOrderDetail(HashMap<String, Object> paramMap);

}
