<!--#include File="DBHelper.asp"-->
<% 
   Dim objDBConn
   Dim strSQL
   Dim strID, strPassword, strNotice, strSubject, strContent
  
   strID       = Request.Form("userID")
   strPassword  = Request.Form("userPwd")
   strNotice        = "-"
   strSubject     = Request.Form("subject")
   strContent    = Request.Form("content")
	
   Set DBHelper = new clsDBHelper 
   DBHelper.ExecSQL "INSERT INTO board(strID,strPassword,strNotice,strSubject,strContent,WriteDate,WriteEnt) VALUES ('"& strID &"','"& strPassword &"','"& strNotice &"','"& strSubject &"','"& strContent &"',getdate(),0)", Nothing, Nothing

   DBHelper.Dispose
   Set DBHelper = Nothing

%>
<script language="javascript">

   alert("등록되었습니다");
   location.href="./list.asp";

</script> 