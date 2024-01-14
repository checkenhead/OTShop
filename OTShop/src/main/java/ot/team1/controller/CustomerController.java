package ot.team1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import ot.team1.service.CustomerService;

@Controller
public class CustomerController {
	
	@Autowired
	CustomerService cs;
	
	
	
	@GetMapping("/qnaList")
	public ModelAndView qnaList(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("rfcursor", null);
		
		cs.listQna( paramMap );
		
		mav.addObject("qnaList" , paramMap.get("rfcurosr") );
		mav.setViewName("customer/qnaListForm");
		
		return mav;
		
	}

}
