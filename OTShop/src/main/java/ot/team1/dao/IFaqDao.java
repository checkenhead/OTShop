package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IFaqDao {

	void listFaq(HashMap<String, Object> paramMap);

}
