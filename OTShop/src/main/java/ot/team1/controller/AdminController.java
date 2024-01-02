package ot.team1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import ot.team1.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	AdminService as;
	
	@GetMapping("/adminMain")
	public String adminMain() {
		return "redirect:/productManagement";
	}
	
	@GetMapping("/productManagement")
	public String productManagement(HttpServletRequest request) {
		//로그인 체크	
		if(request.getSession().getAttribute("loginAdmin") == null)
			return "redirect:/adminLoginForm";
		else
			return "admin/product/productManagement";
	}
	
	@GetMapping("/adminLoginForm")
	public String adminLoginForm() {
		return "admin/common/adminLoginForm";
	}
	
	@PostMapping("/adminLogin")
	public String adminLogin(
			@RequestParam("adminid") String adminid,
			@RequestParam("pwd") String pwd,
			HttpServletRequest request,
			Model model) {
		String url = "admin/common/adminLoginForm";
		
		model.addAttribute("adminid", adminid);
		
		if(adminid == null || adminid.equals(""))
			model.addAttribute("message", "아이디를 입력하세요.");
		else if(pwd == null || pwd.equals("")) {
			model.addAttribute("message", "비밀번호를 입력하세요.");
		} else {
			HashMap<String, Object> loginAdmin = as.getAdmin(adminid);
			
			if(loginAdmin == null) {
				model.addAttribute("message", "아이디가 없습니다.");
			} else if(!loginAdmin.get("PWD").equals(pwd)) {
				model.addAttribute("message", "비밀번호가 틀립니다.");
			} else {
				request.getSession().setAttribute("loginAdmin", loginAdmin);
				url = "redirect:/adminMain";
			}
		}
		
		return url;
	}
}
