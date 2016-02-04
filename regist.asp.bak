<%@Language="VBScript" CODEPAGE="65001" %>
<%
	Response.CharSet="utf-8"
   Session.codepage="65001"
   Response.codepage="65001"
   Response.ContentType="text/html;charset=utf-8"
	
	myid = Request.QueryString("myid")
	Gotopage =  Request.QueryString("page")
	CateNm =  Request.QueryString("categoryNm")
	Gubun = Request.QueryString("Gubun")
	Pos = Request.QueryString("pos")  ' 답글에서 넘어오는 부모글 번호
	SendTitle = Request.QueryString("Sand")  
	inx2 = Request.QueryString("seq")  '답글용
	Group_num = Request.QueryString("group_num")  '답글용 group_num
	Group_Cnt = Request.QueryString("cnt")  ' 답글의 답글 group_count +를 위해.
	CateNum = Request.QueryString("catenum")  ' 카테고리 고유번호
	KindNum=Request.QueryString("kindnum")
	
	'response.write CateNm
	'response.End 
	
	'글쓰는건 회원만
	If session("id") = "" Then
		'response.redirect "login.asp"
		response.redirect "MultiBoard.asp?categoryNm=공지사항"
   End If

	If Gubun = "RE" Then
		Title = "답글쓰기"
		Variable = "Re:" & SendTitle
	End If 

%>
<!DOCTYPE html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=Title%></title>
	<!-- Bootstrap core CSS -->
	<link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">
	<script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	
	<script type="text/javascript">
	//$(document).ready(function(
	//});
	var submit_chk = false;
	function Confirm()
	{
		if(document.registForm.userPwd.value==''){
		  alert("비밀번호를 입력하세요.");    
		  document.registForm.subject.focus();
		}else if(document.registForm.subject.value==''){
		  alert("제목을 입력하세요.");    
		  document.registForm.subject.focus();
		}else if(document.registForm.content.value=='')
		{
		  alert("내용을 입력하세요.");    
		  document.registForm.content.focus();
		}
		else{
			if (submit_chk == true) {
				alert("등록중 입니다.");
				return false;
			}
			document.registForm.submit(); 
			submit_chk = true;
	        return true;
		}
	}

	</script>
</head>
<body>
<div class="container">
	<div class="header">
		<nav>
		<ul class="nav nav-pills pull-right">
			<li role="presentation" class="active"><a href="/list2.asp">Main</a></li>
			<li role="presentation"><a href="/logout.asp">LogOut</a></li>
		</ul>
		</nav>
		<h3 class="text-muted">First ASP Board</h3>
	</div>
	<form name="registForm" method= "post" action="regist_ok.asp" onSubmit="Confirm();return false"  enctype="multipart/form-data" accept-charset="utf-8" onsubmit="emulAcceptCharset(this)">
		<input type="hidden" name="txtInx" value="<%=inx2%>">
		<input type="hidden" name="txtCateNm" value="<%=CateNm%>">
		<input type="hidden" name="txtGubun" value="<%=Gubun%>">
		<input type="hidden" name="txtPos" value="<%=Pos%>">
		<input type="hidden" name="txtGroup" value="<%=Group_num%>"> 
		<input type="hidden" name="txtCnt" value="<%=Group_Cnt%>"> 
		<input type="hidden" name="txtCateNum" value="<%=CateNum%>"> 
		<input type="hidden" name="txtKindNum" value="<%=KindNum%>"> 
		<table class="table">
			<tr>
				<td colspan="2" align="center"><b><%=Title%></b></td>
			</tr>
			<!-- 
			<tr>
				<td align="center">아이디</td>
				<td><input type="text" name="userID" size="15" value="<%=myid%>"></td>
			</tr>
			-->
			<tr>
				<td align="center">게시판명</td>
				<td><%=CateNm%></td>
			</tr>
			<tr>
				<td align="center">비밀번호</td>
				<td><input type="password" name="userPwd" size="15"></td>
			</tr>
			<tr>
				<td align="center">제목</td>
				<td><input type="text" name="subject" size="50" value="<%=Variable%>"></td>
			</tr>
			<tr>
				<td align="center">내용</td>
				<td><textarea name="content" cols="50" rows="10"></textarea></td>
			</tr>
			<!-- 자료실 -->
			<%If KindNum= 2 Then %>
			<tr>
				<td>파일첨부</td>
				<td>
					<input type="file" name="attachFile"><br> 
				</td>
			</tr>
			<%End If%>
			<!-- //자료실 -->
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="작성 완료">
					<!-- <a href="/list.asp?page="<%=Gotopage%>><input type="button" value="목록으로"></a> -->
					<input type="reset" value="다시 작성">
				</td>
			</tr>
		</table>
   </form>
</div>
</body>
</html>
