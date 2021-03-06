<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Custom DataGrid Pager - jQuery EasyUI Demo</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/easyui/demo.css">
	<script type="text/javascript" src="${ctx}/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx}/easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body onresize="resizeGrid();">
	
	<div id="search">
		<div id="searchFrm">
		<table spellcheck="false">
			<tr>
				<th>城市:</th>
				<td>
					<select name="cityType" id="cityType" onchange="areaChange(this,'area')" style="width:130px;">
						<option value="0" selected="selected">全部</option>
						<option value="2">上海</option>
						<option value="12217">北京</option>
					</select>
				</td>
				<th>小区名称:</th>
				<td>
					<input class="easyui-validatebox textbox" type="text" name="estateName" id='estateName' style="width:160px;"></input>
				</td>
				<th>出售状态:</th>
				<td>
					<select  id="sellState" name="sellState" style="width:120px;">
						<option value="0" selected="selected">全部</option>
						<option value="1">出租</option>
						<option value="2">出售</option>
						<option value="3">既租又售</option>
						<option value="4">不租不售</option>
					</select>
				</td>
				
			</tr>
			
			<tr>
				<th>区域:</th>
				<td>
					<select  id="area" name="areaId" style="width:120px;" onchange="areaChange(this,'town');">
						<option value="0" parentid='0'>全部</option>
					</select>
				</td>
				<td style="width:120px;"></td>
				<!-- <th>出租状态:</th>
				<td>
					<select  id="rentState" name="rentState" style="width:120px;">
						<option value="0">全部</option>
						<option value="1">出租</option>
						<option value="2">不租</option>
						<option value="3">已租</option>
					</select>
				</td> -->
			</tr>
			<tr>
				<th>板块:</th>
				<td>
					<select  id="town" name="townId" style="width:120px;">
						<option value="0" parentid='0'>全部</option>
					</select>
				</td>
				
				<td style="width: 120px;"></td>
				<th colspan="1"> 审核状态:</th>
				<td colspan="1" id="operCustServiceState">
					<!-- 1审核中3再审核 4定时再审核 5审核满三次 0审核成功 2审核失败 -->
					<input type="checkbox" name="operCustServiceState" id="cs1" value="2"/>
					<label for="cs1">审核中</label>
					<!-- 
					<input type="checkbox" name="operCustServiceState" id="cs2" value="2"/>
					<label for="cs2">再审核</label>
					<input type="checkbox" name="operCustServiceState" id="cs3" value="4"/>
					<label for="cs3">定时再审核</label>
					<input type="checkbox" name="operCustServiceState" id="cs4" value="5"/>
					<label for="cs4">审核满三次</label> 
					-->
					<input type="checkbox" name="operCustServiceState" id="cs5" value="1"/>
					<label for="cs5">审核成功</label>
					<input type="checkbox" name="operCustServiceState" id="cs6" value="3"/>
					<label for="cs6">审核失败</label>
				</td>
				<td></td>
				
			</tr>
			<tr>
				<td>
					<input type="button" value="查询" onclick="doSearch();"/>
				</td>
			</tr>
		</table>
		</div>
	</div>
	
	<table id="mainfrom" > </table>
	
	<script type="text/javascript">
	
	/*
	上海行政区域转化
	*/
	function areaChange(obj,areaName){
		var area = $(obj);
		var parentId =area.val();
		var json =[];
		if(parentId == 1){}else{
			json = loadArea(parentId,false);
		}
		putOption(areaName,json);
		if(areaName=='area' ){
			putOption('town','');
		}
	}
	
	//加载 区域板块
	function loadArea(parentId,isAll){
		
		/*
		 * 加载 数据字典/地区
		 */
		var url1= "${ctx}/house/loadAreaByParentId";
		var resultData={};
		$.ajax( {
			url : url1,
			data : {'parentId' : parentId, 'flag' : isAll},
			async:false,
			method : 'POST',
			success : function(data) {
				//data =eval("("+data+")");
				resultData = data.areaList;
			},
			error : function(data) {
				
			}
		});
		return resultData;
	}
	
	/*
		添加下拉框的数据
	*/
	function putOption(key,json){
		if(json != null){
			var str='';
			if( key == 'cityType'||  key == 'area' ||  key == 'town'||   json == null || json.length == 0   ){
				str ='<option value="0" parentid="0" selected="selected">全部</option>';
			}
			var sel=$("#"+key);
			sel.html('');
			if(json != null) {
				for(var i =0 ; i< json.length ; i++){
					var row = json[i];
					/* if((key == 'area' ||  key == 'town') && i == 0){
						continue;
					} */
					str +='<option value="'+row.areaId+'" parentid="'+row.parentId+'">'+row.name+'</option>';
				}
			}
			sel.html(str);
		}
	}
		
	//搜索
		function doSearch(){
			var pars="{";
			var cityType = $("#cityType").val();
			if(cityType != null && cityType !=''){
				pars +="'cityType' : '"+cityType+"',";
				
			}
			
			var areaId = $("#area").val();
			if(areaId !=0 && areaId !=''){
				pars +="'parentId' : '"+areaId+"',";
			}
			
			var townId = $("#town").val();
			if(townId !=0 && townId !=''){
				pars +="'areaId' : '"+townId+"',";
			}
			var estateName=$("#estateName").val();
			if(estateName != null && estateName !=''){
				pars +="'estateName' : '"+estateName+"',";
			}
			var sellState = $("#sellState").val();
			if(sellState != null && sellState != '' && sellState !=0){
				pars +="'sellState' : '"+sellState+"',";
			}
			var rentState = $("#rentState").val();
			if(rentState != null && rentState != '' && rentState !=0){
				pars +="'rentState' : '"+rentState+"',";
			}
			
			var operCustServiceState = '';
			//var operFloorServiceState = '';
			var custs = document.getElementsByName("operCustServiceState");
			if(custs != null && custs !='' && custs.length>0){
				for(var i = 0; i <custs.length; i++){
					if(custs[i].checked){
						operCustServiceState += custs[i].value+",";
					}
				}
				
			}
			if(operCustServiceState.length >0){
				operCustServiceState = operCustServiceState.substr(0,operCustServiceState.length-1);
			}
			if(operCustServiceState != ''){
				pars +=" 'operServiceState' : '"+operCustServiceState+"',";
			}
			if(pars.length >1){
				pars = pars.substr(0,pars.length-1);
			}
			pars += "}";
			pars = eval("("+pars+")");
		    $('#mainfrom').datagrid('reload',pars);
		} 
		
		var data_from = $('#mainfrom').datagrid({
			url : '${ctx}/house/houseList',
			//fitColumns : true, //True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
			striped : true, //True 就把行条纹化
			pagination : true,//分页
			rownumbers : true, //显示行号
			pageSize : 20,
			pageNumber : 1,
			pageList : [ 20, 30, 50, 100 ],//列表分页
			loadMsg : '数据正在努力加载中...',
			height: document.body.clientHeight * 4.4,
			selectOnCheck : true, //点击行的时候也触发 同时 触发 点击checkbox
			checkOnSelect : true, //点击 checkbox 同时触发 点击 行
			columns : [ [
			          {field : 'houseId',checkbox : true,width:$(this).width() * 0.05}//显示一个checkbox
					, {field : 'cityName',title : '城市',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.05}
					, {field : 'areaName',title : '行政区',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.05}
					, {field : 'townName',title : '片区',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.1}
					, {field : 'estateName',title : '小区名',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.1}
					, {field : 'builing',title : '栋座号',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.05}
					, {field : 'room',title : '室号',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.05}
					, {field : 'sellStateStr',title : '租售状态',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.1}
					, {field : 'rentStateStr',title : '出租状态',align : 'center',resizable : true,hidden : true,sortable : false,width:$(this).width() * 0.1}
					, {field : 'sellPublishDateStr',title : '发布出售时间',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.1}
					, {field : 'rentPublishDateStr',title : '发布出租时间',align : 'center',resizable : true,hidden : true,sortable : false,width:$(this).width() * 0.1}
					, {field : 'checkTypeStr',title : '当前审核类型',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.1}
					, {field : 'operServiceStateStr',title : '当前审核状态',align : 'center',resizable : true,hidden : false,sortable : false,width:$(this).width() * 0.1}
					, {field : 'opt',  title : '操作',align : 'center',resizable : true,hidden : false,sortable : false ,width:$(this).width() * 0.1,
						formatter : function (value,row,index)
						 {
							return "<a href='javascript:void(0);' onclick='view_btn("+row.houseId+")'>查看</a>";
						 }
					   }

			] ],
			onDblClickRow : function(rowIndex, rowData) {
				//alert(rowData.houseId);
				view_btn(rowData.houseId);
			}

		});

		/*
		查看
		 */
		function view_btn(houseId) {
// 			这里需要houseId
			window.location.href="${ctx}/sourcemanage/sourceManageDetail?houseId=" + houseId;
		}

		function resizeGrid() {
			$('#mainfrom').datagrid('resize', {
				width : function() {
					return document.body.clientWidth * 0.9;
				}
			});
		}
		$(function(){
			/* $('#mainfrom').datagrid({
				width : function() {
					return document.body.clientWidth ;
				}
			}); */
			//加载 城市 . parentId = 1 (中国)
			var json = loadArea('1',true);
			putOption("cityType",json);
		});
		
	
	</script>
</body>
</html>