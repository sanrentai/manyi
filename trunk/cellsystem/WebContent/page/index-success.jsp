<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>企业信息化平台管理系统</title>
		<link href="../../../css/ligerui-all.css" rel="stylesheet" type="text/css" />
		<link href="../../../css/ligerui-layout.css" rel="stylesheet" type="text/css" />
		<link href="../../../css/ligerui-tab.css" rel="stylesheet" type="text/css" />
		<script src="../../../scripts/jquery-1.5.2.min.js" type="text/javascript"></script>
		<script src="../../../scripts/ligerui.min.js" type="text/javascript"></script>
		<style type="text/css">
			html{
				overflow: hidden;
			}
			body{
				background-color: #e9eaed;
				padding-bottom: 10px;
			}
			#mainbody{
				margin:10px 10px 0px 10px;
			}
		</style>
		<script type="text/javascript">
		function openTab(tabid,title,url){
			window.framework.addTab(tabid, title, url);
		}
		</script>
	</head>
	<body>
		<div style="min-width: 980px;">
		
			<div class="l-topmenu">
				<div class="l-topmenu-l">
					<img class="logo" src="../../../css/img/layout/logo.png"/>
				</div>
				
				<div class="l-topmenu-r">
					<span>您好,
					
					<%--
					<a href="javascript:void(0);" onclick="openTab('edit','编辑信息','<%=path%>/TblOperator/modifySelf.do?id=<%=((TblOperator) request.getSession().getAttribute("operator")).getDid()%>');">设置</a>|
					<a href="javascript:void(0);" onclick="openTab('modifypassword','密码修改','<%=path%>/TblOperator/modifyPassword.do');">密码修改</a>|
					 --%>
					<a href="<%=path%>/logout.do" class="l-exit">注销</a>
				</div>
				
			</div>
			
			<div id="mainbody">
				<div position="left" id="mainmenu" title="功能菜单"></div>
				<div position="center" id="framecenter">
					<div tabid="home" title="我的主页">
						<iframe frameborder="0" name="home" id="home" src="/city/list"></iframe>
					</div>
				</div>
			</div>
			
		</div>
		
		<script type="text/javascript">
				var menus =<%=request.getAttribute("menus")%>;
		</script>
		<script type="text/javascript">
			function Layout() {
			 	window.layout, window.tab, window.accordion;
				if (this.init)
					this.init();
			}
			Layout.prototype = {
				init : function(options) {
					this.defaults = {
						main : "#mainbody", 
						center : "#framecenter", 
						menu : "#mainmenu"
					};
					jQuery.extend(this.defaults, options || {});
					var self = this;
					layout = $(this.defaults.main).ligerLayout( {
						space : 9,
						height : '100%',
						leftWidth : 160,
						onHeightChanged : self.atHeight,
						minLeftWidth : 130
					});
					var bHeight = $(this.defaults.main).height();
				    $.ligerDefaults.TabString.closeMessage = "关闭当前";
					tab = $(this.defaults.center).ligerTab( {
						height : bHeight,contextmenu : true,
						//onBeforeRemoveTabItem : self.beforeRemove,
						onAfterAddTabItem : self.afterAdd,
						onRendered : self.tabRendered
					});
					//self.creMenu();
				},
				tabRendered : function() {
					var ele = $(this.tab.menu.element).addClass("l-winMenu").width(90);
					$(".l-menu-inner",ele).append("<div class='l-top'><div class='l-l'></div><div class='l-c'></div><div class='l-r'></div></div>");
					$(".l-menu-inner",ele).append("<div class='l-bot'><div class='l-l'></div><div class='l-c'></div><div class='l-r'></div></div>");
					$(this.tab.menu.menu.shadow[0]).remove();
				},
				beforeRemove : function(tabid) {
					var current = $(".l-tab-links [tabid=" + tabid + "] a:first", this.element);
					if (/^(新增|修改|添加)/.test(current.text()) && !window.isClose) {
						LG.showSuccess("确定离开吗","closeConfirm",function(type){
							if (type){
								window.isClose = true;
								tab.removeTabItem(tabid);
							}
						});
						return false;
					}
					window.isClose = false;
				},
				afterAdd : function(tabid) {
					$(".l-tab-loading",this.element).hide();
					tabid = tabid.split("_");
					if (tabid[1] !== undefined){
						var parent = $(".l-tab-links [tabid=" + tabid[0] + "]", this.element);
						var current = $(".l-tab-links [tabid=" + tabid.join("_") + "]", this.element);
						var cParent = $(".l-tab-content [tabid=" + tabid[0] + "]", this.element);
						var cCurrent = $(".l-tab-content [tabid=" + tabid.join("_") + "]", this.element);
						parent.after(current);
						cParent.after(cCurrent);
					}
				},
				creMenu : function() {
					var self = this;
			        var mainmenu = $(this.defaults.menu);
			        $(menus).each(function(i, menu) {
			        	var item;
						if (menu.children != null && menu.children.length > 0) {
							item = $('<div class="menulist" title="' + menu.text + '"></div>');
							$(menu.children).each(function(j, submenu) {
								var span = $("<dir class='l-accordion-child'>").html(submenu.menuname || submenu.text);
								span.attr( {url : submenu.menuurl,menuno : submenu.menuno});
								$(item).append(span);
							});
						} else {
							item = $("<dir class='l-accordion-header onlyHeader'>").html(menu.menuname || menu.text);
							item.attr( {url : menu.menuurl,menuno : menu.menuno });
						}
						if (menu.menuicon || menu.icon) {
							var img = $("<img>").attr("src", menu.menuicon || menu.icon).hide();
							$(item).append(img)
						}
						mainmenu.append(item);
					});
					var bHeight = $(this.defaults.main).height() - 33;
					$.ligerMethos.Accordion = {
						_rendered : function() {
							if (this.element) $(this.element).attr("ligeruiid", this.id);
							var first = $(this.element).children().eq(0);
							if (first.is("dir")) {
								var css = "l-accordion-toggle-";
								var par = $("." + css + "open", this.element).removeClass(css + "open").addClass(css + "close").parent();
								par.next(".l-accordion-content").css( {"display" : "none"});
							}
						}
					}
					accordion = $(this.defaults.menu).ligerAccordion({ height: bHeight, speed: "normal" });
					$(".l-accordion-content",mainmenu).each(function(){
						$("img:first",this).appendTo($(this).prev()).css({"display":"inline"});
					});
					var spans = $("dir",mainmenu);
					spans.each(function(){
						var t = $(this);
						$("img",t).css({"display":"inline"});
						$(t).click(function() {
							var menuno = t.attr("menuno") || 1;
							var url = t.attr("url");
							url += (url.match(/\?/) ? "&" : "?") + "MenuNo=" + menuno;
							self.addTab(menuno, t.text(), url);
							spans.removeClass("l-accordion-selected");
							$(this).addClass("l-accordion-selected");
						});
					});
					$(".l-accordion-content").css({"height" : "auto"});
					$(".l-accordion-panel").css({"overflow-y":"auto"});
				},
				atHeight : function(options) {
					if (tab)
						tab.addHeight(options.diff);
					if (accordion && options.middleHeight - 33 > 0)
						accordion.setHeight(options.middleHeight - 33);
				},
				addTab : function(tabid, text, url) {
					if (!tab)
						return;
					tab.addTabItem( {
						tabid : tabid,
						text : text,
						url : url
					});
				}
			}
			window.framework = new Layout();
		</script>
		<script src="../../../scripts/common.js" type="text/javascript"></script>
	</body>
</html>
