package ot.team1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import ot.team1.service.LogisService;


@Controller
public class LogisController {
	
	@Autowired
	LogisService ls;
	
	
	@GetMapping("/logisLogin")
	public String logisMain() {
		return "logis/common/logisLoginForm";
	}
	
	
	@GetMapping("/logisMain")
	public String logis() {
		return "logis/common/logisMainForm";
	}
	
	
	@PostMapping("/logisLogin")
	public String logisLogin(
			@RequestParam("logisid") String logisid,
			@RequestParam("pwd") String pwd,
			HttpServletRequest request,
			Model model) {
		
		String url = "logis/common/logisLoginForm";
		
		model.addAttribute("logisid", logisid);
		
		if( logisid == null || logisid.equals("") )
			model.addAttribute("message", "아이디를 입력하세요.");
		else if( pwd == null || pwd.equals("") )
			model.addAttribute("message", "비밀번호를 입력하세요.");
		else {
			
			HashMap<String, Object> loginLogis = ls.getLogis(logisid);
			
			if( loginLogis == null ) {
				model.addAttribute("message", "등록된 아이디가 없습니다.");
			}else if( !loginLogis.get("PWD").equals(pwd) ) {
				model.addAttribute("message", "비밀번호가 맞지 않습니다.");
			}else {
				request.getSession().setAttribute("loginLogis", loginLogis);
				url = "redirect:/logisMain";
			}
		}
		return url;
	}
	


}
