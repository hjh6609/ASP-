<!--#include File="DBHelper.asp"-->
<% 
   Dim objDBConn , objRs , strSQL
   Dim id  , rs ,MemberCnt 
  
   id  = Request.Form("id")
 	
   Set DBHelper = new clsDBHelper 	
   Set rs = DBHelper.ExecSQLReturnRS("SELECT COUNT(USERID) AS 'check' FROM SIGN_UP WHERE UserID =  '" & id & "'" , Nothing, Nothing)
   
   'response.write	"1111"
   'response.write rs("check")
   'response.end

   MemberCnt = rs("check")
   
   if MemberCnt = 0 then 
        Response.Write("true")
    else 
        Response.Write("false")
    end if 
    
   rs.Close
   Set rs = Nothing
   DBHelper.Dispose
   Set DBHelper = Nothing

%>
