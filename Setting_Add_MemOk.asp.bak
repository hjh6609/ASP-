<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
      Response.CharSet="utf-8"
	  Session.codepage="65001"
	  Response.codepage="65001"
	  Response.ContentType="text/html;charset=utf-8"
	  
	  Dim SeqNo , Grade
	  
	  SeqNo= Request.Form("seq") 
	  Grade= Request.Form("grade") 

	  'response.write SeqNo  &"</br>"
	  'response.write Grade
	  'response.End 

	  Set DBHelper = new clsDBHelper 	

	  Dim paramInfo(1)
	  paramInfo(0) = DBHelper.MakeParam("@SeqNo",adInteger,adParamInput,4, SeqNo)
	  paramInfo(1) = DBHelper.MakeParam("@GradeNo",adInteger,adParamInput,4, Grade)


	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Mem_Edit", paramInfo, Nothing)
	   
   'response.write rs(0)
   'response.End 

    Select Case (rs(0))
	   case 20	
		  response.write "20"    ' 등급 수정성공
		  rs.close
		  Set rs = Nothing 
	   case Else :
		 response.write "30"      '알수 없는 오류
    End Select

	DBHelper.Dispose
	Set DBHelper = Nothing
%>