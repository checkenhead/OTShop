package ot.team1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.ServletContext;
import ot.team1.service.LogisService;
import ot.team1.service.ProductService;

@Controller
public class LogisController {
	
	@Autowired
	LogisService ls;
	
	@Autowired
	ProductService ps;
	
	@Autowired
	ServletContext context;
	
	
	@GetMapping("/logisMain")
	public String logisMain() {
		return "logis/common/logisLoginForm";
	}

}
