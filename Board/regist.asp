<%
	myid = Request.QueryString("myid")
	Gotopage =  Request.QueryString("page")
%>
<!DOCTYPE html>
<head>
	<title>�۾���</title>
	<!-- Bootstrap core CSS -->
	<link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

	<script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	
	<script type="text/javascript">
	
	/*
	function Confirm()
	{
		if(document.registForm.userPwd.value==''){
		  alert("��й�ȣ�� �Է��ϼ���.");
		  document.registForm.userPwd.focus();
		}else if(document.registForm.subject.value==''){
		  alert("������ �Է��ϼ���.");    
		  document.registForm.subject.focus();
		}else if(document.registForm.content.value=='')
		{
		  alert("������ �Է��ϼ���.");    
		  document.registForm.content.focus();
		}
		else{
		   document.registForm.submit(); 
		   return true;
		}
	}
	*/

	function Confirm()
	{
		if(document.registForm.subject.value==''){
		  alert("������ �Է��ϼ���.");    
		  document.registForm.subject.focus();
		}else if(document.registForm.content.value=='')
		{
		  alert("������ �Է��ϼ���.");    
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
				<td colspan="2" align="center"><b>���� �����ּ���</b></td>
			</tr>
			<!-- 
			<tr>
				<td align="center">���̵�</td>
				<td><input type="text" name="userID" size="15" value="<%=myid%>"></td>
			</tr>
			-->
			<tr>
				<td align="center">��й�ȣ</td>
				<td><input type="password" name="userPwd" size="15"></td>
			</tr>
			<tr>
				<td align="center">����</td>
				<td><input type="text" name="subject" size="50"></td>
			</tr>
			<tr>
				<td align="center">����</td>
				<td><textarea name="content" cols="50" rows="10"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="�ۼ� �Ϸ�">
					<!-- <a href="/list.asp?myid=<%=myid%>&page="<%=Gotopage%>><input type="button" value="�������"></a> -->
					<input type="reset" value="�ٽ� �ۼ�">
				</td>
			</tr>
		</table>
   </form>
</div>
</body>
</html>