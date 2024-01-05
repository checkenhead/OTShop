package ot.team1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import ot.team1.service.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	OrderService os;
	
	
	@GetMapping("/myPage")
	public String mypage(
			HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser =
				(HashMap<String, Object>) session.getAttribute("loginUser");
		
		if(loginUser == null ) return "member/login";
		else return "mypage/mypage";
		
	}

}
