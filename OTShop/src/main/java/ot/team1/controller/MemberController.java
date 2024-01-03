package ot.team1.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import ot.team1.dto.KakaoProfile;
import ot.team1.dto.KakaoProfile.KakaoAccount;
import ot.team1.dto.KakaoProfile.KakaoAccount.Profile;
import ot.team1.dto.MemberVO;
import ot.team1.dto.OAuthToken;
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
	public String login( @ModelAttribute("dto") @Valid MemberVO membervo,
		BindingResult result, HttpServletRequest request, Model model ) {
		
		String url = "member/login";
		
		if( result.getFieldError("userid") != null )
			model.addAttribute("message", result.getFieldError("userid").getDefaultMessage() );
		else if( result.getFieldError("pwd") != null )
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage() );
		else {
			// paramMap 변수에 userid와 비어있는 rfcursor를 보냄
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put( "userid", membervo.getUserid() );
			paramMap.put( "rfcursor", null );
			
			// 해당 메서드는 DB에서 꺼내온 데이터를 rfcursor에 저장한다
			ms.getMember(paramMap);
			
			// rfcursor에 저장된 데이터를 꺼내 list에 저장한다
			ArrayList<HashMap<String, Object>> list =
					(ArrayList<HashMap<String, Object>>) paramMap.get("rfcursor");
			
			if( list==null || list.size()==0 ) {
				model.addAttribute("message", "아이디가 없습니다");
				return "member/login";
			}
			
			// 조회 결과가 있을 경우(= 아이디가 있는 경우) list의 첫번째 데이터를 가져와 memberMap에 저장
			HashMap<String, Object> memberMap = list.get(0);
			
			if( memberMap.get("USEYN").equals("N") )
				model.addAttribute("message", "탈퇴한 회원입니다. 관리자에게 문의하세요.");
			else if( !memberMap.get("PWD").equals(membervo.getPwd() ) )
				model.addAttribute("message", "비밀번호가 틀렸습니다. 다시 입력하세요.");
			// 정상 로그인일 경우
			else if( memberMap.get("PWD").equals(membervo.getPwd() ) ) {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", memberMap);
				return url = "redirect:/";
			}
		}
		return url;
	}
	
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 카카오 로그인 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// kakaodeveloper의 MyBoard 로 설정해뒀음
	@GetMapping("/kakaostart")
	public @ResponseBody String kakaostart() {
		String a = "<script type='text/javascript'>" 
				+ "location.href='https://kauth.kakao.com/oauth/authorize?"
				+ "client_id=904cba975ef71bec9a2a57539968e40a" 
				+ "&redirect_uri=http://localhost:8070/kakaoLogin"
				+ "&response_type=code';" 
				+ "</script>";
		return a;
	}
	
	@RequestMapping("/kakaoLogin")
	public String loginKakao(HttpServletRequest request) throws UnsupportedEncodingException, IOException{
		
		String code = request.getParameter("code");
		String endpoint = "https://kauth.kakao.com/oauth/token";
		URL url = new URL(endpoint); // import java.net.URL;
		String bodyData = "grant_type=authorization_code&";
		bodyData += "client_id=904cba975ef71bec9a2a57539968e40a&";
		bodyData += "redirect_uri=http://localhost:8070/kakaoLogin&";
		bodyData += "code=" + code;
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // import java.net.HttpURLConnection;
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		conn.setDoOutput(true);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
		bw.write(bodyData);
		bw.flush();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		String input = "";
		StringBuilder sb = new StringBuilder(); // 조각난 String 을 조립하기위한 객체
		while ((input = br.readLine()) != null) {
			sb.append(input);
			System.out.println(input); // 수신된 토큰을 콘솔에 출력합니다
		}
		Gson gson = new Gson();
		OAuthToken oAuthToken = gson.fromJson(sb.toString(), OAuthToken.class);
		String endpoint2 = "https://kapi.kakao.com/v2/user/me";
		URL url2 = new URL(endpoint2);
		
		HttpsURLConnection conn2 = (HttpsURLConnection) url2.openConnection();
		conn2.setRequestProperty("Authorization", "Bearer " + oAuthToken.getAccess_token());
		conn2.setDoOutput(true);
		BufferedReader br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
		String input2 = "";
		StringBuilder sb2 = new StringBuilder();
		while ((input2 = br2.readLine()) != null) {
			sb2.append(input2);
			System.out.println(input2);
		}
		
		Gson gson2 = new Gson();
		KakaoProfile kakaoProfile = gson2.fromJson(sb2.toString(), KakaoProfile.class);
		KakaoAccount ac = kakaoProfile.getAccount();
		Profile pf = ac.getProfile();
		
		// 회원 가입 및 로그인 정보 세션 저장
		HashMap< String, Object > paramMap = new HashMap< String, Object >();
		paramMap.put("userid", kakaoProfile.getId() );
		paramMap.put("rfcursor", null );
		ms.getMember( paramMap );
		
		ArrayList< HashMap<String, Object> > list 
		= (ArrayList< HashMap<String, Object> >) paramMap.get("rfcursor" );
		
		if ( list == null || list.size() == 0 ) {
			
			paramMap.put("userid", kakaoProfile.getId() );
			paramMap.put("email" , "kakao");
			paramMap.put("name" , pf.getNickname());
			paramMap.put("provider" , "kakao");
			paramMap.put("tel" , "kakao");
			
			ms.joinKakao( paramMap );
			
			// 회원 가입한 내역을 아이디로 다시 조회
			paramMap.put("rfcursor", null );
			ms.getMember( paramMap );
			list = (ArrayList< HashMap<String, Object> >) paramMap.get("rfcursor" );			
		}
		// 세션에 로그인 정보 저장
		HashMap<String , Object> memberMap = list.get(0);
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", memberMap);
		return "redirect:/";
	}
	
// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 카카오 로그인 끝 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

	@GetMapping("/contract")
	public String contract() {
		return "member/contract";
	}
	
	// 이용약관 동의 매핑
	@RequestMapping("useContract")
	public String useContract() {
		return "member/contract/UseContract";
	}
	
	// 개인정보수집 동의 매핑
	@RequestMapping("infoContract")
	public String infoContract() {
		return "member/contract/InfoContract";
	}
	

	@PostMapping("/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	
	
	@GetMapping("/idCheckForm")
	public ModelAndView idCheckForm(
			@RequestParam("userid") String userid) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userid", userid);
		paramMap.put("rfcursor", null);
		
		ms.getMember(paramMap);
		
		ArrayList<HashMap<String, Object>> list =
				(ArrayList<HashMap<String, Object>>) paramMap.get("rfcursor");
		
		// 사용자가 입력한 아이디가 사용 가능일 때 (DB에 똑같은 userid가 없을 때) 
		if( list == null || list.size() ==0 ) mav.addObject("result", -1);
		// 사용자가 입력한 아이디가 사용 불가일 때 (DB에 똑같은 userid가 있을 때) 
		else mav.addObject("result", 1);
		
		mav.addObject("userid", userid);
		mav.setViewName("member/idcheck");
		
		return mav;
	}
	
	
	// joinForm에서 submit 버튼 클릭 후 validation
	@PostMapping("/join")
	public String join(
			@ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result,
			@RequestParam(value="reid", required=false) String reid,
			@RequestParam(value="repwd", required=false) String repwd,
			Model model ) {
		
		String url = "member/joinForm";
		
		// validation 결과가 담긴 result에서 userid의 error가 있다면
		if( result.getFieldError("userid") != null )
			model.addAttribute("message", result.getFieldError("userid").getDefaultMessage() );
		else if( reid == null || ( !reid.equals(membervo.getUserid() ) ) )
			model.addAttribute("message", "아이디 중복확인이 되지 않았습니다." );
		else if( repwd == null || ( !repwd.equals(membervo.getPwd() ) ) )
			model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다." );
		else if( result.getFieldError("pwd") != null )
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage() );
		else if( result.getFieldError("name") != null )
			model.addAttribute("message", result.getFieldError("name").getDefaultMessage() );
		else if( result.getFieldError("gender") != null )
			model.addAttribute("message", result.getFieldError("gender").getDefaultMessage() );
		else if( result.getFieldError("birthdate") != null )
			model.addAttribute("message", result.getFieldError("birthdate").getDefaultMessage() );
		else if( result.getFieldError("tel") != null )
			model.addAttribute("message", result.getFieldError("tel").getDefaultMessage() );
		else if( result.getFieldError("email") != null )
			model.addAttribute("message", result.getFieldError("email").getDefaultMessage() );

	
	}
	
	
	
	
	
	
	
}
