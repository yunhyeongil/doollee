<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%
	/**
	 * @Name : ExcelUploadSample
	 * @Description : 엑셀 업로드 샘플 화면
	 */
%>
<c:import url="../import/frameTop.jsp">
	<c:param name="progcd" value="SY06" />
</c:import>

<div id="ctm_wrap">
	<!-- 검색조건 영역 시작 -->
	<form id="frmSearch" action="#">
		<input type="hidden"  name="CURRENT_PAGE"  id="CURRENT_PAGE" />
		<input type="hidden"  name="ROWS_PER_PAGE"  id="ROWS_PER_PAGE" />
		<div id="ctm_sech_wrap" >
			<ul class="sech_ul">
				<li class="sech_list">
					<div>사용유무</div>
					<select id="S_STATUS" name="S_STATUS" class="cmc_combo">
						<option value="" selected="selected">==전체==</option>								
						<c:forEach var="i" items="${useyn}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</li>
			</ul>
		</div>
	</form>
	<!-- 검색조건 영역 끝 -->
	
	<!-- 그리드 시작 -->
	<div id="ctm_mg_wrap">
		<div class="ct_grid_top_wrap">
			<div class="ct_grid_top_left">권한목록</div>
			<div class="ct_grid_top_right"></div>
		</div>
		<table id="grid1"></table>
		<div id="grid1_pager"></div>
	</div>
	<!-- 그리드 끝 -->
</div>

<script type="text/javascript">
<%-- 
  * ========= 공통버튼 클릭함수 =========
  * 검색 : cSearch()
  * 추가 : cAdd()
  * 삭제 : cDel()
  * 저장 : cSave()
  * 인쇄 : cPrint()
  * 업로드 : cUpload()
  * 엑셀다운 : cExcel()
  * PDF다운 : cPdf()
  * 취소 : cCancel()
  * 사용자버튼 : cUser1() ~ cUser5()
  * -------------------------------
  * 버튼 순서 : setCommBtnSeq(['ret','list']) : Search,Add,Del,Save,Print,Upload,Excel,Pdf,Cancel,User1,2,3,4,5
  * 버튼 표시/숨김 : setCommBtn('ret', true) : Search,Add,Del,Save,Print,Upload,Excel,Pdf,Cancel,User1,2,3,4,5
  * ===============================
--%>
	//초기 로드
	$(function() {
		initLayout();
		createGrid1();
	});

	function createGrid1(){
		var colName = ['회사코드','권한코드','권한명','권한설명','사용유무'];
		var colModel = [
			{ name: 'COMP_CD', width: 100, align: 'center' },
			{ name: 'POLICY_CD', width: 120, align: 'left' },
			{ name: 'POLICY_NM', width: 180 },
			{ name: 'POLICY_DSC', width: 180 },
			{ name: 'STATUS', width: 70, align: 'center', edittype:"select", formatter : "select", editoptions:{value:'${griduseyn}'}}
	  	];
		
		var gSetting = {
		        pgflg:true,
		        colsetting : false,
				searchInit : false,
				resizeing : true,
				rownumbers:true,
				queryPagingGrid:true // 쿼리 페이징 처리 여부
		};
		
		btGrid.createGrid('grid1', colName, colModel, gSetting);
	}
	
	function cAdd(){
		btGrid.gridAddRow("grid1", "last");
	}
	
	function cUpload(){
		var	params = {'url':'/sample/uploadExcelSample.do'};    // 실제 엑셀 파일을 업로드하고 엑셀 파일을 읽을 경로
		popupOpen('/common/ExcelUploadPopup.do', 'excelupload', params, function(data){  // 엑셀 업로드 공통 팝업
			reloadGrid("grid1", data);
		});
	}
</script>

<c:import url="../import/frameBottom.jsp" />