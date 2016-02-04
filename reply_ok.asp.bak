<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"

Dim intSeq , GotoPage ,content,DBHelper

intSeq = Request.Form("board_idx")
GotoPage = Request.Form("page")
content = Request.Form("txtContent")
Catenm = Request.Form("Catenm")
Group_b = Request.Form("group_b")

'response.write intSeq
'response.write GotoPage
'response.write session("id")
'response.write content
'response.End 

Set DBHelper = new clsDBHelper 
   
Dim paramInfo(4)
paramInfo(0) = DBHelper.MakeParam("@intSeq",adInteger,adParamInput,4, intSeq)
paramInfo(1) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, session("id"))
paramInfo(2) = DBHelper.MakeParam("@strContent",adVarWChar,adParamInput,300, content)
paramInfo(3) = DBHelper.MakeParam("@CateNm",adVarWChar,adParamInput,50, Catenm)
paramInfo(4) = DBHelper.MakeParam("@Group",adInteger,adParamInput,4, Group_b)

Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Reply", paramInfo, Nothing)

'response.write rs(0)
'response.End

Select Case (rs(0))
 case 10
   response.write "10"
   rs.Close
   Set rs = Nothing
 case Else :
   response.write "<script language='javascript'>alert('알수 없는 오류입니다.');history.go(-1);</script>"
End Select

DBHelper.Dispose
Set DBHelper = Nothing

'Response.Redirect "content.asp?page=" & GotoPage & "&seq=" & intSeq

%>