package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICustomerDao {

	void listQna(HashMap<String, Object> paramMap);

	void getQnaCatList(HashMap<String, Object> paramMap);

	void getQna(HashMap<String, Object> paramMap);

	void getQnaCatListUser(HashMap<String, Object> paramMap);

	void insertQna(HashMap<String, Object> paramMap);
	
	

}
