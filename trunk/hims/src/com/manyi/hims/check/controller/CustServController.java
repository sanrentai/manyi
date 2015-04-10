package com.manyi.hims.check.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.async.DeferredResult;

import com.manyi.hims.Global;
import com.manyi.hims.Response;
import com.manyi.hims.RestController;
import com.manyi.hims.check.model.AntiCheatRequest;
import com.manyi.hims.check.model.AntiCheatResponse;
import com.manyi.hims.check.model.CSSingleRequest;
import com.manyi.hims.check.model.CommitCheckAllRequest;
import com.manyi.hims.check.model.IsShanghaiResponse;
import com.manyi.hims.check.service.CustServService;
import com.manyi.hims.employee.model.EmployeeModel;
import com.manyi.hims.util.CommonUtils;

@Controller
@SessionAttributes(Global.SESSION_UID_KEY)
@RequestMapping("/check")
public class CustServController extends RestController{
	
	@Autowired
	@Qualifier("custServService")
	private CustServService custServService;
	
	
	@RequestMapping(value = "/custServ/single.rest", produces = "application/json")
	@ResponseBody
	public DeferredResult<Response> single(@RequestBody  CSSingleRequest css,HttpServletRequest request ){
		return CommonUtils.deferredResult(custServService.getSingle(css));
	}
	
	@RequestMapping(value = "/custServ/submitCheckAll.rest", produces = "application/json")
	@ResponseBody
	public Response submitCheckAll(HttpServletRequest request , @RequestBody CommitCheckAllRequest ccar){
		return custServService.submitCheckAll(ccar);
	}
	
	@RequestMapping(value = "/custServ/getCheckNum.rest", produces = "application/json")
	@ResponseBody
	public DeferredResult<Response> getCheckNum(HttpServletRequest request , @RequestBody EmployeeModel emp){
		return CommonUtils.deferredResult(custServService.getCheckNum(emp));
	}
	
	
	@RequestMapping(value = "/custServ/isShanghai.rest", produces = "application/json")
	@ResponseBody
	public DeferredResult<Response> isShanghai(@RequestBody String mobile){
		return CommonUtils.deferredResult(custServService.isShanghai(mobile));
	}
	
	@RequestMapping(value = "/custServ/antiCheat.rest", produces = "application/json")
	@ResponseBody
	public DeferredResult<AntiCheatResponse> antiCheat(@RequestBody AntiCheatRequest anti){
		return CommonUtils.deferredResultGenic(custServService.antiCheat(anti));
	}

}
