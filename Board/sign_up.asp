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
	<title>ȸ������</title>
	<!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
	
	<script>
	
	var Overlap = false;   //���̵� �ߺ�Ȯ�� ��ư

	$(document).ready(function(){
	
		$("#board").click(function(){
		
			 alert("�α����� ����ڸ� ��밡�� �մϴ�.");
		});

		//�̸��� �ߺ��˻�
		$("#btnEnter").click(function(){
			Overlap = true;
			var id = $("#txtidVal").val();
			var regex= /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			//var rehan = /^([a-zA-Z0-9]{1,20})$/;

			if(!id)
			{
				alert("�̸����� �Է��� �ּ���:-)");
				$("#txtidVal").focus();
				return false;
			}
			else if(id.search(regex) == -1)
			{
				alert("�̸��� ���Ŀ� �°� �Է��� �ּ���.");
				$("#txtidVal").focus();
				return false;
			}

			console.log("1111");
			$.ajax({
				type: "POST",
				url: "check_id.asp", //������������ �ߺ�üũ�� �Ѵ�
				data:({"id":id}),
				cache: false,
				dataType: "text",
				success: function(data){
					//alert(data);
					//return;
					if(data == "true")
					{
						$("#loadtext").html("��밡���մϴ�."); //�ش� ������ �����ش�
					}
					else if(data == "null")
					{
						alert("�̸����� �Է��� �ּ���.");
						return;
					}
					else
					{
						$("#loadtext").html("�̹� ����� �Դϴ�."); //�ش� ������ �����ش�
					}
				}
			});
		});
	
	});

	
	function Confirm()
	{
		if(document.SignForm.txtid.value==''){
		  alert("�̸����� �Է��� �ּ���.");
		  document.SignForm.txtid.focus();
		}else if(document.SignForm.txtpwd.value==''){
		  alert("��й�ȣ�� �Է��ϼ���.");    
		  document.SignForm.txtpwd.focus();
		}else if(document.SignForm.txtsay.value=='')
		{
		  alert("�ϰ����� ���� �Է��ϼ���.");    
		  document.SignForm.txtsay.focus();
		}
		else{
		   //�ߺ�Ȯ�� ��ư �� ��������
		   if(Overlap == false)
		   {
				alert("�̸��� �ߺ��˻縦 ���ּ���.");
				return false;
		   }  
			//��й�ȣ ��ȿ�� �˻�
			else if(!$("#txtpwd").val())
			{
				//��й�ȣ ���� üũ(4~8�� ���� ���)
				if (document.SignForm.txtpwd.value.length<4 || document.SignForm.txtpwd.value.length>8)
				{
					 alert ("��й�ȣ�� 4~8�ڱ��� �Է����ּ���.");
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
				<h5 align ="center">ȸ������</h5>
				<table class="table" style="width:500px;" align="center">
					<tr>
						<td>�̸���</td>
						<td><input type="txt" name="txtid" id ="txtidVal"></td>
						<td><input type="button" value="�ߺ�Ȯ��" id="btnEnter"><p><div id="loadtext"></p></td>
					</tr>
					<tr>
						<td>��й�ȣ</td>
						<td  colspan="3"><input type="password" name="txtpwd"></td>
					</tr>
					<tr>
						<td>�ϰ�������</td>
						<td colspan="3"><textarea cols="30" rows="10" name="txtsay"></textarea></td>
					</tr>
					<tr>
						<td colspan="3" align="center">
							<input type="submit" value="��� �Ϸ�">&nbsp;&nbsp;&nbsp;
							<input type="reset" value="�ٽ� �ۼ�">
						</td>
					</tr>
				</table>
			</form>
	   </div>
	</body>
</html>
