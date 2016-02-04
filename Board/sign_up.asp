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
	
	var Overlap = false;   //아이디 중복확인 버튼

	$(document).ready(function(){
	
		$("#board").click(function(){
		
			 alert("로그인한 사용자만 사용가능 합니다.");
		});

		//이메일 중복검사
		$("#btnEnter").click(function(){
			Overlap = true;
			var id = $("#txtidVal").val();
			var regex= /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			//var rehan = /^([a-zA-Z0-9]{1,20})$/;

			if(!id)
			{
				alert("이메일을 입력해 주세요:-)");
				$("#txtidVal").focus();
				return false;
			}
			else if(id.search(regex) == -1)
			{
				alert("이메일 형식에 맞게 입력해 주세요.");
				$("#txtidVal").focus();
				return false;
			}

			console.log("1111");
			$.ajax({
				type: "POST",
				url: "check_id.asp", //이페이지에서 중복체크를 한다
				data:({"id":id}),
				cache: false,
				dataType: "text",
				success: function(data){
					//alert(data);
					//return;
					if(data == "true")
					{
						$("#loadtext").html("사용가능합니다."); //해당 내용을 보여준다
					}
					else if(data == "null")
					{
						alert("이메일을 입력해 주세요.");
						return;
					}
					else
					{
						$("#loadtext").html("이미 사용중 입니다."); //해당 내용을 보여준다
					}
				}
			});
		});
	
	});

	
	function Confirm()
	{
		if(document.SignForm.txtid.value==''){
		  alert("이메일을 입력해 주세요.");
		  document.SignForm.txtid.focus();
		}else if(document.SignForm.txtpwd.value==''){
		  alert("비밀번호를 입력하세요.");    
		  document.SignForm.txtpwd.focus();
		}else if(document.SignForm.txtsay.value=='')
		{
		  alert("하고싶은 말을 입력하세요.");    
		  document.SignForm.txtsay.focus();
		}
		else{
		   //중복확인 버튼 안 눌렀으면
		   if(Overlap == false)
		   {
				alert("이메일 중복검사를 해주세요.");
				return false;
		   }  
			//비밀번호 유효성 검사
			else if(!$("#txtpwd").val())
			{
				//비밀번호 길이 체크(4~8자 까지 허용)
				if (document.SignForm.txtpwd.value.length<4 || document.SignForm.txtpwd.value.length>8)
				{
					 alert ("비밀번호를 4~8자까지 입력해주세요.");
					 document.SignForm.txtpwd.focus()
					 return false;
				}

			}
		   document.SignForm.submit(); 
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
					<li role="presentation"><a href="/list.asp" id="board">Board</a></li>
					<li role="presentation"><a href="/login.asp">Login</a></li>
					<li role="presentation" class="active"><a href="/sign_up.asp">Sign Up</a></li>
				  </ul>
			 </nav>
				<h3 class="text-muted">First ASP BOARD</h3>
			</div>
			<form name="SignForm" method= "post" action="sign_ok.asp" onSubmit="Confirm();return false">
				<h5 align ="center">회원가입</h5>
				<table class="table" style="width:500px;" align="center">
					<tr>
						<td>이메일</td>
						<td><input type="txt" name="txtid" id ="txtidVal"></td>
						<td><input type="button" value="중복확인" id="btnEnter"><p><div id="loadtext"></p></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td  colspan="3"><input type="password" name="txtpwd"></td>
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

