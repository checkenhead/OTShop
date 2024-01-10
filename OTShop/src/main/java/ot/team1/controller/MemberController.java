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
import ot.team1.dto.PwdFindVO;
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
            url = "redirect:/";
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
   
   
   // joinForm에서 submit 클릭 후 validation
   @PostMapping("/join")
   public String join(
         @ModelAttribute("mdto") @Valid MemberVO membervo,
         BindingResult mresult,
         @ModelAttribute("pfdto") @Valid PwdFindVO pwdfindvo,
         BindingResult pfresult,
         @RequestParam(value="reid", required=false) String reid,
         @RequestParam(value="repwd", required=false) String repwd,
         Model model ) {
      
      String url = "member/joinForm";

      
      // validation 결과가 담긴 result에서 userid의 error가 있다면
      if(mresult.getFieldError("userid") != null )
         model.addAttribute("message", mresult.getFieldError("userid").getDefaultMessage() );
      else if( reid == null || ( !reid.equals(membervo.getUserid() ) ) )
         model.addAttribute("message", "아이디 중복확인이 되지 않았습니다." );
      else if( mresult.getFieldError("pwd") != null )
         model.addAttribute("message", mresult.getFieldError("pwd").getDefaultMessage() );
      else if( repwd == null || repwd.equals("") )
    	  model.addAttribute("message", "비밀번호 확인을 입력하세요.");
      else if( !repwd.equals(membervo.getPwd() ) )
          model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다." );
      else if( pwdfindvo.getKind() == null || pwdfindvo.getKind().isEmpty() ||
    		  pwdfindvo.getKind().equals("null") || pwdfindvo.getKind().equals("0") )
    	  model.addAttribute("message", "비밀번호 질문을 선택하세요" );
      else if( pfresult.getFieldError("answer") != null )
    	  model.addAttribute("message", pfresult.getFieldError("answer").getDefaultMessage() );
      else if( mresult.getFieldError("name") != null )
         model.addAttribute("message", mresult.getFieldError("name").getDefaultMessage() );
      else if( mresult.getFieldError("gender") != null )
         model.addAttribute("message", mresult.getFieldError("gender").getDefaultMessage() );
      else if( mresult.getFieldError("tel") != null )
          model.addAttribute("message", mresult.getFieldError("tel").getDefaultMessage() );
      else if( mresult.getFieldError("email") != null )
          model.addAttribute("message", mresult.getFieldError("email").getDefaultMessage() );
      else if( membervo.getBirthdate() == null || 
    		  membervo.getBirthdate().isEmpty() ||
    		  membervo.getBirthdate().equals("null")) {
    	  
    	  model.addAttribute("message", "생년월일을 선택하세요." );
      }
      else {
    	  
    	  // HashMap에 데이터 추가
          HashMap<String, Object> paramMap = new HashMap<>();
          
          paramMap.put("userid", membervo.getUserid());
          paramMap.put("pwd", membervo.getPwd());
          paramMap.put("kind", pwdfindvo.getKind());
          paramMap.put("answer", pwdfindvo.getAnswer());
          paramMap.put("name", membervo.getName());
          paramMap.put("gender", membervo.getGender());
          paramMap.put("birthdate", membervo.getBirthdate());
          paramMap.put("tel", membervo.getTel());
          paramMap.put("email", membervo.getEmail());
          paramMap.put("zipnum", membervo.getZipnum());
          paramMap.put("address1", membervo.getAddress1());
          paramMap.put("address2", membervo.getAddress2());
          paramMap.put("address3", membervo.getAddress3());
          paramMap.put("provider", membervo.getProvider());
          

          // 회원 추가 메서드 호출
          ms.insertMember(paramMap);

          model.addAttribute("message", "환영합니다! 로그인 후 이용해주세요.");
          url = "member/login";
      }
      return url;
   }
   
   // ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 아이디 / 비밀번호 찾기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
   
   @GetMapping("/findAcc")
   public String findAcc() {
	   return "member/findAcc";
   }
   
   
   @GetMapping("/findId")
   public ModelAndView findId(
	         @RequestParam("name") String name,
	         @RequestParam("email") String email) {
	      
	      ModelAndView mav = new ModelAndView();
	      
	      HashMap<String, Object> paramMap = new HashMap<String, Object>();
	      paramMap.put("name", name);
	      paramMap.put("email", email);
	      paramMap.put("rfcursor", null);
	      
	      
	      
	      ms.findId(paramMap);
	      String userid = (String) paramMap.get("userid");
	      
	      // DB에 해당 name과 email이 일치하는 값이 없을 때
	      if( userid == null ) mav.addObject("result", -1);
	      
	      // DB에 해당 name과 email이 일치하는 값이 있을 때
	      else mav.addObject("result", 1);	
	      
	      mav.addObject("userid", userid);
	      mav.addObject("name", name);
	      mav.addObject("email", email);
	      
	      mav.setViewName("member/findId");
	      
	      return mav;
	   }
   
   
   @PostMapping("/findPwd")
   public ModelAndView findPwd(
	         @RequestParam("userid") String userid,
	         @RequestParam("kind") String kind,
	         @RequestParam("answer") String answer) {
	      
	      ModelAndView mav = new ModelAndView();
	      
	      String userAnswer = answer;
	      
	      HashMap<String, Object> paramMap = new HashMap<String, Object>();
	      paramMap.put("userid", userid);
	      paramMap.put("kind", kind);
	      paramMap.put("answer", answer);
	      
	      
	      ms.findPwd(paramMap);
	      String pwd = (String) paramMap.get("pwd");
	      
	      // DB에 해당 name과 email이 일치하는 값이 없을 때
	      if( pwd == null ) mav.addObject("result", -1);
	      
	      // 사용자 입력 답변과 DB 답변이 일치하지 않을 때
	      else if( !userAnswer.equals( paramMap.get("answer") ) ) 
	    	  mav.addObject("result", 2);
	      
	      else mav.addObject("result", 1);	
	      
	      mav.addObject("pwd", pwd);
	      mav.addObject("userid", userid);
	      mav.addObject("kind", kind);
	      mav.addObject("answer", answer);
	      
	      mav.setViewName("member/findPwd");
	      
	      return mav;
	   }
   
   
   // ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
   
   
   @GetMapping("/medit")
   public ModelAndView memberEditForm(HttpServletRequest request) {
	   
	   ModelAndView mav = new ModelAndView();
	   
	   // 정보수정 폼으로 넘어갈때 loginUser의 데이터를 가지고 갈 객체
	   MemberVO dto = new MemberVO();
	   
	   // session에 있는 "loginUser" 값을 가져와 loginUser에 저장
	   HttpSession session = request.getSession();
	   HashMap<String, Object> loginUser = 
			   (HashMap<String, Object>) session.getAttribute("loginUser");
	   
	   // Object이므로 String으로 형변환
	   dto.setUserid( (String)loginUser.get("USERID") );
	   dto.setName( (String)loginUser.get("NAME") );
	   dto.setGender( (String)loginUser.get("GENDER") );
	   dto.setBirthdate( (String)loginUser.get("BIRTHDATE") );
	   dto.setTel( (String)loginUser.get("TEL") );
	   dto.setEmail( (String)loginUser.get("EMAIL") );
	   dto.setZipnum( (String)loginUser.get("ZIPNUM") );
	   dto.setAddress1( (String)loginUser.get("ADDRESS1") );
	   dto.setAddress2( (String)loginUser.get("ADDRESS2") );
	   dto.setAddress3( (String)loginUser.get("ADDRESS3") );
	   dto.setProvider( (String)loginUser.get("PROVIDER") );
	   
	   mav.addObject("dto", dto);
	   
	   mav.setViewName("member/mupdate");
	   return mav;
   }
   
   
   @PostMapping("/mupdate")
   public String mupdate(
		   HttpServletRequest request,
		   @ModelAttribute("dto") @Valid MemberVO membervo,
		   BindingResult result,
		   @RequestParam(value="repwd", required=false) String repwd,
		   Model model) {
	   
	   String url = "member/mupdate";
	   
	   if( result.getFieldError("pwd") != null )
		   model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage() );
	   else if( result.getFieldError("name") != null )
		   model.addAttribute("message", result.getFieldError("name").getDefaultMessage() );
	   else if( result.getFieldError("gender") != null )
		   model.addAttribute("message", result.getFieldError("gender").getDefaultMessage() );
	   else if( result.getFieldError("tel") != null )
		   model.addAttribute("message", result.getFieldError("tel").getDefaultMessage() );
	   else if( result.getFieldError("name") != null )
		   model.addAttribute("message", result.getFieldError("name").getDefaultMessage() );
	   else if( result.getFieldError("email") != null )
		   model.addAttribute("message", result.getFieldError("email").getDefaultMessage() );
	   else if( repwd == null || ( !repwd.equals(membervo.getPwd() ) ) )
		   model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다.");
	   // 오류가 없다면 DB에 데이터 전송
	   else {
		   
		   HashMap<String, Object> paramMap = new HashMap<String, Object>();
		  
		   // paramMap에 HashMap 형태로 데이터 저장
		   paramMap.put("USERID", membervo.getUserid());
		   paramMap.put("PWD", membervo.getPwd());
		   paramMap.put("NAME", membervo.getName());
		   paramMap.put("GENDER", membervo.getGender());
		   paramMap.put("BIRTHDATE", membervo.getBirthdate());
		   paramMap.put("TEL", membervo.getTel());
		   paramMap.put("EMAIL", membervo.getEmail());
		   paramMap.put("ZIPNUM", membervo.getZipnum());
		   paramMap.put("ADDRESS1", membervo.getAddress1());
		   paramMap.put("ADDRESS2", membervo.getAddress2());
		   paramMap.put("ADDRESS3", membervo.getAddress3());
		   paramMap.put("PROVIDER", membervo.getProvider());
		   
		   // DB에 paramMap에 저장된 데이터로 정보 업데이트 시킬 메서드
		   ms.updateMember(paramMap);
		   
		   // session 객체 생성 후 session에 수정된 데이터로 로그인된 유저의 정보값을 세팅
		   HttpSession session = request.getSession();
		   session.setAttribute("loginUser", paramMap);
		   
		   url = "redirect:/";
	   }
	   return url;
   }
   
   
   @GetMapping("/mdeleteForm")
   public String mdeleteForm(
		   HttpServletRequest request,
		   Model model ) {
	   
	   HttpSession session = request.getSession();
	   
	   Object loginUser = session.getAttribute("loginUser");
	   
	   if( loginUser == null ) return "member/login";
	   else {
		   HashMap<String, Object> paramMap = (HashMap<String, Object>) loginUser;
		   model.addAttribute("userid", paramMap.get("userid"));
	   }
	   
	   return "member/mdeleteForm";
   }
   
   
   @PostMapping("/mdelete")
   public String mdelete(
		   HttpServletRequest request,
		   Model model) {
	   
	   HttpSession session = request.getSession();
	   HashMap<String, Object> mvo = 
			   (HashMap<String, Object>) session.getAttribute("loginUser");
	   
	   String userid = (String)mvo.get("USERID");
	   HashMap<String, Object> paramMap = new HashMap<String, Object>();
	   paramMap.put("userid", userid);
	   
	   ms.deleteMember(paramMap);
	   
	   return "member/completeDelete";
   }









}