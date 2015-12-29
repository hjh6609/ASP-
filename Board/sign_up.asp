<%
   Option Explicit

   Dim objDBConn
   Dim objRs
   Dim strSQL

   Set objDBConn = Server.CreateObject("ADODB.Connection")
   Set objRs = Server.CreateObject("ADODB.RecordSet")

   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"
%>
<!Doctype html>
<head>
	<title>회원가입</title>
	<!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
	
	<script>
	
	$(document).click(function(){
		//아이디 중복검사
		$("#btnEnter").click(function(){
			var id = $('#txtidVal').val();
			$.ajax({
				type: "POST",
				url: "check_id.asp", //이페이지에서 중복체크를 한다
				data: "id="+ id ,//test.asp에 id 값을 보낸다
				cache: false,
				success: function(data){
					//alert(data);
					if(data == "true")
					{
						$("#loadtext").html("사용가능합니다."); //해당 내용을 보여준다
					}
					else
					{
						$("#loadtext").html("이미 사용중 입니다."); //해당 내용을 보여준다
					}
				}
			});
		});

	});
	
	</script>
</head>
	<body>
	 <div class="container">
		  <div class="header">
			 <nav>
				  <ul class="nav nav-pills pull-right">
					<li role="presentation"><a href="/list.asp">Board</a></li>
					<li role="presentation" class="active"><a href="/sign_up.asp">Sign Up</a></li>
				  </ul>
			 </nav>
				<h3 class="text-muted">First ASP BOARD</h3>
			</div>
			<form name="SignForm" method= "post" action="sign_ok.asp">
				<h5 align ="center">회원가입</h5>
				<table class="table" style="width:500px;" align="center">
					<tr>
						<td>아이디</td>
						<td><input type="txt" name="txtid" id ="txtidVal"></td>
						<td><input type="button" value="중복확인" id="btnEnter"><p><div id="loadtext"></p></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td colspan="3"><input type="password" name="txtpwd"></td>
					</tr>
					<tr>
						<td>하고싶은말</td>
						<td colspan="3"><textarea cols="30" rows="10" name="txtsay"></textarea></td>
					</tr>
					<tr>
						<td colspan="3" align="center">
							<input type="submit" value="등록 완료">&nbsp;&nbsp;&nbsp;
							<input type="reset" value="다시 작성">
						</td>
					</tr>
				</table>
			</form>
	   </div>
	</body>
</html>

