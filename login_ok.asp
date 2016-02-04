<%@Language="VBScript" CODEPAGE="65001" %>
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"

	Response.CharSet="utf-8"
	Session.codepage="65001"
	Response.codepage="65001"
	Response.ContentType="text/html;charset=utf-8"
%>
<!--#include File="DBHelper.asp"-->
<%     
   Dim  strRealId, id, pwd 

   id  = Trim(Request.Form("txtID"))
   pwd = Trim(Request.Form("txtPwd"))

   'response.write id  & "dddddddddd"
   'response.End 
   
   Set DBHelper = new clsDBHelper 	

   Dim paramInfo(1)
   paramInfo(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, id)
   paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, pwd)

	'디비 비번 변경문제.
	if err.number = 0 then 
		response.Write "<script>alert('로그인 에러가 발생했습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
   End If 
  

   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Login", paramInfo, Nothing)

   'response.write rs(0)
   'response.End
   Select Case (rs(0))
     case 10
	   response.write "<script>alert('존재하지 않는 아이디입니다.!\n\n아이디를 확인하세요!');history.go(-1);       </script>"
	   rs.Close
	   Set rs = Nothing
     case 20
		response.write "<script>alert('비밀번호가 틀립니다.\n\n비밀번호를 확인해 주세요!');history.go(-1); </script>"
		rs.close
		Set rs = Nothing 
     case 30	'사용자
		session("id") = id
		'Response.Redirect "list.asp?myid="& id	
		Response.Redirect "list2.asp"
		rs.close
		Set rs = Nothing
	case 40		'관리자
		session("id") = id
		'Response.Redirect "list_ad.asp?myid="& id	
		'Response.Redirect "list_ad.asp"
		Response.Redirect "list2.asp"
		rs.close
		Set rs = Nothing
     case Else :
       response.write "<script>alert('알수 없는 오류입니다.');history.go(-1); </script>"
   End Select
   	
   DBHelper.Dispose
   Set DBHelper = Nothing
%>
