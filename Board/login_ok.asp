<!--#include File="DBHelper.asp"-->
<%     
   Dim  strRealId, id, pwd 

   id  = Trim(Request.Form("txtID"))
   pwd = Trim(Request.Form("txtPwd"))
   
   Set DBHelper = new clsDBHelper 	
  
   Dim paramInfo(1)
   paramInfo(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, id)
   paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, pwd)

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
		Response.Redirect "list.asp"
		rs.close
		Set rs = Nothing
	case 40		'관리자
		session("id") = id
		'Response.Redirect "list_ad.asp?myid="& id	
		Response.Redirect "list_ad.asp"
		rs.close
		Set rs = Nothing
     case Else :
       response.write "<script>alert('알수 없는 오류입니다.');history.go(-1); </script>"
   End Select
   	
   DBHelper.Dispose
   Set DBHelper = Nothing
%>
