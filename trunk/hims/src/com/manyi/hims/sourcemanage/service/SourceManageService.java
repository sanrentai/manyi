package com.manyi.hims.sourcemanage.service;

import java.math.BigDecimal;

import com.manyi.hims.Response;
import com.manyi.hims.bd.controller.HouseResourcePhotoController.TaskRequest;
import com.manyi.hims.entity.HouseResource;
import com.manyi.hims.sourcemanage.model.SourceManageRequest;
import com.manyi.hims.sourcemanage.model.SourceManageResponse;
import com.manyi.hims.util.EntityUtils;

/**
 * @date 2014年4月17日 下午12:51:05
 * @author Tom 
 * @description  
 * 房源管理详情页，service
 */
public interface SourceManageService {

	/**
	 * @date 2014年4月17日 下午1:50:38
	 * @author Tom  
	 * @description  
	 * 房源基础信息
	 */
	public SourceManageResponse getSourceBaseInfo(int houseId);
	
	/**
	 * @date 2014年4月17日 下午1:52:54
	 * @author Tom  
	 * @description  
	 * 租售信息
	 */
	public SourceManageResponse getSourceRentAndSellList(SourceManageResponse sourceManageResponse, int houseId);

	/**
	 * @date 2014年4月17日 下午1:53:36
	 * @author Tom  
	 * @description  
	 * 审核记录
	 */
	public SourceManageResponse getAuditMessageInfo(int houseId);
	
	
	/**
	 * @date 2014年5月19日 下午8:12:16
	 * @author Tom
	 * @description  
	 * 更新房源的价格信息
	 */
	public Response checkUpdateSource(TaskRequest taskRequest);

	
	/**
	 * @date 2014年4月17日 下午1:55:12
	 * @author Tom  
	 * @description  
	 * 房源修改记录
	 */
	public SourceManageResponse getSourceEditInfo(int houseId);
	
	
	/**
	 * @date 2014年4月20日 下午4:53:58
	 * @author Tom  
	 * @description  
	 * 房源修改
	 */
	public SourceManageResponse updateSourceManage(SourceManageRequest SourceManageRequest);
	
	
	/**
	 * @date 2014年4月21日 下午12:16:34
	 * @author Tom  
	 * @description  
	 * 删除房源信息，假删除
	 */
	public void deleteSourceInfo(int houseId, int operatorId);

	
}
