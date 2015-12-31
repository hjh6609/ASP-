<% Option Explicit 
  
   Dim objDBConn
   Dim strSQL
   Dim strID, strPassword, strEmail, strSubject, strContent
  
   strID       = Request.Form("userID")
   strPassword  = Request.Form("userPwd")
   strEmail        = "-"
   strSubject     = Request.Form("subject")
   strContent    = Request.Form("content")
	
   Set objDBConn = Server.CreateObject("ADODB.Connection")
   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   strSQL = " INSERT INTO board(strID,strPassword,strEmail,strSubject,strContent,WriteDate,WriteEnt) VALUES ("
   strSQL = strSQL & "'" & strID      & "',"
   strSQL = strSQL & "'" & strPassword    & "',"
   strSQL = strSQL & "'" & strEmail & "',"
   strSQL = strSQL & "'" & strSubject    & "',"
   strSQL = strSQL & "'" & strContent & "',"
   strSQL = strSQL & "getdate(),"
   strSQL = strSQL & "0)"  

   objDBConn.Execute strSQL

%>
<script language="javascript">

   alert("등록되었습니다");
   location.href="../list.asp";

</script> 