<!Doctype html>
<head>
	<title>Reple</title>
	<!-- Bootstrap core CSS -->
	<link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

	<script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
</head>
<body>
	<form name="ReplyForm" method="post" action="reply_ok.asp?seq=<%=intSeq%>">
		<table table>
			<tr>
				<td>�г���</td>
				<td colspan="3"><input type="text" name="strName"></td>
			</tr>
			<tr>
				<td>��й�ȣ</td>
				<td colspan="3"><input type="text" name="strPwd"></td>
			</tr>
			<tr>
				<td>����</td>
				<td><textarea name="content" cols="35" rows="0" name="strContent"></textarea></td>
				<td><input type="submit" value="�ۼ� �Ϸ�"></td>
			</tr>
		</table>
	</form>
</body>
</html>