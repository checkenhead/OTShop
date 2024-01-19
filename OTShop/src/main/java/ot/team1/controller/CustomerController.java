package ot.team1.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
	
	
	@GetMapping("/userCheckForm")
	public ModelAndView userCheckForm(
			@RequestParam("qseq") int qseq,
			@RequestParam("userid") String userid) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("qseq", qseq);
		mav.addObject("userid", userid);
		
		mav.setViewName("customer/userCheckForm");
		return mav;
		
	}
	
	
	@PostMapping("/userCheckSucc")
	public String userCheckSucc(
			HttpServletRequest request,
			Model model,
			@RequestParam("qseq") int qseq,
			@RequestParam("userid") String userid) {
		
		HttpSession session = request.getSession();
		
		Object loginUser = session.getAttribute("loginUser");
		System.out.println("loginUser : " + loginUser);
		
		if( loginUser == null ) {
			model.addAttribute("message", "접근 권한이 없습니다. 로그인 후 다시 시도하세요.");
			model.addAttribute("result", 1);
		} else if( !((HashMap<String, Object>) loginUser).get("USERID").equals(userid) ) {
			model.addAttribute("message", "접근 권한이 없습니다.");
			model.addAttribute("result", 2);
		} else {
			model.addAttribute("qseq", qseq);
			model.addAttribute("userid", userid);
			model.addAttribute("message", "작성자 확인 성공. 게시글로 이동합니다.");
			model.addAttribute("result", 3);
		}
		
		return "customer/userCheckSuccess";
	}
	
	
	@GetMapping("/qnaWriteForm")
	public ModelAndView qnaWriteForm(
			HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>) session.getAttribute("loginUser");
		
		if(loginUser == null) mav.setViewName("member/login");
		else {
			Object userid =  loginUser.get("USERID");
			System.out.println("userid : " + userid);
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("rfcursor2", null);
			
			cs.getQnaCatList(paramMap);
			
			ArrayList<HashMap<String, Object> > list2 =
					(ArrayList<HashMap<String, Object> >)paramMap.get("rfcursor2");
			
			mav.addObject("userid", userid);
			mav.addObject("qnaCat", paramMap.get("rfcursor2"));
			
			mav.setViewName("customer/qnaWriteForm");
		}
		return mav;
	}
	
	
	@PostMapping("/qnaWrite")
	public ModelAndView qnaWrite(
			HttpServletRequest request,
			@RequestParam(value="qnaname") int qnaname,
			@RequestParam(value="secret", required=false, defaultValue="N") String secret,
			@RequestParam(value="title") String title,
			@RequestParam(value="content") String content,
			Model model) {
		
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>) session.getAttribute("loginUser");
		
		if(loginUser == null)
			mav.setViewName("member/login");
		else {
			
			System.out.println("qnaname(QCSEQ) : " + qnaname);
			
			if(title == null || title.equals("")) {
				model.addAttribute("message", "※ 제목을 입력해주세요.");
				mav.setViewName("customer/qnaWriteForm");
			}else if(content == null || content.equals("")) {
				model.addAttribute("message", "※ 내용을 입력하세요.");
				mav.setViewName("customer/qnaWriteForm");
			}else {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userid", loginUser.get("USERID"));
				paramMap.put("secret", secret);
				paramMap.put("qcseq", qnaname);
				paramMap.put("title", title);
				paramMap.put("content", content);
				
				cs.insertQna(paramMap);
				
				mav.setViewName("redirect:/qnaList");
			}
		}
		return mav;
	}
	
	
	@GetMapping("/introCompany")
	public String introCompany() {
		return "customer/introCompanyFrm";
	}
	
	
	@GetMapping("/shopMap")
	public String shopMap() {
		return "customer/shopMapFrm";
	}
	

}
