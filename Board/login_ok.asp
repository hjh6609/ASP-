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
	   response.write "<script>alert('�������� �ʴ� ���̵��Դϴ�.!\n\n���̵� Ȯ���ϼ���!');history.go(-1);       </script>"
	   
       objRs.Close
       objDBConn.close
       Set objRs = Nothing
       Set objDBConn = nothing
   Else 
	   If Trim(objRs("UserPwd")) <> pwd Then
       response.write "<script>alert('��й�ȣ�� Ʋ���ϴ�.\n\n��й�ȣ�� Ȯ���� �ּ���!');history.go(-1); </script>"
	   Else 
		 session("id") = id
		 'response.write session("id")
		 If objRs("Grade") = 1 Then
			response.write "<script>location.href='../list_ad.asp';</script>"
		 End if
	   objRs.close
       objDBConn.close
	   Set objRs = Nothing
	   Set objDBConn = Nothing
	   response.write "<script>location.href='../list.asp';</script>"
       End If
   End If
   
   '���̽��� �α���

%>
