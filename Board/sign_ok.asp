<!--#include File="DBHelper.asp"-->
<% 

   Dim objDBConn
   Dim strSQL
   Dim strId , strPwd , strSay
  
   strId   = Request.Form("txtid")
   strPwd  = Request.Form("txtpwd")
   strSay  = Request.Form("txtsay")

   '================= ���� �ҽ� ====================
   'Set DBHelper = new clsDBHelper 
   'DBHelper.ExecSQL "INSERT INTO SIGN_UP(UserID,UserPwd,UserContent,RcdDate) VALUES ('"& strId &"','"& strPwd &"','"& strSay &"',getdate())", Nothing, Nothing

   'DBHelper.Dispose
   'Set DBHelper = Nothing

   '================= ���� �ҽ� ====================

   'response.write strId
   'response.End 

   Set DBHelper = new clsDBHelper 	
  
   Dim paramInfo(2)
   paramInfo(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, strId)
   paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, strPwd)
   paramInfo(2) = DBHelper.MakeParam("@UserContent",adVarWChar,adParamInput,100, strSay)

   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_SignUp", paramInfo, Nothing)

   Select Case (rs(0))
     case 10
	   response.write "<script>alert('�̹� ����� �Դϴ�.');history.go(-1);</script>"
	   rs.Close
	   Set rs = Nothing
     case 20	
		response.write "<script>alert('��ϵǾ����ϴ�.');location.href='./login.asp';</script>"
		rs.close
		Set rs = Nothing 
     case Else :
       response.write "<script>alert('�˼� ���� �����Դϴ�.');history.go(-1);</script>"
   End Select

   DBHelper.Dispose
   Set DBHelper = Nothing
%>