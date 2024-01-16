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
		model.addAttribute("mainCategorySetList", ps.getCatSetList());
		
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
		model.addAttribute("mainCategorySetList", ps.getCatSetList());
		
		//상품 저장
		model.addAttribute("productVO", ps.getProduct(pseq));
		
		return "product/viewProduct";
	}
	
	@GetMapping("/searchProduct")
	public String searchProduct(
			@RequestParam(value = "pmcseq", defaultValue = "0") int pmcseq,
			@RequestParam(value = "pscseq", defaultValue = "0") int pscseq,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			Model model) {
		//서브메뉴의 카테고리 리스트
		model.addAttribute("mainCategorySetList", ps.getCatSetList());
		
		//검색
		if(pmcseq != 0 || pscseq != 0)
			model.addAttribute("productList", ps.getProductListByCat(pmcseq, pscseq));
		else
			model.addAttribute("productList", ps.getProductList(keyword));
		
		return "index";
	}
}
