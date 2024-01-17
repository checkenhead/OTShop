package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ILogisDao {

	public void getLogis(HashMap<String, Object> paramMap);
	
	

}
