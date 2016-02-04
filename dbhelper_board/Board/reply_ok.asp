<!--#include File="DBHelper.asp"-->
<%
Dim objDBConn
Dim strSQL , adoRs
Dim intSeq , GotoPage , name,content,DBHelper

intSeq = Request.form("board_idx")
GotoPage = Request.form("GoTopage")
name = Request.form("txtName")
content = Request.form("txtContent")

 Set DBHelper = new clsDBHelper 
 DBHelper.ExecSQL "INSERT INTO comment(inx,Co_name,Co_date,Co_Content) VALUES ('"& intSeq &"','"& name &"',getdate(),'"& content &"')", Nothing, Nothing

 DBHelper.Dispose
 Set DBHelper = Nothing


'response.write "11111"
'response.End

Response.Redirect "content.asp?GotoPage=" & GotoPage & "&seq=" & intSeq

%>