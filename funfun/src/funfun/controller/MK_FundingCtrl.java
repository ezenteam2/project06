package funfun.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import funfun.service.MK_FundingService;
import funfun.vo.Paging;
import funfun.vo.Project;

@Controller
@RequestMapping("/funding.do")
public class MK_FundingCtrl {
	@Autowired(required=false)
	private MK_FundingService service;
	
	// http://localhost:5080/funfun/funding.do?method=list
	@RequestMapping(params="method=list")
	public String projectList(@ModelAttribute("project") Project sch, Model d) {
		String cate = sch.getCate_title();
		
		if(cate == null) cate =  "";
		
		switch(cate) {
		case "교육" :
			d.addAttribute("cateTitle","교육·키즈");
			break;
		case "패션" :
			d.addAttribute("cateTitle","패션·잡화·뷰티");
			break;
		case  "홈리빙":
			d.addAttribute("cateTitle","홈리빙·디자인소품");
			break;
		case "공연" :
			d.addAttribute("cateTitle","공연·컬쳐");
			break;
		case "스포츠":
			d.addAttribute("cateTitle","스포츠·모빌리티");
			break;
		case "출판":
			d.addAttribute("cateTitle","출판");
			break;
		case "반려동물":
			d.addAttribute("cateTitle","반려동물");
			break;
		case "테크":
			d.addAttribute("cateTitle","테크·가전");
			break;
		default:
			d.addAttribute("cateTitle", "전체보기");
			break;
		}
		
		d.addAttribute("plist", service.projectList(sch));
		
		
		return "WEB-INF\\views\\funding\\mk_user_w_projectList.jsp";
	}
	
	// for json
	// http://localhost:5080/funfun/funding.do?method=ajaxList
	@RequestMapping(params="method=ajaxList")
	public String ajaxList(Project sch, Model d) {
		// view를 json형 뷰로 선언
		d.addAttribute("plist", service.projectList(sch));
		// 모델에 있는 plist로 된 ArrayList 객체를 json형식으로 변경
		return "pageJsonReport";
	}
	
	// 프로젝트 상세보기
	@RequestMapping(params="method=detail")
	public String detail(@RequestParam("pro_code") int pro_code, Model d) {
		d.addAttribute("project", service.detail(pro_code));
		d.addAttribute("opt", service.proOptList(pro_code));
		return "WEB-INF\\views\\funding\\mk_user_w_projectDetail.jsp";
	}
	

}
