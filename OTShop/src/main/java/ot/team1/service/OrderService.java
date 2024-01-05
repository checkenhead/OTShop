package ot.team1.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.IOrderDao;

@Service
public class OrderService {
	
	@Autowired
	IOrderDao odao;

}
