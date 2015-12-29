<% 
   Option Explicit 
  
   Dim objDBConn , objRs , strSQL
   Dim id  , rs ,MemberCnt 
  
   id  = Request.Form("id")
 	
   Set objDBConn = Server.CreateObject("ADODB.Connection")
   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   strSQL="SELECT COUNT(USERID) FROM SIGN_UP WHERE UserID =  '" & id & "'"

   MemberCnt = objDBConn.execute(strSQL) 
   
   if MemberCnt(0) = 0 then 
        Response.Write("true")
    else 
        Response.Write("false")
    end if 
    Set objDBConn = nothing 

%>
