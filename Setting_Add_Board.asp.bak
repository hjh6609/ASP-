<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
	Response.CharSet="utf-8"
	Session.codepage="65001"
	Response.codepage="65001"
	Response.ContentType="text/html;charset=utf-8"

	Set DBHelper = new clsDBHelper
	Dim SelectNm

	'등급확인용
	Dim paramInfo1(0)
	paramInfo1(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, session("id"))
	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Users", paramInfo1, Nothing)

	If Not ( rs("Grade") = 1 Or  rs("UserID") = "hjh6609") Then
		response.redirect "list2.asp"
	End If


	rs.Close
	Set rs = nothing

	Dim paramInfo(0)
	paramInfo(0) = DBHelper.MakeParam("@Val",adInteger,adParamInput,4, "")
	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Category",paramInfo , Nothing)

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
</head>
<script type="text/javascript"> 

	$(document).ready(function(){
			//alert(11);
			$('#PublicYN').change(function()
			{
				 //alert(888);
				 var option = $(this).find('option:selected').val();
				 alert(option);
			});

			$("#txtBoardNm").click(function(){
					$("#txtBoardNm").val("");
			});
	});

	function AddBoard()
	{
		//게시판 추가창이 공백일 때.
		if($("#txtBoardNm").val() == "")
		{
			alert("게시판 이름을 입력하세요.");
			$("#txtBoardNm").focus();
			return;
		}
		
		//alert(		$("#PublicYN_B").val());
		//return;
		document.frmAdd.submit(); 
		return true;
	}

	function Ad_EditBoard(moon,seqno, oldtxt)
	{
		var Object = "Object";

		if(moon == "A")
		{
			$("#PublicYN_" + seqno).removeAttr('disabled'); 
			$("#PublicYN_" + seqno).removeAttr('style'); 			
			$("#BroardName_" + seqno ).html("<textarea id='txtBox_"+seqno+"'>" + oldtxt + "</textarea>");
			$("#Edit_Button_" + seqno ).html("<input type='button' id='btnSave' value='저장'> <input type='button' id='btnCancel' value='취소'>");
			

			//저장
			$("#btnSave").click(function(){
				//alert(11);

				var Newcontent = $("#txtBox_" + seqno).val();
				var SecretNo =$("#PublicYN_" + seqno ).val();

				if(Newcontent == "")
				{
					alert("글을 입력해 주세요.");
					$("#txtBox_" + seqno).focus();
					return;
				}
				else
				{
					$.ajax({
						 type: "POST",
						 url: "Setting_Add_Ok.asp", 
						 data:({"Gubun":Object,"division":moon,"seq":seqno, "content":Newcontent , "secretno":SecretNo}),
						 cache: false,
						 dataType: "text",
						 contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
						 success: function(data){
							 //alert(data);
							 //return;
							 if(data == "10")
							 {
								 alert("게시판명이 변경 되었습니다.");						
								 location.reload();
							 }
							 else if(data == "20")
							 {
								 alert("글이 존재하지 않습니다.");
								 return;
							 }
							 else
							 {
								 alert("알 수 없는 에러.");
							 }
						 }
					 });
				}
			});

			//취소 : 아직 구현안함
			$("#btnCancel").click(function(){
				  var thiss = $(this).prev();
				  alert(thiss);
			});
		}
		else 
		{
			//alert(moon);
			//alert("삭제"); 
			$.ajax({
				 type: "POST",
				 url: "Setting_Add_Ok.asp", 
				 data:({"Gubun":Object,"division":moon,"seq":seqno}),
				 cache: false,
				 dataType: "text",
				 contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
				 success: function(data){
					 //alert(data);
					 //return;
					 if(data == "30")
					 {
						 //alert("글이 삭제 되었습니다.");						
						 location.reload();
					 }
					 else
					 {
						 alert("알 수 없는 에러.");
					 }
				 }
			 });
		}
	}

</script>
<body>
<div class="container">
	<div class="header">
		 <nav>
			  <ul class="nav nav-pills pull-right">
				<li role="presentation"><a href="list2.asp">메인</a></li> 
				<li role="presentation" class="active"><a href="Basic_setting.asp">게시판추가</a></li> 
				<li role="presentation" ><a href="setting_add_member.asp">회원관리</a></li> 
				<li role="presentation"><a href="/logout.asp">로그아웃</a></li>
			  </ul>
		 </nav>
        <h3 class="text-muted">Basic setting</h3>
    </div>
	<div align="center">							
		<form id="frmBaEdit" method="POST" action="Setting_Add_Ok.asp">
			<table class="table table-condensed" style="width:*;">
				<tr>
					<td>게시판명</td>
					<td>게시판종류</td>
					<td>공개여부</td>
					<td>수정/삭제</td>
				</tr>
				<% If rs.BOF or rs.EOF Then %>
				   <tr align="center">
					<td colspan="5">등록된 게시판이 없습니다</td>
				  </tr>
				<%Else   
						Do Until rs.EOF  %>
				<tr>			
					<td id="BroardName_<%=rs(0)%>" onclick="fnBrNm('<%=rs(0)%>','<%=rs(1)%>'); return false;" >
						<p id="HideNm"><%=rs(1)%></p>
					</td>
					<td>
						<% Select Case (rs(4))
								 case 0	
								     response.write "공지사항"   
								 case 1
								     response.write "일반게시판"
								 Case Else :
								    response.write "자료실"
							  End Select
						%>
					</td>
					<td>
						<select id="PublicYN_<%=rs(0)%>" style="background-color: #dcdcdc" disabled="false">
							<%If  rs(2) = "0"  Then %>
									<option value="0">비공개</option>
									<option value="1">공개</option>
							<% Else %>
									<option value="1">공개</option>
									<option value="0">비공개</option>
							 <% End If  %>
						</select>
					</td>
					<td id="Edit_Button_<%=rs(0)%>" style="width:110px;">
						<input type="button" id="btnEdit" value="수정" onclick="Ad_EditBoard('A','<%=rs(0)%>','<%=rs(1)%>');"> <input type="button" id="btnDelete" value="삭제" onclick="Ad_EditBoard('B','<%=rs(0)%>');">
					</td>
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
		</form>
		&nbsp;
		<form name="frmAdd" method="POST" onSubmit="AddBoard();return false" action="Setting_Add_Ok.asp" >
			<select id="Kind_Board" name="Kind_Board1">
				<option value="0" selected="selected">공지사항</option>
				<option value="1" >일반게시판</option>
				<option value="2" >자료실</option>
			</select>
			<input type="txt" id="txtBoardNm" name="txtBoardNm1" value="게시판 이름을 입력해 주세요.">
			<select id="PublicYN_B" name="PublicYN1_B">
				<option value="0">비공개</option>
				<option value="1" selected="selected">공개</option>
			</select>
			<input type="submit" id="btnAdd" value="추가">
		</form>
	</div>
</div>
</body>
</html>