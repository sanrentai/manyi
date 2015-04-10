package com.manyi.ihouse.util;

import org.springframework.web.context.request.async.DeferredResult;

import com.manyi.ihouse.base.Response;


public class CommonUtils {
	
	public static DeferredResult<Response> deferredResult(Response response) {
		DeferredResult<Response> dr = new DeferredResult<Response>();
		dr.setResult(response);
		return dr;
	}
}
