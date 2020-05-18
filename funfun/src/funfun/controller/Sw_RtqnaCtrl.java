package funfun.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import funfun.service.Sw_RtqnaService;
import funfun.vo.Paging;
import funfun.vo.Rtqna;

@Controller
@RequestMapping("/rtqna.do")
public class Sw_RtqnaCtrl {
	// http://localhost:5080/funfun/rtqna.do?method=list
	// http://localhost:5080/funfun/rtqna.do?method=admList
	// http://localhost:5080/funfun/rtqna.do?method=insForm
	// http://localhost:5080/funfun/rtqna.do?method=insert
	// http://localhost:5080/funfun/rtqna.do?method=detail
	// http://localhost:5080/funfun/rtqna.do?method=update
	// http://localhost:5080/funfun/rtqna.do?method=delete
	// WEB-INF\\views\\servicecenter\\NewFile.jsp
	
	@Autowired(required=false)
	private Sw_RtqnaService service;
	
	// http://localhost:5080/funfun/rtqna.do?method=list
	@RequestMapping(params="method=list")
	public String list(@ModelAttribute("paging") Paging sch, Model d) {
		d.addAttribute("list",service.list(sch));
		return "WEB-INF\\views\\servicecenter\\sw_admin_w_rtqnaList.jsp";
	}
	// http://localhost:5080/funfun/rtqna.do?method=ajaxlist
	@RequestMapping(params="method=ajaxlist")
	public String ajaxlist(@ModelAttribute("paging") Paging sch, Model d) {
		d.addAttribute("list",service.list(sch));
		return "pageJsonReport";
	}
	
	// http://localhost:5080/funfun/rtqna.do?method=admList
	@RequestMapping(params="method=admList")
	public String admList(@ModelAttribute("paging") Paging sch, Model d) {
		d.addAttribute("list",service.list(sch));
		return "WEB-INF\\views\\servicecenter\\sw_admin_w_rtqnaList.jsp";
	}
	
	
	
	// http://localhost:5080/funfun/rtqna.do?method=insert
	@RequestMapping(params="method=insert")
	public String insert(Rtqna ins) {
		service.insert(ins);
		System.out.println("rtqna 등록완료");
		
		return "WEB-INF\\views\\servicecenter\\sw_admin_w_noticeInsert.jsp";
	}

	
	// http://localhost:5080/funfun/rtqna.do?method=detail
	@RequestMapping(params="method=detail")
	public String detail(@RequestParam("rtqna_code") int rtqna_code, Model d) {
		d.addAttribute("notice", service.detail(rtqna_code));
		return "WEB-INF\\views\\servicecenter\\sw_admin_w_noticeDetail.jsp";
	}
	// http://localhost:5080/funfun/rtqna.do?method=update
	@RequestMapping(params="method=update")
	public String update(Rtqna upt) {
		service.update(upt);
		System.out.println("rtqna 수정완료");
		return "forward:/notice.do?method=detail&noti_code+"+upt.getRtqna_code();
	}
	
	
}
