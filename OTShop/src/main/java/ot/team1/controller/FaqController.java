package ot.team1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import ot.team1.service.FaqService;

@Controller
public class FaqController {
	
	@Autowired
	FaqService fs;
	
	
	@GetMapping("/faqList")
	public ModelAndView faqList(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("rfcursor", null);
		
		fs.listFaq(paramMap);
		
		mav.addObject("faqList", paramMap.get("rfcursor"));
		
		mav.setViewName("faq/faqListForm");
		return mav;
	}
	

}
