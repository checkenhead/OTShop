package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {

	void getAdmin(HashMap<String, Object> paramMap);

}
