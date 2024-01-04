package ot.team1.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import ot.team1.dto.MemberVO;
import ot.team1.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService ms;
	
	
	@GetMapping("/loginForm")
	public String loginForm() {
		return "member/login";
	}

	
	@PostMapping("/login")
	public String login(
			@ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result,
			HttpServletRequest request, Model model) {
		
		String url = "member/login";
		
		if(result.getFieldError("userid") != null )
			model.addAttribute( "message", result.getFieldError("userid").getDefaultMessage() );
		else if(result.getFieldError("pwd") != null )
			model.addAttribute( "message", result.getFieldError("pwd").getDefaultMessage() );
		else {
			HashMap<String, Object> paramMap  = new HashMap<String, Object>();
			paramMap.put( "userid", membervo.getUserid() );
			paramMap.put("ref_cs", null);
			
			//ms.getMember(paramMap);
			// 해당 메서드는 DB에서 꺼내온 데이터를 ref_cs에 저장한다 
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cs");
			// ref_cs에 저장된 데이터를 꺼내 list에 저장한다
			
			
			if( list==null || list.size()==0 ) {
				model.addAttribute("message", "아이디가 없습니다. 회원가입 후 로그인하세요.");
				return "member/login";
			}
			// 조회 결과가 있을 경우(= 아이디가 있는 경우) list의 첫번째 데이터를 가져와 memberMap에 저장
			HashMap<String, Object> memberMap = list.get(0);
			
			if( memberMap.get("USEYN").equals("N") )
				model.addAttribute("message", "탈퇴한 회원입니다. 관리자에게 문의하세요.");
			else if( !memberMap.get("PWD").equals(membervo.getPwd() ) )
				model.addAttribute("message", "비밀번호가 틀렸습니다. 다시 시도하세요.");
			else if( memberMap.get("PWD").equals(membervo.getPwd() ) ) {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", memberMap);
				url = "redirect:/";
			}

		}
		return url;
	}
	
	
}