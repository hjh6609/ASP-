<%
	Option Explicit 
  
    Dim objDBConn ,objRs
    Dim strSQL
    Dim strId , strPwd , strSay 

	strId = trim(request.form("fuid"))
    strPwd = trim(request.form("ffirst_name"))
    strSay = trim(request.form("flocale"))

	Set objDBConn = Server.CreateObject("ADODB.Connection")
    objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"
	
   strSQL="SELECT * FROM SIGN_UP WHERE UserID =  '" & strId & "'"
   set objRs = objDBConn.execute(strSQL)

   If objRs.EOF or objRs.BOF Then
	 '아이디 없을 때만 저장
	  strSQL = " INSERT INTO SIGN_UP(UserID,UserPwd,UserContent, RcdDate) VALUES ("
	  strSQL = strSQL & "'" & strId      & "',"
	  strSQL = strSQL & "'" & strPwd       & "',"
	  strSQL = strSQL & "'1',"
	  strSQL = strSQL & "getdate())"
	  objDBConn.Execute strSQL

	  'response.write "<script>location.href='/list.asp';</script>"

   Else '아이디가 있으면
	  session("id") = strId
	  objRs.close
      objDBConn.close
	  Set objRs = Nothing
	  Set objDBConn = Nothing
	  response.write "<script>location.href='/list.asp';</script>"
   End If
   
  
%>

<script language="javascript">

   alert("등록되었습니다");
   location.href="/list.asp";

</script> 
