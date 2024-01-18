package ot.team1.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
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
		} else {
			model.addAttribute("productList", as.getProductList(""));

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

	@GetMapping("/adminLogout")
	public String adminLogout(HttpServletRequest request) {
		request.getSession().removeAttribute("loginAdmin");

		return "admin/common/adminLoginForm";
	}

	@GetMapping("/insertProductForm")
	public String insertProductForm(HttpServletRequest request, Model model) {
		if (request.getSession().getAttribute("loginAdmin") == null)
			return "redirect:/adminLoginForm";
		else {
			model.addAttribute("mainCatList", as.getAllProductCatList("main"));
			model.addAttribute("subCatList", as.getAllProductCatList("sub"));

			return "admin/product/insertProductForm";
		}
	}

	@PostMapping("/changeOption")
	public String changeOption(@RequestParam(value = "pseq", defaultValue = "0") int pseq,
			@RequestParam(value = "mainCat", defaultValue = "0") int[] mainCat,
			@RequestParam(value = "subCat", defaultValue = "0") int[] subCat,
			@RequestParam("gender") String gender,
			@RequestParam("brand") String brand, @RequestParam("name") String name,
			@RequestParam("description") String description, @RequestParam("optname") String[] optname,
			@RequestParam(value = "image", required = false) String image,
			@RequestParam("previewFilename") String previewFilename,
			@RequestParam(value = "price1", required = false) int[] price1,
			@RequestParam(value = "price2", required = false) int[] price2,
			@RequestParam(value = "price3", required = false) int[] price3,
			@RequestParam(value = "stock", required = false) int[] stock,
			@RequestParam(value = "regdate", required = false) Timestamp regdate,
			@RequestParam(value = "bestyn", required = false) String bestyn,
			@RequestParam(value = "useyn", required = false) String useyn,
			@RequestParam(value = "viewcount", defaultValue = "0") int viewcount,
			@RequestParam(value = "optUseyn", required = false) String[] optUseyn,
			@RequestParam(value = "pdseq", required = false) int[] pdseq,
			@RequestParam(value = "delIndex", defaultValue = "0") int delIndex,
			@RequestParam("formName") String formName, Model model) {

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
				HashMap<String, Object> ovo = new HashMap<String, Object>();
				ovo.put("OPTNAME", optname[i]);
				// price가 null인 경우 : 맨 처음 추가 시
				// price배열의 크기는 option배열의 크기보다 1 작으므로 length 체크 후 default 대입
				ovo.put("PDSEQ", (pdseq == null) || (pdseq.length <= i) ? 0 : pdseq[i]);
				ovo.put("PRICE1", (price1 == null) || (price1.length <= i) ? 0 : price1[i]);
				ovo.put("PRICE2", (price2 == null) || (price2.length <= i) ? 0 : price2[i]);
				ovo.put("PRICE3", (price3 == null) || (price3.length <= i) ? 0 : price3[i]);
				ovo.put("STOCK", (stock == null) || (stock.length <= i) ? 0 : stock[i]);
				ovo.put("USEYN", (optUseyn == null) || (optUseyn.length <= i) ? "Y" : optUseyn[i]);
				optionList.add(ovo);
			}
		}
		
		HashMap<String, Object> productVO = new HashMap<String, Object>();
		
		productVO.put("PSEQ", pseq);
		productVO.put("GENDER", gender);
		productVO.put("BRAND", brand);
		productVO.put("NAME", name);
		productVO.put("DESCRIPTION", description);
		productVO.put("IMAGE", image);
		productVO.put("REGDATE", regdate);
		productVO.put("BESTYN", bestyn);
		productVO.put("USEYN", useyn);
		productVO.put("VIEWCOUNT", viewcount);
		productVO.put("optionList", optionList);
		
		if(mainCat != null && mainCat.length != 0 && mainCat[0] != 0) {
			ArrayList<HashMap<String, Object>> mainSelectedCatList = new ArrayList<HashMap<String, Object>>();
			
			for(int i : mainCat) {
				HashMap<String, Object> mainSelectedCat = new HashMap<String, Object>();
				
				mainSelectedCat.put("PMCSEQ", i);
				mainSelectedCatList.add(mainSelectedCat);
			}
			
			model.addAttribute("mainSelectedCatList", mainSelectedCatList);
		}
		
		if(subCat != null && subCat.length != 0 && subCat[0] != 0) {
			ArrayList<HashMap<String, Object>> subSelectedCatList = new ArrayList<HashMap<String, Object>>();
			
			for(int i : subCat) {
				HashMap<String, Object> subSelectedCat = new HashMap<String, Object>();
				
				subSelectedCat.put("PSCSEQ", i);
				subSelectedCatList.add(subSelectedCat);
			}
			
			model.addAttribute("subSelectedCatList", subSelectedCatList);
		}
		
		model.addAttribute("mainCatList", as.getAllProductCatList("main"));
		model.addAttribute("subCatList", as.getAllProductCatList("sub"));
		model.addAttribute("productVO", productVO);
		model.addAttribute("previewFilename", previewFilename);

		if (formName.equals("insertProductForm"))
			return "admin/product/insertProductForm";
		else if (formName.equals("updateProductForm"))
			return "admin/product/updateProductForm";
		else
			return "";
	}

	@PostMapping("/fileup")
	@ResponseBody
	public HashMap<String, Object> fileup(@RequestParam("upload") MultipartFile file, @RequestParam("path") String path,
			HttpServletRequest request, Model model) {

		System.out.println("path : " + path);

		String realPath = context.getRealPath(path);

		Calendar today = Calendar.getInstance();
		long t = today.getTimeInMillis();

		String filename = file.getOriginalFilename();
		String fn1 = filename.substring(0, filename.indexOf("."));
		String fn2 = filename.substring(filename.indexOf("."));
		String uploadPath = realPath + fn1 + t + fn2;

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
	public String insertProduct(
			//@RequestParam(value = "pseq", defaultValue = "0") int pseq,
			@RequestParam(value = "mainCat", defaultValue = "0") int[] mainCat,
			@RequestParam(value = "subCat", defaultValue = "0") int[] subCat,
			@RequestParam("gender") String gender,
			@RequestParam("brand") String brand, @RequestParam("name") String name,
			@RequestParam("description") String description, @RequestParam("optname") String[] optname,
			@RequestParam(value = "image", required = false) String image,
			@RequestParam("previewFilename") String previewFilename,
			@RequestParam(value = "bestyn", required = false) String bestyn,
			@RequestParam(value = "useyn", required = false) String useyn,
			@RequestParam(value = "viewcount", defaultValue = "0") int viewcount,
			@RequestParam(value = "regdate", required = false) Timestamp regdate,
			@RequestParam(value = "price1", required = false) int[] price1,
			@RequestParam(value = "price2", required = false) int[] price2,
			@RequestParam(value = "price3", required = false) int[] price3,
			@RequestParam(value = "stock", required = false) int[] stock, HttpServletRequest request, Model model) {
		if (request.getSession().getAttribute("loginAdmin") == null)
			return "redirect:/adminLoginForm";
		else {
			boolean validationSucess = true;
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			//paramMap.put("PSEQ", pseq);
			paramMap.put("GENDER", gender);
			paramMap.put("BRAND", brand);
			paramMap.put("NAME", name);
			paramMap.put("DESCRIPTION", description);
			paramMap.put("IMAGE", image);
			paramMap.put("BESTYN", bestyn);
			paramMap.put("USEYN", useyn);
			paramMap.put("REGDATE", regdate);
			paramMap.put("VIEWCOUNT", viewcount);

			ArrayList<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();
			
			// validation 실패 시 가져갈 입력 데이터 model에 저장
			if (stock != null) {
				for (int i = 0; i < stock.length; i++) {
					HashMap<String, Object> vo = new HashMap<String, Object>();
					vo.put("OPTNAME", optname[i]);
					vo.put("PRICE1", (price1 == null) || (price1.length <= i) ? 0 : price1[i]);
					vo.put("PRICE2", (price2 == null) || (price2.length <= i) ? 0 : price2[i]);
					vo.put("PRICE3", (price3 == null) || (price3.length <= i) ? 0 : price3[i]);
					vo.put("STOCK", (stock == null) || (stock.length <= i) ? 0 : stock[i]);
					optionList.add(vo);
				}
			}

			paramMap.put("optionList", optionList);
			
			
			ArrayList<HashMap<String, Object>> pmcseqList = new ArrayList<HashMap<String, Object>>();
			ArrayList<HashMap<String, Object>> pscseqList = new ArrayList<HashMap<String, Object>>();
			
			for(int i : mainCat) {
				HashMap<String, Object> vo = new HashMap<String, Object>();
				vo.put("PMCSEQ", i);
				pmcseqList.add(vo);
			}
			
			for(int i : subCat) {
				HashMap<String, Object> vo = new HashMap<String, Object>();
				vo.put("PSCSEQ", i);
				pscseqList.add(vo);
			}
			
			paramMap.put("pmcseqList", pmcseqList);
			paramMap.put("pscseqList", pscseqList);			

			model.addAttribute("mainCatList", as.getAllProductCatList("main"));
			model.addAttribute("subCatList", as.getAllProductCatList("sub"));
			model.addAttribute("mainSelectedCatList", mainCat);
			model.addAttribute("subSelectedCatList", subCat);
			model.addAttribute("productVO", paramMap);

			// validation
			if(mainCat == null || mainCat.length == 0 || mainCat[0] == 0) {
				model.addAttribute("message", "메인 카테고리를 입력하세요.");
				validationSucess = false;
			} else if(subCat == null || subCat.length == 0 || subCat[0] == 0) {
				model.addAttribute("message", "서브 카테고리를 입력하세요.");
				validationSucess = false;
			} else if (brand.equals("")) {
				model.addAttribute("message", "브랜드를 입력하세요.");
				validationSucess = false;
			} else if (name.equals("")) {
				model.addAttribute("message", "상품이름을 입력하세요.");
				validationSucess = false;
			} else if (description.equals("")) {
				model.addAttribute("message", "상품설명을 입력하세요.");
				validationSucess = false;
			} else if (image == null || image.equals("")) {
				model.addAttribute("message", "상품사진이 없습니다.");
				validationSucess = false;
			} else {
				// option은 1개 이상 있을 것
				// price는 0이 아닐 것
				if (stock == null || stock.length < 1) {
					model.addAttribute("message", "상품 옵션은 1개 이상 있어야합니다.");
					validationSucess = false;
				} else {
					for (int i = 0; i < stock.length; i++) {
						if (price1[i] == 0 || price2[i] == 0) {
							model.addAttribute("message", "상품 가격을 입력하세요.");
							validationSucess = false;
							break;
						}
					}
				}
			}

			if (!validationSucess) {
				return "admin/product/insertProductForm";
			} else {
				if (as.insertProduct(paramMap)) {
					// insert 성공 시
					return "redirect:/productManagement";
				} else {
					// insert 실패 시
					model.addAttribute("message", "DB insert 실패, 관리자에게 문의하세요.");
					return "admin/product/insertProductForm";
				}
			}

		}
	}

	@PostMapping("/searchProduct")
	public String searchProduct(@RequestParam("keyword") String keyword, HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			model.addAttribute("keyword", keyword);
			model.addAttribute("productList", as.getProductList(keyword));

			return "admin/product/productManagement";
		}
	}
	
	/* 상품 카테고리 변경
	@GetMapping("/productCatManagement")
	public String productCatManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			// 모든 Category 리스트 저장, 각 카테고리별 등록된 상품 수 저장
			model.addAttribute("productCatList", as.getProductCatListwithCount());

			return "admin/product/productCatManagement";
		}
	}
	*/
	
	@GetMapping("/productCatManagement")
	public String productCatManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			// 모든 Category 리스트 저장, 각 카테고리별 등록된 상품 수 저장
			model.addAttribute("mainCatList", as.getAllProductCatList("main"));
			model.addAttribute("subCatList", as.getAllProductCatList("sub"));
			model.addAttribute("categorySetList", as.getCategorySetList());
			
			return "admin/product/productCatManagement";
		}
	}
	
	@GetMapping("/productMainCategory")
	public String productMainCategory(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			// 모든 Category 리스트 저장, 각 카테고리별 등록된 상품 수 저장
			model.addAttribute("mainCatList", as.getProductCatListwithCount("main"));

			return "admin/product/productMainCategory";
		}
	}
	
	@GetMapping("/productSubCategory")
	public String productSubCategory(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			// 모든 Category 리스트 저장, 각 카테고리별 등록된 상품 수 저장
			model.addAttribute("subCatList", as.getProductCatListwithCount("sub"));

			return "admin/product/productSubCategory";
		}
	}
	
	
	/* 상품 카테고리 변경
	@PostMapping("/insertProductCat")
	public String insertProductCat(@RequestParam("name") String name, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertProductCat(name);

			return "redirect:/productCatManagement";
		}
	}
	*/
	
	@PostMapping("/insertProductCat")
	public String insertProductCat(
			@RequestParam("categoryClass") String categoryClass,
			@RequestParam("name") String name,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertProductCat(categoryClass, name);
			
			if(categoryClass.equals("main"))
				return "redirect:/productMainCategory";
			else if(categoryClass.equals("sub"))
				return "redirect:/productSubCategory";
			else return "";
		}
	}

	@PostMapping("/deleteProductCat")
	public String deleteProductCat(
			@RequestParam("categoryClass") String categoryClass,
			@RequestParam(value = "index", defaultValue = "0") int index,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.deleteProductCat(categoryClass, index);

			if(categoryClass.equals("main"))
				return "redirect:/productMainCategory";
			else if(categoryClass.equals("sub"))
				return "redirect:/productSubCategory";
			else return "";
		}
	}

	@PostMapping("/updateProductCat")
	public String updateProductCat(
			@RequestParam("categoryClass") String categoryClass,
			@RequestParam(value = "index", defaultValue = "0") int index,
			@RequestParam("name") String name,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.updateProductCat(categoryClass, index, name);

			if(categoryClass.equals("main"))
				return "redirect:/productMainCategory";
			else if(categoryClass.equals("sub"))
				return "redirect:/productSubCategory";
			else return "";
		}
	}
	
	@PostMapping("/insertProductCatSet")
	public String insertProductCatSet(
			@RequestParam(value = "pmcseq", defaultValue = "0") int pmcseq,
			@RequestParam(value = "pscseq", defaultValue = "0") int[] pscseq,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertProductCatSet(pmcseq, pscseq);

			return "redirect:/productCatManagement";
		}
	}
	
	@PostMapping("/updateProductCatSet")
	public String updateProductCatSet(
			@RequestParam("categoryClass") String categoryClass,
			@RequestParam("index") int index,
			@RequestParam("value") int value,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.updateProductCatSet(categoryClass, index, value);

			return "redirect:/productCatManagement";
		}
	}
	
	@PostMapping("/deleteProductCatSet")
	public String deleteProductCatSet(
			@RequestParam("categoryClass") String categoryClass,
			@RequestParam("index") int index,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.deleteProductCatSet(categoryClass, index);

			return "redirect:/productCatManagement";
		}
	}
	
	
	@PostMapping("/updateProductForm")
	public String updateProductForm(@RequestParam(value = "pseq", defaultValue = "0") int pseq,
			HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			if (pseq == 0)
				System.out.println("Error : pseq값이 0입니다.");
			else {
				model.addAttribute("mainCatList", as.getAllProductCatList("main"));
				model.addAttribute("subCatList", as.getAllProductCatList("sub"));
				model.addAttribute("mainSelectedCatList", as.getProductMainCatList(pseq));
				model.addAttribute("subSelectedCatList", as.getProductSubCatList(pseq));
				model.addAttribute("productVO", as.getProduct(pseq));
			}

			return "admin/product/updateProductForm";
		}
	}

	@PostMapping("/updateProduct")
	public String updateProduct(
			@RequestParam(value = "pseq", defaultValue = "0") int pseq,
			@RequestParam(value = "mainCat", defaultValue = "0") int[] mainCat,
			@RequestParam(value = "subCat", defaultValue = "0") int[] subCat,
			@RequestParam("gender") String gender,
			@RequestParam("brand") String brand, @RequestParam("name") String name,
			@RequestParam("description") String description,
			@RequestParam(value = "image", required = false) String image,
			@RequestParam(value = "bestyn", required = false) String bestyn,
			@RequestParam(value = "useyn", required = false) String useyn,
			@RequestParam(value = "regdate", required = false) Timestamp regdate,
			@RequestParam(value = "viewcount", defaultValue = "0") int viewcount,
			@RequestParam(value = "pdseq", required = false) int[] pdseq, @RequestParam("optname") String[] optname,
			@RequestParam(value = "price1", required = false) int[] price1,
			@RequestParam(value = "price2", required = false) int[] price2,
			@RequestParam(value = "price3", required = false) int[] price3,
			@RequestParam(value = "stock", required = false) int[] stock,
			@RequestParam(value = "store", required = false) int[] store,
			@RequestParam(value = "optUseyn", required = false) String[] optUseyn, HttpServletRequest request,
			Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			boolean validationSucess = true;

			// 1. product의 데이터는 update
			// 2. product_detail의 데이터는 update:기존 데이터(pdseq != 0)/insert:추가 데이터(pdseq == 0)
			// 3. adminViewProduct로 이동

			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			ArrayList<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();

			paramMap.put("PSEQ", pseq);
			paramMap.put("GENDER", gender);
			paramMap.put("BRAND", brand);
			paramMap.put("NAME", name);
			paramMap.put("DESCRIPTION", description);
			paramMap.put("IMAGE", image);
			paramMap.put("BESTYN", bestyn);
			paramMap.put("USEYN", useyn);
			paramMap.put("REGDATE", regdate);
			paramMap.put("VIEWCOUNT", viewcount);

			for (int i = 0; i < pdseq.length; i++) {
				HashMap<String, Object> vo = new HashMap<String, Object>();
				
				vo.put("PSEQ", pseq);
				vo.put("PDSEQ", pdseq[i]);
				vo.put("OPTNAME", optname[i]);
				vo.put("PRICE1", price1[i]);
				vo.put("PRICE2", price2[i]);
				vo.put("PRICE3", price3[i]);
				vo.put("STOCK", stock[i]);
				vo.put("STORE", store[i]);
				vo.put("USEYN", optUseyn[i]);
				optionList.add(vo);
			}

			paramMap.put("optionList", optionList);
			
			ArrayList<HashMap<String, Object>> pmcseqList = new ArrayList<HashMap<String, Object>>();
			ArrayList<HashMap<String, Object>> pscseqList = new ArrayList<HashMap<String, Object>>();
			
			for(int i : mainCat) {
				HashMap<String, Object> vo = new HashMap<String, Object>();
				vo.put("PSEQ", pseq);
				vo.put("PMCSEQ", i);
				pmcseqList.add(vo);
			}
			
			for(int i : subCat) {
				HashMap<String, Object> vo = new HashMap<String, Object>();
				vo.put("PSEQ", pseq);
				vo.put("PSCSEQ", i);
				pscseqList.add(vo);
			}
			
			paramMap.put("pmcseqList", pmcseqList);
			paramMap.put("pscseqList", pscseqList);	

			model.addAttribute("mainCatList", as.getAllProductCatList("main"));
			model.addAttribute("subCatList", as.getAllProductCatList("sub"));
			model.addAttribute("mainSelectedCatList", pmcseqList);
			model.addAttribute("subSelectedCatList", pscseqList);
			model.addAttribute("productVO", paramMap);
			
			if(mainCat == null || mainCat.length == 0 || mainCat[0] == 0) {
				model.addAttribute("message", "메인 카테고리를 입력하세요.");
				validationSucess = false;
			} else if(subCat == null || subCat.length == 0 || subCat[0] == 0) {
				model.addAttribute("message", "서브 카테고리를 입력하세요.");
				validationSucess = false;
			} else if (brand.equals("")) {
				model.addAttribute("message", "브랜드를 입력하세요.");
				validationSucess = false;
			} else if (name.equals("")) {
				model.addAttribute("message", "상품이름을 입력하세요.");
				validationSucess = false;
			} else if (description.equals("")) {
				model.addAttribute("message", "상품설명을 입력하세요.");
				validationSucess = false;
			} else {
				for (int i = 0; i < pdseq.length; i++) {
					if (price1[i] == 0 || price2[i] == 0) {
						model.addAttribute("message", "상품 가격을 입력하세요.");
						validationSucess = false;
						break;
					} else if (stock[i] + store[i] < 0) {
						model.addAttribute("message", "재고는 0미만일 수 없습니다.");
						validationSucess = false;
						break;
					}
				}
			}

			// validation
			if (!validationSucess) {
				return "admin/product/updateProductForm";
			} else {
				if (as.updateProduct(paramMap)) {
					// insert 성공 시
					return "redirect:/adminViewProduct?pseq=" + pseq;
				} else {
					// insert 실패 시
					model.addAttribute("message", "DB update 실패, 관리자에게 문의하세요.");
					return "admin/product/updateProductForm";
				}
			}
		}

	}

	@GetMapping("/adminViewProduct")
	public String adminViewProduct(@RequestParam(value = "pseq", defaultValue = "0") int pseq,
			HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			if (pseq == 0)
				System.out.println("Error : pseq값이 0입니다.");
			else {
				model.addAttribute("mainCatList", as.getAllProductCatList("main"));
				model.addAttribute("subCatList", as.getAllProductCatList("sub"));
				model.addAttribute("mainSelectedCatList", as.getProductMainCatList(pseq));
				model.addAttribute("subSelectedCatList", as.getProductSubCatList(pseq));
				model.addAttribute("productVO", as.getProduct(pseq));
			}

			return "admin/product/adminViewProduct";
		}
	}

	@GetMapping("/memberManagement")
	public String memberManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			model.addAttribute("memberList", as.getMemberList());

			return "admin/member/memberManagement";
		}
	}

	@PostMapping("/changeMemberUseyn")
	public String changeMemberUseyn(@RequestParam("userid") String userid, @RequestParam("useyn") String useyn,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.changeMemberUseyn(userid, useyn.equals("Y") ? "N" : "Y");

			return "redirect:/memberManagement";
		}
	}

	@GetMapping("/faqManagement")
	public String faqManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			model.addAttribute("faqCatList", as.getFaqCatList());
			model.addAttribute("faqList", as.getFaqList());

			return "admin/faq/faqManagement";
		}
	}

	@GetMapping("/faqCatManagement")
	public String faqCatManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			// 모든 Category 리스트 저장, 각 카테고리별 등록된 상품 수 저장
			model.addAttribute("faqCatList", as.getFaqCatListwithCount());

			return "admin/faq/faqCatManagement";
		}
	}

	@PostMapping("/insertFaqCat")
	public String insertFaqCat(@RequestParam("name") String name, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertFaqCat(name);

			return "redirect:/faqCatManagement";
		}
	}

	@PostMapping("/deleteFaqCat")
	public String deleteFaqCat(@RequestParam(value = "fcseq", defaultValue = "0") int fcseq,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			if (fcseq == 0)
				System.out.println("Error : fcseq값이 0입니다.");
			else
				as.deleteFaqCat(fcseq);

			return "redirect:/faqCatManagement";
		}
	}

	@PostMapping("/updateFaqCat")
	public String updateFaqCat(@RequestParam(value = "fcseq", defaultValue = "0") int fcseq,
			@RequestParam("name") String name, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			if (fcseq == 0)
				System.out.println("Error : fcseq값이 0입니다.");
			else
				as.updateFaqCat(fcseq, name);

			return "redirect:/faqCatManagement";
		}
	}

	@PostMapping("/insertFaq")
	public String insertFaq(@RequestParam("fcseq") int fcseq, @RequestParam("title") String title,
			@RequestParam("content") String content, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertFaq(fcseq, title, content);

			return "redirect:/faqManagement";
		}
	}

	@PostMapping("/updateFaq")
	public String updateFaq(@RequestParam("fseq") int fseq, @RequestParam("fcseq") int fcseq,
			@RequestParam("title") String title, @RequestParam("content") String content, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.updateFaq(fseq, fcseq, title, content);

			return "redirect:/faqManagement";
		}
	}

	@PostMapping("/deleteFaq")
	public String deleteFaq(@RequestParam("fseq") int fseq, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.deleteFaq(fseq);

			return "redirect:/faqManagement";
		}
	}

	@GetMapping("/qnaManagement")
	public String qnaManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			model.addAttribute("qnaList", as.getQnaList());

			return "admin/qna/qnaManagement";
		}
	}

	@GetMapping("/qnaCatManagement")
	public String qnaCatManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			// 모든 Category 리스트 저장, 각 카테고리별 등록된 상품 수 저장
			model.addAttribute("qnaCatList", as.getQnaCatListwithCount());

			return "admin/qna/qnaCatManagement";
		}
	}

	@PostMapping("/insertQnaCat")
	public String insertQnaCat(@RequestParam("name") String name, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertQnaCat(name);

			return "redirect:/qnaCatManagement";
		}
	}

	@PostMapping("/deleteQnaCat")
	public String deleteQnaCat(@RequestParam(value = "qcseq", defaultValue = "0") int qcseq,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			if (qcseq == 0)
				System.out.println("Error : qcseq값이 0입니다.");
			else
				as.deleteQnaCat(qcseq);

			return "redirect:/qnaCatManagement";
		}
	}

	@PostMapping("/updateQnaCat")
	public String updateQnaCat(@RequestParam(value = "qcseq", defaultValue = "0") int qcseq,
			@RequestParam("name") String name, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			if (qcseq == 0)
				System.out.println("Error : qcseq값이 0입니다.");
			else
				as.updateQnaCat(qcseq, name);

			return "redirect:/qnaCatManagement";
		}
	}

	@GetMapping("/adminViewQna")
	public String adminViewQna(
			@RequestParam("qseq") int qseq,
			@RequestParam(value = "pseq", defaultValue = "0") int pseq,
			HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			// 상품문의일 경우 productVO도 넣음
			model.addAttribute("qnaVO", as.getQna(qseq));
			model.addAttribute("productVO", pseq == 0 ? null : as.getProduct(pseq));

			return "admin/qna/adminViewQna";
		}
	}

	@PostMapping("/updateQnaReply")
	public String updateQnaReply(@RequestParam("qseq") int qseq,
			@RequestParam(value = "pseq", defaultValue = "0") int pseq, @RequestParam("reply") String reply,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.updateQnaReply(qseq, reply);

			return "redirect:/adminViewQna?qseq=" + qseq + "&pseq=" + pseq;
		}
	}

	@PostMapping("/deleteQna")
	public String deleteQna(@RequestParam("qseq") int qseq, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.deleteQna(qseq);

			return "redirect:/qnaManagement";
		}
	}

	@GetMapping("/bannerManagement")
	public String bannerManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			model.addAttribute("bannerImageList", as.getBannerImageListwithCount());
			model.addAttribute("bannerList", as.getBannerList());
			model.addAttribute("maxPriority", as.getBannerMaxPriority());
			return "admin/banner/bannerManagement";
		}
	}

	@GetMapping("/bannerImages")
	public String bannerImages(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			model.addAttribute("bannerImageList", as.getBannerImageListwithCount());

			return "admin/banner/bannerImages";
		}
	}

	@PostMapping("/insertBannerImage")
	public String insertBannerImage(@RequestParam("name") String name, @RequestParam("image") String image,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertBannerImage(name, image);

			return "redirect:/bannerImages";
		}
	}

	@PostMapping("/deleteBannerImage")
	public String deleteBannerImage(@RequestParam("biseq") int biseq, HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.deleteBannerImage(biseq);

			return "redirect:/bannerImages";
		}
	}

	@PostMapping("/getImageByBiseq")
	@ResponseBody
	public HashMap<String, Object> getImageByBiseq(@RequestParam("biseq") int biseq, HttpServletRequest request,
			Model model) {

		System.out.println("biseq : " + biseq);

		HashMap<String, Object> result = new HashMap<String, Object>();

		try {
			String image = as.getImageByBiseq(biseq);
			System.out.println("image : " + image);

			result.put("STATUS", 1);
			result.put("FILENAME", image);
		} catch (IllegalStateException e) {
			e.printStackTrace();
			result.put("STATUS", 0);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("STATUS", 0);
		}

		return result;
	}

	@PostMapping("/insertBanner")
	public String insertBanner(
			@RequestParam("biseq") int biseq,
			@RequestParam(value = "uri", defaultValue = "#") String uri,
			@RequestParam("useyn") String useyn,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.insertBanner(biseq, uri, useyn);

			return "redirect:/bannerManagement";
		}
	}
	
	@PostMapping("/deleteBanner")
	public String deleteBanner(
			@RequestParam("bseq") int bseq,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.deleteBanner(bseq);
			
			//priority 정렬 필요
			
			return "redirect:/bannerManagement";
		}
	}
	
	@PostMapping("/updateBanner")
	public String updateBanner(
			@RequestParam("bseq") int bseq,
			@RequestParam("priority") int priority,
			@RequestParam(value = "uri", defaultValue = "#") String uri,
			@RequestParam("useyn") String useyn,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.updateBanner(bseq, priority, uri, useyn);
			
			return "redirect:/bannerManagement";
		}
	}
	
	@PostMapping("/raiseBannerPriority")
	public String raiseBannerPriority(
			@RequestParam("priority") int priority,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.swapBannerPriority(priority, "raise");
			
			return "redirect:/bannerManagement";
		}
	}
	
	@PostMapping("/lowerBannerPriority")
	public String lowerBannerPriority(
			@RequestParam("priority") int priority,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.swapBannerPriority(priority, "lower");
			
			return "redirect:/bannerManagement";
		}
	}
	
	@GetMapping("orderManagement")
	public String orderManagement(HttpServletRequest request, Model model) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			model.addAttribute("orderList", as.getAllOrderList());
					
			return "admin/order/orderManagement";
		}
	}
	
	@PostMapping("/updateOrderState")
	public String updateOrderState(
			@RequestParam("oseq") int oseq,
			@RequestParam("command") String command,
			HttpServletRequest request) {
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.updateOrderState(oseq, command);
							
			return "redirect:/orderManagement";
		}
	}
	
	@PostMapping("/requestCollect")
	public String requestCollect(
			@RequestParam("oseq") int oseq,
			@RequestParam("recipient") String recipient,
			@RequestParam("tel") String tel,
			@RequestParam("zipnum") String zipnum,
			@RequestParam("address1") String address1,
			@RequestParam("address2") String address2,
			@RequestParam("address3") String address3,
			HttpServletRequest request) {
		
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			as.requestCollect("otshop", oseq, recipient, tel, zipnum, address1, address2, address3);

			return "redirect:/orderManagement";
		}
	}
	
	@PostMapping("/updateInvoicenum")
	public String updateInvoicenum(
			@RequestParam("oseq") int oseq,
			@RequestParam("invoicenum") int invoicenum,
			HttpServletRequest request,
			Model model) {
		
		// 로그인 체크
		if (request.getSession().getAttribute("loginAdmin") == null) {
			return "redirect:/adminLoginForm";
		} else {
			if(!as.updateInvoicenum(oseq, invoicenum)) {
				model.addAttribute("message", "잘못된 송장번호입니다.");
				model.addAttribute("orderList", as.getAllOrderList());
				
				return "admin/order/orderManagement";
			}
									
			return "redirect:/orderManagement";
		}
	}
}