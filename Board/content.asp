
<%
Option Explicit

Dim objDBConn
Dim objRs
Dim strSQL 
Dim strName , strEmail, strSubject,strContent,intSeq , WriteDate, WriteEnt  

Dim Gotopage
GoTopage= request("GotoPage")

intSeq	= Request.QueryString("seq")

Set objDBConn = Server.CreateObject("ADODB.Connection")
Set objRs = Server.CreateObject("ADODB.RecordSet")

objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

strSQL = "Update board Set WriteEnt = WriteEnt + 1"
strSQL = strSQL & " Where inx = " & intSeq

Set objRs = objDBConn.execute(strSQL)

strSQL = "SELECT strID"                     ' objRs(0) - �̸�
strSQL = strSQL & ",strEmail"                 ' objRs(1) - �����ּ�
strSQL = strSQL & ",strSubject"               ' objRs(2) - ����
strSQL = strSQL & ",strContent"               ' objRs(3) - ����
strSQL = strSQL & ",WriteDate"               ' objRs(4) - ��¥
strSQL = strSQL & ",WriteEnt"               ' objRs(5) - ��ȸ��
strSQL = strSQL & " FROM board"
strSQL = strSQL & " WHERE inx = " + intSeq

objRs.Open strSQL, objDBConn

strName = objRs(0)
strEmail= objRs(1)
strSubject = objRs(2)
strContent = objRs(3)
WriteDate = objRs(4)
WriteEnt = objRs(5)

objRs.close


 '����۰� ����� Ŀ��Ʈ �о����
strSQL = "Select Co_name, Co_date, Co_Content from Comment where inx=" & intSeq
Set objRs = objDBConn.execute(strSQL)

Dim arrComment
if Not objRs.EOF then
  arrComment = objRs.GetString()
End if
objRs.close

objDbConn.Close
Set objDBConn = nothing

strContent = Replace(strContent, vbLf, vbLf & "<br>")
%>
<!DOCTYPE html>
<head>
<title>�Խ��� - ���뺸��</title>
<!-- Bootstrap core CSS -->
<link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

<script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>

<script>
	function addComment()
	{
		alert(1);
		var name = document.frmMent.txtName.value;
		if (CheckStr(name, " ", "")==0) {
		  alert("�̸��� �Է��� �ּ���");
		  document.frmMent.txtName.focus();
		  return;
		}
		alert(2);
		var content = document.frmMent.txtContent.value;
		if (CheckStr(content, " ", "")==0) {
		  alert("Ŀ��Ʈ ������ �Է��� �ּ���");
		  document.frmMent.txtContent.focus();
		  return;
		}
		alert(3);
		document.frmMent.submit();
	}

	function CheckStr(strOriginal, strFind, strChange){
		var position, strOri_Length;
		position = strOriginal.indexOf(strFind); 

		while (position != -1){
		  strOriginal = strOriginal.replace(strFind, strChange);
		  position = strOriginal.indexOf(strFind);
		}

		strOri_Length = strOriginal.length;
		return strOri_Length;
	  }
</script>
</head>
<body>
<div class="container">
	<div class="header">
		<nav>
		<ul class="nav nav-pills pull-right">
			<li role="presentation" class="active"><a href="javascript:alert('1')">Home</a></li>
			<li role="presentation"><a href="javascript:alert('2')">About</a></li>
			<li role="presentation"><a href="javascript:alert('3')">Contact</a></li>
		</ul>
		</nav>
		<h3 class="text-muted">First ASP Board</h3>
	</div>
	<table class="table table-striped">
	<tr>
		<td>�̸�</td>
		<td><%=strName%></td>
		<td>��ȸ��</td>
		<td colspan="3">
			<%If IsNull(WriteEnt) Then
			response.write "0"
			Else
			response.write(WriteEnt)
			End If %>
		</td>
	</tr>
	<tr>
		<td>Email</td>
		<td colspan="5"><a href="mailto:<%=strEmail%>"><%=strEmail%></a></td>
	</tr>
	<tr>
		<td>����</td>
		<td colspan="3"><%=strSubject%></td>
		<td>�����</td>
		<td colspan="3">
			<%If IsNull(WriteDate) Then
			response.write "��¥����"
			Else
			response.write(Replace(Mid(WriteDate,1,10),"-","."))
			End If %>
		</td>
	</tr>
	<tr>
		<td colspan="6" style="padding:15px;"><%=strContent%></td>
	</tr>
	<tr>
		<td colspan="6" align="center">
			<a href="edit.asp?seq=<%=intSeq%>">�����ϱ�</a>
			<a href="list.asp?gotopage=<%=gotopage%>">�������</a>
			<a href="delete.asp?seq=<%=intSeq%>">�����ϱ�</a>
		</td>
	</tr>
	</table>

	<form name="frmMent" action="reply_ok.asp" Method="post">
	  <table width="700" bgcolor="slategray" cellspacing="1">	
		<tr bgcolor="#eeeeee">
		  <td colspan=2>����� �����ּ���</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr bgcolor="white">
		  <INPUT class= "inputa" type="hidden" name= "GoTopage"value="<%=GoTopage%>">
		  <INPUT class= "inputa" type="hidden" name= "board_idx"value="<%=intSeq%>">
		  <td>�̸� : <INPUT class="inputa" name="txtName" size="7"></td>
		  <td align="center">
			��Ʈ : 
			<INPUT class="inputa" name="txtContent" size="50" maxlength="200">
			<Input class="buttona" type="button" onClick="addComment();" value="����">
		  </td>
		</tr>
	  </table>
	</form>

	<%
	  if arrComment <> "" then
		Dim arrRecord, arrColumn, inum
		arrRecord = Split(arrComment,chr(13))
	%>
	  <br><font size=2><b>Comment</b></font>
	  <table width="700" bgcolor="slategray" cellspacing="1" border="0">	
	<% 
	  for inum=0 to Ubound(arrRecord)-1
		arrColumn = Split(arrRecord(inum), Chr(9))
	%>
		<tr bgcolor="white">
		  <td><%= arrColumn(0)%>(<%=arrColumn(1)%>)</br><%=arrColumn(2)%>
		  </td>
		</tr>
	  <%next %>
	  </table>
	<%
	end if%>

	<footer class="footer">
	<p>&copy; ASP Board. 201512 </p>
	</footer>
</div>
</body>
</html>
