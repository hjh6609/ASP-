<!--#include File="DBHelper.asp"-->
<% 
   Dim strID, strPassword, strSubject, strContent ,myid
  
   strID       = Request.Form("userID")
   strPassword  = Request.Form("userPwd")
   strSubject     = Request.Form("subject")
   strContent    = Request.Form("content")
   myid = session("id")
	
   '============================== 원래소스 ========================
   'Set DBHelper = new clsDBHelper 
   'DBHelper.ExecSQL "INSERT INTO board(strID,strPassword,strSubject,strContent,WriteDate,WriteEnt,strNotice) VALUES ('"& strID &"','"& strPassword &"','"& strNotice &"','"& strSubject &"','"& strContent &"',getdate(),0)", Nothing, Nothing

   'DBHelper.Dispose
   'Set DBHelper = Nothing
   '============================== 원래소스 ========================

   Set DBHelper = new clsDBHelper 
   
   Dim paramInfo(3)
   paramInfo(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, myid)
   paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, strPassword)
   paramInfo(2) = DBHelper.MakeParam("@strSubject",adVarWChar,adParamInput,50, strSubject)
   paramInfo(3) = DBHelper.MakeParam("@strContent",adVarWChar,adParamInput,300, strContent)

   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Regist", paramInfo, Nothing)

   Select Case (rs(0))
     case 10
	   response.write "<script>alert('등록 되었습니다.');location.href='./list.asp';</script>"
	   rs.Close
	   Set rs = Nothing
     case Else :
       response.write "<script>alert('알수 없는 오류입니다.');history.go(-1);</script>"
   End Select

   DBHelper.Dispose
   Set DBHelper = Nothing

%>