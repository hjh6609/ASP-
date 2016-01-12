<!--#include File="DBHelper.asp"-->
<% 
   Dim objDBConn , objRs , strSQL
   Dim id  , rs ,MemberCnt 
  
   id  = Request.Form("id")
	
   'response.write id
   'response.end
 	
   If id ="" Then 
		response.write "null"
   Else
		Set DBHelper = new clsDBHelper 	
	    Set rs = DBHelper.ExecSQLReturnRS("SELECT COUNT(USERID) AS 'check' FROM SIGN_UP WHERE UserID =  '" & id & "'" , Nothing, Nothing)
	   
	   'response.write	"</br>1111</br>"
	   'response.write rs("check")
	   'response.write id
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
	End If 

%>
