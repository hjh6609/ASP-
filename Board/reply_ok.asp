<% Option Explicit %>
<%
Dim objDBConn
Dim strSQL , adoRs
Dim intSeq , GotoPage , name,content
intSeq = Request.form("board_idx")
GotoPage = Request.form("GotoPage")
name = Request.form("txtName")
content = Request.form("txtContent")

 Set objDBConn = Server.CreateObject("ADODB.Connection")
 objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   strSQL = " INSERT INTO comment(inx,Co_name,Co_date,Co_Content) VALUES ("
   strSQL = strSQL & "'" & intSeq  & "',"
   strSQL = strSQL & "'" & name   & "',"
   strSQL = strSQL & "getdate(),"
   strSQL = strSQL & "'" & content       & "')"

   objDBConn.Execute strSQL

Set objDBConn = nothing
Response.Redirect "content.asp?GotoPage=" & GotoPage & "&seq=" & intSeq
%>