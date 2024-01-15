package ot.team1.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.ICustomerDao;

@Service
public class CustomerService {
	
	@Autowired
	ICustomerDao cdao;

	public void listQna(HashMap<String, Object> paramMap) {
		cdao.listQna(paramMap);
	}

	public void getQnaCatList(HashMap<String, Object> paramMap) {
		cdao.getQnaCatList(paramMap);
		
	}

}
