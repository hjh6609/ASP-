<% Option Explicit 
  
   Dim objDBConn
   Dim strSQL
   Dim strName, strPassword, strEmail, strSubject, strContent
  
   strName       = Request.Form("userName")
   strPassword  = Request.Form("userPwd")
   strEmail        = Request.Form("userEmail")
   strSubject     = Request.Form("subject")
   strContent    = Request.Form("content")
	
   Set objDBConn = Server.CreateObject("ADODB.Connection")
   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   strSQL = " INSERT INTO board(strName, strPassword, strEmail, strSubject, strContent) VALUES ("
   strSQL = strSQL & "'" & strName      & "',"
   strSQL = strSQL & "'" & strEmail       & "',"
   strSQL = strSQL & "'" & strPassword & "',"
   strSQL = strSQL & "'" & strSubject    & "',"
   strSQL = strSQL & "'" & strContent &     "')"

   objDBConn.Execute strSQL

%>
<script language="javascript">

   alert("등록되었습니다");
   location.href="../list.asp";

</script> 