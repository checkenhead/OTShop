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
<<<<<<< HEAD

=======
>>>>>>> branch 'master' of https://github.com/checkenhead/OTShop.git

@Controller
public class LogisController {
	
	@Autowired
	LogisService ls;
	
<<<<<<< HEAD
	
=======
>>>>>>> branch 'master' of https://github.com/checkenhead/OTShop.git
	@GetMapping("/logisLogin")
	public String logisMain() {
		return "logis/common/logisLoginForm";
	}
	
	
	@GetMapping("/logisMain")
	public String logis(HttpServletRequest request, Model model) {
		if (request.getSession().getAttribute("loginLogis") == null) {
			return "redirect:/logisLogin";
		} else {
			//invoiceVO model에 저장
			model.addAttribute("invoiceList", ls.getAllInvoiceList());
			
			return "logis/common/logisMainForm";
		}
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
	
	/* AdminController에서 LogisService 메서드 호출로 변경
	@PostMapping("/requestCollect")
	public String requestCollect(
			@RequestParam("clientid") String clientid,
			@RequestParam("ordernum") int ordernum,
			@RequestParam("recipient") String recipient,
			@RequestParam("tel") String tel,
			@RequestParam("zipnum") String zipnum,
			@RequestParam("address1") String address1,
			@RequestParam("address2") String address2,
			@RequestParam("address3") String address3,
			@RequestParam("redirectURL") String redirectURL) {
		
		ls.insertInvoice(clientid, ordernum, recipient, tel, zipnum, address1, address2, address3);
		
		return redirectURL;
	}
	*/
	/* AdminController에서 LogisService 메서드 호출로 변경
	@PostMapping("/getInvoiceStateByIseq")
	public String getInvoiceStateByIseq(
			@RequestParam("invoicenum") int iseq,
			@RequestParam("redirectURL") String redirectURL) {
		
		ls.getInvoiceStateByIseq(iseq);
		
		return redirectURL;
	}
	*/
	@PostMapping("/startTransport")
	public String startTransport(
			@RequestParam("iseq") int iseq,
			HttpServletRequest request,
			Model model) {
		HashMap<String, Object> loginLogis = (HashMap<String, Object>) request.getSession().getAttribute("loginLogis");
		if (loginLogis == null) {
			return "redirect:/logisLogin";
		} else {
			ls.insertTransport(iseq, (String)loginLogis.get("LOGISID"), "집화 시작");
			ls.updateInvoiceState(iseq, "2");
			
			return "redirect:/logisMain";
		}
	}
	
	@GetMapping("/transportList")
	public String transportList(HttpServletRequest request, Model model) {
		HashMap<String, Object> loginLogis = (HashMap<String, Object>) request.getSession().getAttribute("loginLogis");
		if (loginLogis == null) {
			return "redirect:/logisLogin";
		} else {
			//로그인 아이디의 transportList 저장
			model.addAttribute("invoiceList", ls.getTransportListByInvoice((String)loginLogis.get("LOGISID")));
			
			return "logis/common/transportList";
		}
	}
	
	
}
