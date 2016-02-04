<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
      Response.CharSet="utf-8"
	  Session.codepage="65001"
	  Response.codepage="65001"
	  Response.ContentType="text/html;charset=utf-8"

	  Dim intSeq 
      Dim strSubject, strContent
      Dim strRealPassword, strPassword

      intSeq = Request.QueryString("seq")
	  strPassword = Request.Form("userPwd")
      strSubject = Request.Form("subject")
      strContent = Request.Form("content")
	  txtCateNm = Request.Form("txtCatenm")
	  
	  'response.write intSeq
	  'response.write strPassword
	  'response.write strSubject
	  'response.write strContent
	  'response.End 
	
      Set DBHelper = new clsDBHelper 	
  
	  Dim paramInfo(3)
	  paramInfo(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)
	  paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, strPassword)
	  paramInfo(2) = DBHelper.MakeParam("@strSubject",adVarWChar,adParamInput,50, strSubject)
	  paramInfo(3) = DBHelper.MakeParam("@strContent",adVarWChar,adParamInput,300, strContent)

	  Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Edit", paramInfo, Nothing)

	  'response.write  rs(0)
	  'response.End 
	  
	  Select Case (rs(0))
		 case 10
		   response.write "<script>alert('비밀번호가 일치하지 않습니다');history.go(-1);</script>"
		   rs.Close
		   Set rs = Nothing
		 case 20	
			response.write "<script>alert('수정되었습니다.');location.href='/MultiBoard.asp?page=1&categoryNm="+ txtCateNm +"';</script>"
			'response.write "11";
			rs.close
			Set rs = Nothing
		 case Else :
		   response.write "<script>alert('알수 없는 오류입니다.');history.go(-1);</script>"
	  End Select

	  DBHelper.Dispose
	  Set DBHelper = Nothing

%>