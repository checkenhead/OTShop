package ot.team1.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.IFaqDao;

@Service
public class FaqService {

	@Autowired
	IFaqDao fdao;

	public void listFaq(HashMap<String, Object> paramMap) {
		fdao.listFaq(paramMap);
		
	}
}
