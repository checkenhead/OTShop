package ot.team1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import ot.team1.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	ProductService ps;
	
	@GetMapping("/")
	public String main(HttpServletRequest request, Model model) {
		//서브메뉴의 카테고리 리스트
		model.addAttribute("mainCategoryList", ps.getCatSetList());
		
		//메인페이지 제품 리스트
		model.addAttribute("productList", ps.getProductList(""));
		
		//배너
		
		return "index";
	}
	
	@GetMapping("/viewProduct")
	public String viewProduct(
			@RequestParam("pseq") int pseq,
			Model model) {
		//서브메뉴의 카테고리 리스트
		model.addAttribute("mainCategoryList", ps.getCatSetList());
		
		//상품 저장
		model.addAttribute("productVO", ps.getProduct(pseq));
		
		return "product/viewProduct";
	}
}
