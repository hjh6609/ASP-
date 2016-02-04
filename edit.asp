<!--#include File="DBHelper.asp"-->
<%
      '//에러코드 시작 상단에 두고 
	  On Error Resume Next
	  Dim intSeq,strID, strNotice, strSubject, strContent , myid , test1, test2

      intSeq = Request.QueryString("seq")
	  myid = Request.QueryString("myid")
	  catenm = Request.QueryString("catenm")
	  	  
	  Set DBHelper = new clsDBHelper 	
  
	  Dim paramInfo(3)
	  paramInfo(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)
	  paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, "")
	  paramInfo(2) = DBHelper.MakeParam("@strSubject",adVarWChar,adParamInput,50, "view")
	  paramInfo(3) = DBHelper.MakeParam("@strContent",adVarWChar,adParamInput,300, "")

	  Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Edit", paramInfo, Nothing)

	  '에러가 있다면 메세지 보여주기 
	  if err.number <> 0 then 
		  response.Write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
	  ElseIf intSeq = "" Then 
		  response.Write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
	  ElseIf rs(0) <> 10 Then 
		  strName = rs(0)
		  strSubject = rs(1)
		  strContent = rs(2)
	  Else
		  response.write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
		  response.End
	  End If 

	  'response.write rs(0)
	  'response.End 
%>
<html>
<head>
	<title>Board : Edit</title>
	<!-- Bootstrap core CSS -->
	<link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

	<script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
</head>
<script>

function Confirm()
{
	if(document.editForm.userPwd.value=='')
	{
		alert("비밀번호를 입력해주세요.");
		 document.editForm.userPwd.focus();
	}
	else
	{
		 document.editForm.submit(); 
		 return true;	
	}
}

</script>
<body>
<div class="container">
	<div class="header">
		<nav>
		<ul class="nav nav-pills pull-right">
			<!-- 관리자일 때-->
			<%If Grade = 1 Or  session("id") = "hjh6609" Then %>
				<li role="presentation"><a href="/Setting_Add_Board.asp">Basic setting</a></li> 
				<li role="presentation"><a href="/logout.asp">LogOut</a></li>
			<!-- 일반 회원일 때 -->
			<%ElseIf Not (session("id") = "") Then %>
				<li role="presentation"><a href="/list2.asp">Main</a></li>
				<li role="presentation"><a href="/logout.asp">LogOut</a></li>
			<!-- 비회원 일 때 -->
			<%Else%>
				<li role="presentation"><a href="/list2.asp">Main</a></li>
				<li role="presentation"><a href="/login.asp">Login</a></li>
				<li role="presentation"><a href="/sign_up.asp">Sign Up</a></li>
			<%End If%>
		</ul>
		</nav>
		<h3 class="text-muted">First ASP Board</h3>
	</div>
	<form name="editForm" method="post" action="edit_ok.asp?seq=<%=intSeq%>" onSubmit="Confirm();return false">
		<input type="hidden" name="txtCatenm" value="<%=catenm%>">
		<table class="table">
		  <tr>
			<td colspan="2" align="center"><b>글 수정</b></td>
		  </tr>
		  <tr>
			<td align="center" colspan="2"><%=catenm%></td>
		  </tr>
		  <tr>
			<td align="center">아이디</td>
			<td><%=rs("strID")%></td>
		  </tr>
		  <tr>
			<td align="center">제목</td>
			<td>
			  <input type="text" name="subject" size="50" value="<%=rs("strSubject")%>">
			</td>
		  </tr>
		  <tr>
			<td align="center">내용</td>
			<td>
			  <textarea name="content" cols="50" rows="10"><%=rs("strContent")%></textarea>
		   </td>
		   <%
				 rs.Close
				 Set rs = Nothing
				 DBHelper.Dispose
				 Set DBHelper = Nothing
		   %>
		  </tr>
		  <tr>
			<td align="center">비밀번호</td>
			<td>
			  <input type="password" name="userPwd" size="15">
			</td>
		  </tr>
		  <tr>
			<td colspan="2" align="center">
			  <input type="submit" value="작성 완료">&nbsp;&nbsp;
			  <input type="button" onClick="javascript:history.back();" value="이전으로">
			</td>
		  </tr>
		</table>
	</form>
</div>
</body>
</html>
