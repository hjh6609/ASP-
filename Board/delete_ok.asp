<!--#include File="DBHelper.asp"-->
<!-- 
<%
	  '=============================== ���� �ҽ� =======================
	  

      intSeq = Request.QueryString("seq")
      strPassword = Request.Form("userPwd")
	  

	  'Set DBHelper = new clsDBHelper 	
      'Set rs = DBHelper.ExecSQLReturnRS("SELECT strPassword FROM board WHERE inx = " & intSeq , Nothing, Nothing)
      'strRealPassword = rs("strPassword")

      'rs.Close
      'Set rs = Nothing
      'DBHelper.Dispose
      'Set DBHelper = Nothing

      'If strRealPassword <> strPassword Then

%>
<script language="javascript">

      alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
      history.back();

</script>

<%

'		  Response.End
'      End If
'
'      Set DBHelper = new clsDBHelper 
'	  DBHelper.ExecSQL "DELETE FROM board WHERE inx='"& intSeq &"'" , Nothing , Nothing
'	  
'	  DBHelper.Dispose
'      Set DBHelper = Nothing
%>

<script language="javascript">

      alert("�����Ǿ����ϴ�");
      location.href="list.asp";

</script>
-->

<%
      Dim intSeq 

      intSeq = Request.QueryString("seq")
      strPassword = Request.Form("userPwd")

	  Set DBHelper = new clsDBHelper 	
  
	  Dim paramInfo(1)
	  paramInfo(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)
	  paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, strPassword)

	  Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Delete", paramInfo, Nothing)

	  Select Case (rs(0))
		 case 10
		   response.write "<script>alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�');history.go(-1);</script>"
		   rs.Close
		   Set rs = Nothing
		 case 20	
			response.write "<script>alert('���� �������� �ʽ��ϴ�.');history.go(-1);</script>"
			rs.close
			Set rs = Nothing
		 case 30	
			response.write "<script>alert('�����Ǿ����ϴ�');location.href='./list.asp';</script>"
			rs.close
			Set rs = Nothing 
		 case Else :
		   response.write "<script>alert('�˼� ���� �����Դϴ�.');history.go(-1);</script>"
	  End Select

	  DBHelper.Dispose
	  Set DBHelper = Nothing
%>

