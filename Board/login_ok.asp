<!--#include File="DBHelper.asp"-->
<%     
   Dim  strRealId, id, pwd 

   id  = Trim(Request.Form("txtID"))
   pwd = Trim(Request.Form("txtPwd"))
   
   Set DBHelper = new clsDBHelper 	
  
   Dim paramInfo(1)
   paramInfo(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, id)
   paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, pwd)

   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Login", paramInfo, Nothing)

   'response.write rs(0)
   'response.End
   Select Case (rs(0))
     case 10
	   response.write "<script>alert('�������� �ʴ� ���̵��Դϴ�.!\n\n���̵� Ȯ���ϼ���!');history.go(-1);       </script>"
	   rs.Close
	   Set rs = Nothing
     case 20
		response.write "<script>alert('��й�ȣ�� Ʋ���ϴ�.\n\n��й�ȣ�� Ȯ���� �ּ���!');history.go(-1); </script>"
		rs.close
		Set rs = Nothing 
     case 30	'�����
		session("id") = id
		'Response.Redirect "list.asp?myid="& id	
		Response.Redirect "list.asp"
		rs.close
		Set rs = Nothing
	case 40		'������
		session("id") = id
		'Response.Redirect "list_ad.asp?myid="& id	
		Response.Redirect "list_ad.asp"
		rs.close
		Set rs = Nothing
     case Else :
       response.write "<script>alert('�˼� ���� �����Դϴ�.');history.go(-1); </script>"
   End Select
   	
   DBHelper.Dispose
   Set DBHelper = Nothing
%>
