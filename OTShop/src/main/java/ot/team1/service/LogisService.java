package ot.team1.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.ILogisDao;

@Service
public class LogisService {
	
	@Autowired
	ILogisDao ldao;

}
