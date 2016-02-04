<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
	Response.CharSet="utf-8"
	Session.codepage="65001"
	Response.codepage="65001"
	Response.ContentType="text/html;charset=utf-8"
	
	Set DBHelper = new clsDBHelper

   'Session 
   If session("id") = "" Then
		response.redirect "login.asp"
   End If

   Dim intNowPage, intTotalCount, intTotalPage, intBlockPage, intPageSize ,val
   intNowPage = Request.QueryString("page")	'현재 페이지 

   intPageSize = 10
   intBlockPage = 10 ' 페이지를 몇개씩 구분할 것 인지 - 이전 O개, 다음 O개 할때 사용하지요 - 를 나타내는 변수

   If intNowPage = 0 Or intNowPage = "" Then
       intNowPage = 1
   End If
	
	'등급확인용
	Dim paramInfo1(0)
	paramInfo1(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, session("id"))
	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Users", paramInfo1, Nothing)

	If Not ( rs("Grade") = 1 Or  rs("UserID") = "hjh6609") Then
		response.redirect "list2.asp"
	End If


	Dim paramInfo(1)
	paramInfo(0) = DBHelper.MakeParam("@intPageSize",adInteger,adParamInput,4, intPageSize)
	paramInfo(1) = DBHelper.MakeParam("@NowPage",adInteger,adParamInput,4, intNowPage)
	
	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Member_List",paramInfo , Nothing)

	intTotalCount = rs(0)	'전체페이지개수
    intTotalPage = rs(1)	

	'response.write intTotalCount
	'response.End 

%>
<!Doctype html>
<head>
	<title>Basic Setting</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">
    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
</head>
<script type="text/javascript">
	//더보기 기능
	function goViewMore() {
		var TotalPage = $("#hdntotal").val();
		var page =1;
		for (page =1; page < TotalPage; page++)
		{
			location.href=("setting_add_member.asp?page="+ page);
		}
	}
	$(document).ready(function(){
		

	});

	function Ad_EditBoard(inx){
		//alert(grade);
		//return;
		
		$("#Grade_" + inx).removeAttr('disabled'); 
		$("#Grade_" + inx).removeAttr('style'); 		
		$("#Edit_Button_" + inx ).html("<input type='button' id='btnSave' value='저장'> <input type='button' id='btnCancel' value='취소'>");
		
		$("#btnSave").click(function(){
			var grade= $("#Grade_" + inx).val();

			if (grade == " ")
			{
				grade=5;
			}

			//alert(grade);
			
			$.ajax({
				 type: "POST",
				 url: "Setting_Add_MemOk.asp", 
				 data:({"seq":inx, "grade":grade}),
				 cache: false,
				 dataType: "text",
				 contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
				 success: function(data){
					 //alert(data);
					 //return;
					 if(data == "20")
					 {
						 alert("등급이 변경되었습니다.");						
						 location.reload();
					 }
					 else
					 {
						 alert("알 수 없는 에러.");
					 }
				 }
			 });
		});
	}
       
</script>
<body>
	<div class="container">
	<div class="header">
		 <nav>
			  <ul class="nav nav-pills pull-right">
				<li role="presentation"><a href="list2.asp">메인</a></li> 
				<li role="presentation"><a href="setting_add_board.asp">게시판추가</a></li> 
				<li role="presentation" class="active"><a href="setting_add_mamber.asp">회원관리</a></li> 
				<li role="presentation"><a href="/logout.asp">로그아웃</a></li>
			  </ul>
		 </nav>
        <h3 class="text-muted">Basic setting</h3>
    </div>
	<div align="center">
	<ul data-role="listview"  id="listView">
		<table class="table table-condensed">
			<tr>
				<td>아이디</td>
				<td>가입일</td>
				<td>등급</td>
				<td>저장/취소</td>
			</tr>
		 <% If rs.BOF or rs.EOF Then %>
			<tr align="center">
				<td colspan="5">등록된 회원이 없습니다</td>
			</tr>
		  <%Else 
				Do Until rs.EOF
		  %>
			<tr>
				<td ><%=rs("UserID")%></td>
				<td>
					<!-- 날짜 -->
					<%If IsNull(rs("RcdDate")) Then 
						response.write "날짜없음" 
					Else 
						response.write(Replace(Mid(rs("RcdDate"),1,10),"-",".")) 
					End If%>
				</td> 
				<td>
					<%If IsNull (rs("Grade")) Then 
							response.write "등급 미지정"
						Else 
							'response.write rs("Grade")
					%>
						<select id="Grade_<%=rs(0)%>" style="background-color: #dcdcdc" disabled="false"> 
							<option value="<%=rs("grade")%>"><%=rs("grade")%></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					<%
						End If 
					%>	
				</td>
				<td id="Edit_Button_<%=rs(0)%>">
					<input type="button" id="btnEdit" value="수정" onclick="Ad_EditBoard('<%=rs(0)%>');">&nbsp;<input type="button" value="취소">
				</td>
				<td><input type="hidden" id="hdntotal" value="<%=intTotalCount%>"></td>
			</tr>
		  <%
					  rs.MoveNext
				  Loop
		   End If

		   rs.Close
		   Set rs = nothing
		   DBHelper.Dispose
		   Set DBHelper = Nothing
		%>
		</table>
		<a href="#" onclick="goViewMore(); return false;" title="더보기">더보기</a>
	</div>
</body>
</html>