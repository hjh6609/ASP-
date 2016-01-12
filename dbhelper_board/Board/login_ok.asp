<!--#include File="DBHelper.asp"-->
<%   
   Dim objDBConn , objRs , strSQL
   Dim  strRealId, id, pwd , bLoginSaved ,test

   id  = Trim(Request.Form("txtID"))
   pwd = Trim(Request.Form("txtPwd"))
   
   Set DBHelper = new clsDBHelper 	
   Set rs = DBHelper.ExecSQLReturnRS("SELECT * FROM SIGN_UP WHERE UserID =  '" & id & "'" , Nothing, Nothing)

   If rs.EOF or rs.BOF Then
	   response.write "<script>alert('존재하지 않는 아이디입니다.!\n\n아이디를 확인하세요!');history.go(-1);       </script>"
	 
	   rs.Close
	   Set rs = Nothing
	   DBHelper.Dispose
	   Set DBHelper = Nothing
   Else 
	   If Trim(rs("UserPwd")) <> pwd Then
       response.write "<script>alert('비밀번호가 틀립니다.\n\n비밀번호를 확인해 주세요!');history.go(-1); </script>"
	   Else 
		 session("id") = id
		 'response.write session("id")
		 'response.write id
		 If rs("Grade") = 1 Then
			Response.Redirect "list_ad.asp?myid="& id 
		 End if
	   rs.Close
	   Set rs = Nothing
	   DBHelper.Dispose
	   Set DBHelper = Nothing
	   'response.write id 
	   'test = "list.asp?myid="& id 
	   'response.write test
	   Response.Redirect "list.asp?myid="& id 
	   'Response.Redirect "list2.asp?myid="& id 
	   'Response.Redirect "content.asp?GotoPage=" & GotoPage & "&seq=" & intSeq
	   'response.write "<script>location.href='../list.asp';</script>"
       End If
   End If

%>
