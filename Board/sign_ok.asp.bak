<% 
   Option Explicit 
  
   Dim objDBConn
   Dim strSQL
   Dim strId , strPwd , strSay
  
   strId   = Request.Form("txtid")
   strPwd  = Request.Form("txtpwd")
   strSay  = Request.Form("txtsay")
	
   Set objDBConn = Server.CreateObject("ADODB.Connection")
   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   strSQL = " INSERT INTO SIGN_UP(UserID,UserPwd,UserContent) VALUES ("
   strSQL = strSQL & "'" & strId      & "',"
   strSQL = strSQL & "'" & strPwd       & "',"
   strSQL = strSQL & "'" & strSay & "')"

   objDBConn.Execute strSQL

%>
<script language="javascript">

   alert("등록되었습니다");
   location.href="../login.asp";

</script> 