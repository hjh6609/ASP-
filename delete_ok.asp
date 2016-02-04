<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
      Response.CharSet="utf-8"
	  Session.codepage="65001"
	  Response.codepage="65001"
	  Response.ContentType="text/html;charset=utf-8"

	  Dim intSeq ,strPassword

	  strPassword = Request.Form("userPwd2")
      intSeq = Request.QueryString("seq")

      'response.write strPassword & "</br>"
	  'response.write intSeq
	  'response.write "1111111"
	  'response.End 

	  Set DBHelper = new clsDBHelper 	
  
	  Dim paramInfo(1)
	  paramInfo(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)
	  paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, strPassword)

	  Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Delete", paramInfo, Nothing)

	  Select Case (rs(0))
		 case 10
		   response.write "<script>alert('비밀번호가 일치하지 않습니다');history.go(-1);</script>"
		   rs.Close
		   Set rs = Nothing
		 case 20	
			response.write "<script>alert('글이 존재하지 않습니다.');history.go(-1);</script>"
			rs.close
			Set rs = Nothing
		 case 30	
			response.write "<script>alert('삭제되었습니다');location.href='./list.asp';</script>"
			rs.close
			Set rs = Nothing 
		 case Else :
		   response.write "<script>alert('알수 없는 오류입니다.');history.go(-1);</script>"
	  End Select

	  DBHelper.Dispose
	  Set DBHelper = Nothing
%>

