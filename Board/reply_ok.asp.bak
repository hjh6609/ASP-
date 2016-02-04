<!--#include File="DBHelper.asp"-->
<%
Dim objDBConn
Dim strSQL , adoRs
Dim intSeq , GotoPage , name,content,DBHelper

intSeq = Request.form("board_idx")
GotoPage = Request.form("GoTopage")
name = Request.form("txtName")
content = Request.form("txtContent")

'If session("id") = "" Then
'	response.redirect "login.asp"
'End if

Set DBHelper = new clsDBHelper 
   
Dim paramInfo(2)
paramInfo(0) = DBHelper.MakeParam("@intSeq",adInteger,adParamInput,4, intSeq)
paramInfo(1) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, session("id"))
paramInfo(2) = DBHelper.MakeParam("@strContent",adVarWChar,adParamInput,300, content)

Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Reply", paramInfo, Nothing)

Select Case (rs(0))
 case 10
   response.write "<script>alert('등록 되었습니다.');"
   rs.Close
   Set rs = Nothing
 case Else :
   response.write "<script>alert('알수 없는 오류입니다.');history.go(-1);</script>"
End Select

DBHelper.Dispose
Set DBHelper = Nothing


'response.write "11111"
'response.End

Response.Redirect "content.asp?GotoPage=" & GotoPage & "&seq=" & intSeq

%>