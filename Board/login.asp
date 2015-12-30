<!Doctype html>
<head>
	<title>Login</title>
	<!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
</head>
<body>
 <div class="container">
	  <div class="header">
		 <nav>
			  <ul class="nav nav-pills pull-right">
				<li role="presentation"><a href="/list.asp">Board</a></li>
				<li role="presentation" class="active"><a href="/login.asp">Login</a></li>
				<li role="presentation"><a href="/sign_up.asp">Sign Up</a></li>
			  </ul>
		 </nav>
			<h3 class="text-muted">First ASP BOARD</h3>
		</div>
		<form name="FormLogin" method="post" action="login_ok.asp">
			<table table align="center" border="0">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="txtID"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="txtPwd"></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><input type="submit" value="Login"></td>
				</tr>
			</table>
		</form>
 </div>
</body>
</html>