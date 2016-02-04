<%
      Option Explicit

      Dim intSeq 
      intSeq = Request.QueryString("seq")


%>
<html>
<head>
	<title>Delete</title>
	<!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

	<style type="text/css">
		td{ padding: 2px 10px 20px;}
		#al{ padding : 177px; }
	</style>
	
	<script>
	function Confirm()
	{
		//console.log(11111);
		//return;
		//삭제창이 공백일 때.
		//if($("#txtPwd").val() == "")
		if(if( document.deleteForm.userPwd2.value == "")
		{
			alert("비밀번호를 입력하세요.");
			//$("#txtPwd").focus();
			document.deleteForm.userPwd2.focus();
		}
		document.deleteForm.submit(); 
		return true;
	}
	</script>
</head>
<body>
<div class="container">
  <div class="header">
	 <nav>
		  <ul class="nav nav-pills pull-right">
			<li role="presentation"><a href="/list.asp" id="board">Board</a></li>
			<li role="presentation" class="active"><a href="/login.asp">Login</a></li>
			<li role="presentation"><a href="/sign_up.asp">Sign Up</a></li>
		  </ul>
	 </nav>
		<h3 class="text-muted">First ASP BOARD</h3>
	</div>
	<b id="al">글을 삭제합니다</b>
	<form name="deleteForm" method="post" action="delete_ok.asp?seq=<%=intSeq%>" onSubmit="Confirm();return false">
		<table cellspacing="0" width="500">
		  <tr>
			<td colspan="2" align="center">&nbsp;</td>
		  </tr>
		  <tr>
			<td align="center">비밀번호</td>
			<td>
			  <input type="password" name="userPwd2" id="txtPwd" size="15">
			</td>
		  </tr>
		  <tr>
			<td colspan="2" align="center">
			  <input type="submit" value="삭제">&nbsp;&nbsp;
			  <input type="button" onClick="javascript:history.back();" value="이전으로">
			</td>
		  </tr>
		</table>
	</form>
</div>
</body>
</html>
