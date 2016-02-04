<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<% 
   Response.CharSet="utf-8"
   Session.codepage="65001"
   Response.codepage="65001"
   Response.ContentType="text/html;charset=utf-8"
   
   Dim objDBConn
   Dim strSQL
   Dim strId , strPwd , strSay
  
   strId   = Request.Form("txtid")
   strPwd  = Request.Form("txtpwd")
   strSay  = Request.Form("txtsay")

   Set DBHelper = new clsDBHelper 	
  
   Dim paramInfo(2)
   paramInfo(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, strId)
   paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, strPwd)
   paramInfo(2) = DBHelper.MakeParam("@UserContent",adVarWChar,adParamInput,100, strSay)

   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_SignUp", paramInfo, Nothing)

   Select Case (rs(0))
     case 10
	   response.write "<script>alert('이미 사용중 입니다.');history.go(-1);</script>"
	   rs.Close
	   Set rs = Nothing
     case 20	
		response.write "<script>alert('등록되었습니다.');location.href='./login.asp';</script>"
		rs.close
		Set rs = Nothing 
     case Else :
       response.write "<script>alert('알수 없는 오류입니다.');history.go(-1);</script>"
   End Select

   DBHelper.Dispose
   Set DBHelper = Nothing
%>