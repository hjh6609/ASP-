<% 
   Option Explicit 
  
   Dim objDBConn , objRs , strSQL
   Dim  strRealId, id, pwd , bLoginSaved 

   id  = Trim(Request.Form("txtID"))
   pwd = Trim(Request.Form("txtPwd"))
	
   Set objDBConn = Server.CreateObject("ADODB.Connection")
   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"
   
   strSQL="SELECT * FROM SIGN_UP WHERE UserID =  '" & id & "'"
   set objRs = objDBConn.execute(strSQL)

   If objRs.EOF or objRs.BOF Then
	   response.write "<script>alert('존재하지 않는 아이디입니다.!\n\n아이디를 확인하세요!');history.go(-1);       </script>"
	   
       objRs.Close
       objDBConn.close
       Set objRs = Nothing
       Set objDBConn = nothing
   Else 
	   If Trim(objRs("UserPwd")) <> pwd Then
       response.write "<script>alert('비밀번호가 틀립니다.\n\n비밀번호를 확인해 주세요!');history.go(-1); </script>"
	   Else 
		 session("id") = id
		 'response.write session("id")
	   objRs.close
       objDBConn.close
	   Set objRs = Nothing
	   Set objDBConn = Nothing
	   response.write "<script>location.href='../list.asp';</script>"
       End If
   End if
%>
