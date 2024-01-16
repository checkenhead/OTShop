package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICartDao {

	void getCartList(HashMap<String, Object> paramMap);

	void insertCart(HashMap<String, Object> paramMap);

}
