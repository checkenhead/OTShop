package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICustomerDao {

	void listQna(HashMap<String, Object> paramMap);
	
	

}
