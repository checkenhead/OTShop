package ot.team1.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		paramMap.put("rfcursor2", null);
		
		cs.listQna( paramMap );
		cs.getQnaCatList(paramMap);
		
		mav.addObject("qnaList" , paramMap.get("rfcursor") );
		mav.addObject("qnaCat", paramMap.get("rfcursor2"));
		mav.setViewName("customer/qnaListForm");
		
		System.out.println("REFCURSOR : " + paramMap.get("rfcursor"));
		System.out.println("REFCURSOR2 : " + paramMap.get("rfcursor2"));
		
		return mav;
		
	}
	
	
	@GetMapping("/qnaView")
	public ModelAndView qnaView(
			@RequestParam("qseq") int qseq ) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qseq", qseq);
		paramMap.put("rfcursor", null);
		paramMap.put("rfcursor2", null);
		
		cs.getQna(paramMap);
		cs.getQnaCatListUser(paramMap);
		
		ArrayList<HashMap<String, Object> > list =
				(ArrayList<HashMap<String, Object> >)paramMap.get("rfcursor");
		
		ArrayList<HashMap<String, Object> > list2 =
				(ArrayList<HashMap<String, Object> >)paramMap.get("rfcursor2");
		
		mav.addObject("qnaVO", list.get(0) );
		mav.addObject("qnaCAT", list2.get(0));
		
		System.out.println("REFCURSOR : " + paramMap.get("rfcursor"));
		System.out.println("REFCURSOR2 : " + paramMap.get("rfcursor2"));
		
		mav.setViewName("customer/qnaViewForm");
		
		return mav;
	}

}
