<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>企业云平台管理系统</title>
		<link href="../static/xcloud/css/ligerui-all.css" rel="stylesheet" type="text/css" />
		<link href="../static/xcloud/css/ligerui-form.css" rel="stylesheet" type="text/css" />
		<link href="../static/xcloud/css/common.css" rel="stylesheet" type="text/css" />
		<script src="../static/xcloud/js/jquery-1.5.2.min.js" type="text/javascript"></script>
		<script src="../static/xcloud/js/ligerui.min.js" type="text/javascript"></script>
		<script src="../static/xcloud/js/common.js" type="text/javascript"></script>
		<script type="text/javascript">
			var id=<%=request.getAttribute("id")%>;
		</script>
	</head>
	<body>
		<div class="detail-middle l-form" style="margin-left: 30px;">
			<div class="l-group l-group-hasicon"><img src="../static/xcloud/css/img/icon/communication.gif" /><span>基本信息</span></div>
			<table id="detail" class="detail-tableSkin detail-tableSkinA">
				<tr>
					<th>账号：</th>
					<td class="daccount"></td>
				</tr>
				<tr>
					<th>地区：</th>
					<td class="dareano"></td>
				</tr>
				<tr>
					<th>名称：</th>
					<td class="dname"></td>
				</tr>
				<tr>
					<th>地址：</th>
					<td class="daddress"></td>
				</tr>
				<tr>
					<th>联系方式：</th>
					<td class="dtel"></td>
				</tr>
				<tr>
					<th>行业类别：</th>
					<td class="dindustryname"></td>
				</tr>
				<tr>
					<th>存储空间：</th>
					<td class="dstoragespace"></td>
				</tr>
				<tr>
					<th>CDN资源类型：</th>
					<td class="dcdnname"></td>
				</tr>
				<tr>
					<th>关联EPG：</th>
					<td class="depgname"></td>
				</tr>
				<tr>
					<th>启用时间：</th>
					<td class="denabledtime"></td>
				</tr>
				<tr>
					<th>停用时间：</th>
					<td class="ddisabledtime"></td>
				</tr>
				<tr>
					<th>创建时间：</th>
					<td class="dcreatetime"></td>
				</tr>
				<tr>
					<th>更新时间：</th>
					<td class="dupdatatime"></td>
				</tr>
				<tr>
					<th>状态：</th>
					<td class="dstatus"></td>
				</tr>
			</table>
		</div>
		<script type="text/javascript">
			var crForm = {
				main : "#detail",
				init : function() {
					var detail = $(this.main);
					this.loadDetail(detail);
					 LG.setFormDefaultBtn(this.cancel,null);
				},
				loadDetail : function(d) {
					var self = this;
					LG.loadDetail(d, {url : "loadView.do?id="+id}, self.callback);
				},
				cancel : function(item) {
					var win = parent || window;
	            	win.LG.closeCurrentTab(null);
				},
				callback : function(data) {
					data = data|| {};
					for ( var p in data) {
						var ele = $("[class=" + p + "]", detail);
						if (ele.length > 0) {
							if(p=="dstatus"){
								if(data[p]==0){
									ele.html("停用");
								}else{
									ele.html("启用");
								}
							}else{
								ele.html(data[p]);
							}
						}
					}
				}
			}
			crForm.init();
			
		</script>
		<br/>
		<br/>
	</body>
</html>