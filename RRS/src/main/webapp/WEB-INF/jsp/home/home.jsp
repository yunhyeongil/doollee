<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"     prefix="tiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<title>Resort Reservation System - RRS</title>
		<script type="text/javascript">
			
			function addTab(prog_cd, url, context) {
				if($('#tabs >ul >li').length < tabCounter){
					var tabs = $("#tabs").tabs({heightStyle: "fill"});
					
					if(prog_cd == undefined){
						tabs.tabs( "refresh" );
						return;
					}
					
					var id = "tabs-" + prog_cd,
					li = "<li><a href='#" + id + "'>" + context + "</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>";
		
			    	if($("#" + id).length > 0){
			    		var index = $('#tabs a[href="#' + id + '"]').parent().index();
			    		
						tabs.tabs('option', 'active', index);
			    		return;
			    	}
					tabs.find( ".ui-tabs-nav" ).append( li );
					tabs.append( "<div id='" + id + "' style='padding:0;margin:0;border:0;'><iframe id='i" + id + "' src='" + "${pageContext.request.contextPath}" + url + "' style='width:100%;height:100%;' frameborder=0 border=0 hspace='0' vspace='0'></iframe></div>" );
					tabs.tabs( "refresh" );
					setTimeout(function() {
						var index = $('#tabs a[href="#tab_id"]').parent().index();
						
						tabs.tabs('option', 'active', index);
					}, 100);
				}else{
					alert("<s:message code='errors.tabsOverCnt' arguments='" + tabCounter + "' javaScriptEscape='false'/>");
				}
		    }
		</script>
	</head>
	<body id="mainbody" class="mainbody">
			<!-- 공통 JS/CSS 시작 -->
			<tiles:insertAttribute name="imp"  />
			<!-- 공통 JS/CSS 끝 -->
			
			<!-- 상단 메뉴 시작 -->
			<tiles:insertAttribute name="top"  />
			<!-- 상단 메뉴 끝 -->
			
			<!-- 좌측 메뉴 시작 -->
			<tiles:insertAttribute name="navi"  />
			<!-- 좌측 메뉴 끝 -->
			
			<!-- 메인 시작 -->
			<div id="main_contents" class="content_wrap">
				<div id="tabs">
					<div style="position:absolute;left:calc(100% - 91px);top:8px;">
					      <input type="button" id="tabsAllClose" style="outline:none;" value="Close All">
					</div>
					<ul>
					  <li><a href="#tabs-1">&nbsp;Main&nbsp;</a></li>
					</ul>
					
					<div id="tabs-1">
						<!-- <iframe src="/main/main.do" id="icontent" name="icontent" style="width:100%;height:100%;"  allowfullscreen></iframe> -->
						<iframe src="/reserve/reserveList.do" id="icontent" name="icontent" style="width:100%;height:100%;"  allowfullscreen></iframe>
					</div>
				</div>
			</div>
			<!-- 메인 끝 -->
		
	</body>
</html>