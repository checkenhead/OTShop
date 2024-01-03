package ot.team1.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import ot.team1.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	AdminService as;

	@Autowired
	ServletContext context;

	@GetMapping("/adminMain")
	public String adminMain() {
		return "redirect:/productManagement";
	}

	@GetMapping("/productManagement")
	public String productManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";			
		}
		else {
			model.addAttribute("productList", as.getProductList());
			
			
			
			
			return "admin/product/productManagement";
		}
	}

	@GetMapping("/adminLoginForm")
	public String adminLoginForm() {
		return "admin/common/adminLoginForm";
	}

	@PostMapping("/adminLogin")
	public String adminLogin(@RequestParam("adminid") String adminid, @RequestParam("pwd") String pwd,
			HttpServletRequest request, Model model) {
		String url = "admin/common/adminLoginForm";

		model.addAttribute("adminid", adminid);

		if (adminid == null || adminid.equals(""))
			model.addAttribute("message", "아이디를 입력하세요.");
		else if (pwd == null || pwd.equals("")) {
			model.addAttribute("message", "비밀번호를 입력하세요.");
		} else {
			HashMap<String, Object> loginAdmin = as.getAdmin(adminid);

			if (loginAdmin == null) {
				model.addAttribute("message", "아이디가 없습니다.");
			} else if (!loginAdmin.get("PWD").equals(pwd)) {
				model.addAttribute("message", "비밀번호가 틀립니다.");
			} else {
				request.getSession().setAttribute("loginAdmin", loginAdmin);
				url = "redirect:/adminMain";
			}
		}

		return url;
	}

	@GetMapping("/insertProductForm")
	public String insertProductForm(HttpServletRequest request, Model model) {
		if (request.getSession().getAttribute("loginAdmin") == null)
			return "redirect:/adminLoginForm";
		else {
			// product_category 테이블 select값 model에 저장
			model.addAttribute("productCatList", as.getProductCatList());

			return "admin/product/insertProductForm";
		}
	}

	@PostMapping("/changeOption")
	public String changeOption(
			@RequestParam(value = "productCategory", defaultValue = "0") int pcseq,
			@RequestParam("gender") String gender, @RequestParam("brand") String brand,
			@RequestParam("name") String name, @RequestParam("description") String description,
			@RequestParam("optname") String[] optname, @RequestParam(value = "image", required = false) String image,
			@RequestParam("previewFilename") String previewFilename,
			@RequestParam(value = "price1", required = false) int[] price1,
			@RequestParam(value = "price2", required = false) int[] price2,
			@RequestParam(value = "price3", required = false) int[] price3,
			@RequestParam(value = "stock", required = false) int[] stock,
			@RequestParam(value = "delIndex", defaultValue = "0") int delIndex, Model model) {

		ArrayList<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();

		// delIndex : 삭제할 인덱스, -1한 값이 실제 삭제할 index이고 따라서 delIndex가 0일 경우 삭제하지 않음
		// String[] option : 기존 추가된 옵션 + 방금 추가한 옵션의 이름
		// price1, 2, 3 : 기존 추가된 price, 따라서 맨 처음 추가 시 null이고 다음부터는 option배열보다 length가 1
		// 작음

		// option배열과 price배열을 vo객체에 넣고 리스트로 구성, 방금 추가된 option의 price들은 0을 대입
		for (int i = 0; i < optname.length; i++) {
			if ((delIndex - 1) == i || optname[i].equals("")) { // 삭제할 index가 있는 경우와 빈값인 경우 skip
				continue;
			} else {
				HashMap<String, Object> optvo = new HashMap<String, Object>();
				optvo.put("optname", optname[i]);
				// price가 null인 경우 : 맨 처음 추가 시
				// price배열의 크기는 option배열의 크기보다 1 작으므로 length 체크 후 default 대입
				optvo.put("price1", (price1 == null) || (price1.length <= i) ? 0 : price1[i]);
				optvo.put("price2", (price2 == null) || (price2.length <= i) ? 0 : price2[i]);
				optvo.put("price3", (price3 == null) || (price3.length <= i) ? 0 : price3[i]);
				optvo.put("stock", (stock == null) || (stock.length <= i) ? 0 : stock[i]);
				optionList.add(optvo);
			}
		}
		model.addAttribute("productCatList", as.getProductCatList());
		model.addAttribute("productCategory", pcseq);
		model.addAttribute("gender", gender);
		model.addAttribute("brand", brand);
		model.addAttribute("name", name);
		model.addAttribute("description", description);
		model.addAttribute("image", image);
		model.addAttribute("previewFilename", previewFilename);
		model.addAttribute("optionList", optionList);

		return "admin/product/insertProductForm";
	}

	@PostMapping("/fileup")
	@ResponseBody
	public HashMap<String, Object> fileup(@RequestParam("upload") MultipartFile file, HttpServletRequest request,
			Model model) {

		String path = context.getRealPath("/images/product");

		Calendar today = Calendar.getInstance();
		long t = today.getTimeInMillis();

		String filename = file.getOriginalFilename();
		String fn1 = filename.substring(0, filename.indexOf("."));
		String fn2 = filename.substring(filename.indexOf("."));
		String uploadPath = path + "/" + fn1 + t + fn2;

		System.out.println("경로 : " + uploadPath);

		HashMap<String, Object> result = new HashMap<String, Object>();

		try {
			file.transferTo(new File(uploadPath));
			result.put("STATUS", 1);
			result.put("FILENAME", fn1 + t + fn2);
		} catch (IllegalStateException e) {
			e.printStackTrace();
			result.put("STATUS", 0);
		} catch (IOException e) {
			e.printStackTrace();
			result.put("STATUS", 0);
		}

		return result;
	}

	@PostMapping("/insertProduct")
	public String insertProduct(@RequestParam(value = "productCategory", defaultValue = "0") int pcseq,
			@RequestParam("gender") String gender, @RequestParam("brand") String brand,
			@RequestParam("name") String name, @RequestParam("description") String description,
			@RequestParam("optname") String[] optname, @RequestParam(value = "image", required = false) String image,
			@RequestParam("previewFilename") String previewFilename,
			@RequestParam(value = "price1", required = false) int[] price1,
			@RequestParam(value = "price2", required = false) int[] price2,
			@RequestParam(value = "price3", required = false) int[] price3,
			@RequestParam(value = "stock", required = false) int[] stock, HttpServletRequest request, Model model) {
		if (request.getSession().getAttribute("loginAdmin") == null)
			return "redirect:/adminLoginForm";
		else {
			boolean validationSucess = true;
			
			//validation 실패 시 가져갈 입력 데이터 model에 저장
			ArrayList<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();
			if(stock != null) {
				for (int i = 0; i < stock.length; i++) {
					HashMap<String, Object> optvo = new HashMap<String, Object>();
					optvo.put("optname", optname[i]);
					optvo.put("price1", (price1 == null) || (price1.length <= i) ? 0 : price1[i]);
					optvo.put("price2", (price2 == null) || (price2.length <= i) ? 0 : price2[i]);
					optvo.put("price3", (price3 == null) || (price3.length <= i) ? 0 : price3[i]);
					optvo.put("stock", (stock == null) || (stock.length <= i) ? 0 : stock[i]);
					optionList.add(optvo);
				}
			}

			model.addAttribute("productCatList", as.getProductCatList());
			model.addAttribute("pcseq", pcseq);
			model.addAttribute("gender", gender);
			model.addAttribute("brand", brand);
			model.addAttribute("name", name);
			model.addAttribute("description", description);
			model.addAttribute("image", image);
			model.addAttribute("previewFilename", previewFilename);
			model.addAttribute("optionList", optionList);
			
			//validation
			if(pcseq == 0) {
				model.addAttribute("message", "상품분류를 선택하세요.");
				validationSucess = false;
			} else if(brand.equals("")) {
				model.addAttribute("message", "브랜드를 입력하세요.");
				validationSucess = false;
			} else if(name.equals("")) {
				model.addAttribute("message", "상품이름을 입력하세요.");
				validationSucess = false;
			} else if(description.equals("")) {
				model.addAttribute("message", "상품설명을 입력하세요.");
				validationSucess = false;
			} else if(image == null || image.equals("")) {
				model.addAttribute("message", "상품사진이 없습니다.");
				validationSucess = false;
			} else {
				//option은 1개 이상 있을 것
				//price는 0이 아닐 것
				if(stock == null || stock.length < 1) {
					model.addAttribute("message", "상품 옵션은 1개 이상 있어야합니다.");
					validationSucess = false;
				} else {
					for(int i = 0; i < stock.length; i++) {
						if(price1[i] == 0 || price2[i] == 0 || price3[i] == 0) {
							model.addAttribute("message", "상품 가격을 입력하세요.");
							validationSucess = false;
							break;
						}
					}
				}
			}
			
			if(!validationSucess) {
				return "admin/product/insertProductForm";
			} else {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				
				paramMap.put("pcseq", pcseq);
				paramMap.put("brand", brand);
				paramMap.put("gender", gender);
				paramMap.put("name", name);
				paramMap.put("description", description);
				paramMap.put("image", image);
				paramMap.put("optionList", optionList);
				
				as.insertProduct(paramMap);
				
				return "redirect:/productManagement";
			}
				
		}
	}
}
