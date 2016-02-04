<%
	myid = Request.QueryString("myid")
%>
<!DOCTYPE html>
<head>
	<title>글쓰기</title>
	<!-- Bootstrap core CSS -->
	<link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

	<script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	
	<script type="text/javascript">
	
	function Confirm()
	{
		if(document.registForm.userPwd.value==''){
		  alert("비밀번호를 입력하세요.");
		  document.registForm.userPwd.focus();
		}else if(document.registForm.subject.value==''){
		  alert("제목을 입력하세요.");    
		  document.registForm.subject.focus();
		}else if(document.registForm.content.value=='')
		{
		  alert("내용을 입력하세요.");    
		  document.registForm.content.focus();
		}
		else{
		   document.registForm.submit(); 
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
			<li role="presentation" class="active"><a href="/list.asp?myid=<%=myid%>">Board</a></li>
			<li role="presentation"><a href="/logout.asp">LogOut</a></li>
		</ul>
		</nav>
		<h3 class="text-muted">First ASP Board</h3>
	</div>
	<form name="registForm" method= "post" action="regist_ok.asp" onSubmit="Confirm();return false">
		<table class="table">
			<tr>
				<td colspan="2" align="center"><b>글을 적어주세요</b></td>
			</tr>
			<tr>
				<td align="center">아이디</td>
				<td><input type="text" name="userID" size="15" value="<%=myid%>"></td>
			</tr>
			<tr>
				<td align="center">비밀번호</td>
				<td><input type="password" name="userPwd" size="15"></td>
			</tr>
			<tr>
				<td align="center">제목</td>
				<td><input type="text" name="subject" size="50"></td>
			</tr>
			<tr>
				<td align="center">내용</td>
				<td><textarea name="content" cols="50" rows="10"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="작성 완료">
					<a href="/list.asp?myid=<%=myid%>""><input type="button" value="목록으로"></a>
					<input type="reset" value="다시 작성">
				</td>
			</tr>
		</table>
   </form>
</div>
</body>
</html>
