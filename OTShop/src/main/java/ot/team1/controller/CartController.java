package ot.team1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import ot.team1.service.CartService;

@Controller
public class CartController {
	@Autowired
	CartService cs;

	@GetMapping("/cartList")
	public String cartList(HttpServletRequest request, Model model) {
		// 로그인 체크
		HashMap<String, Object> loginUser = (HashMap<String, Object>) request.getSession().getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/loginForm";
		} else {
			// 로그인 아이디의 cartList 조회
			model.addAttribute("cartList", cs.getCartList((String)loginUser.get("USERID")));

			return "mypage/cartList";
		}
	}

	@PostMapping("/insertCart")
	public String insertCart(
			@RequestParam(value = "pdseq", required = false) int[] pdseq,
			@RequestParam(value = "qty", required = false) int[] qty,
			HttpServletRequest request, Model model) {
		// 로그인 체크
		HashMap<String, Object> loginUser = (HashMap<String, Object>) request.getSession().getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/loginForm";
		} else {
			// 로그인 아이디의 cartList 조회
			// model.addAttribute("cartList", cs.getCartList(loginUser.get("USERID")));
			
			cs.insertCart((String)loginUser.get("USERID"), pdseq, qty);
			
			return "mypage/cartList";
		}
	}
}
