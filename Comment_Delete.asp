<!--#include File="DBHelper.asp"-->
<%
	  Dim intSeq 

      intSeq = Request.Form("seq")
	  Co_Seq = Request.Form("co_seq")

	  intSeq2 = Request.QueryString("seq")
	  Co_Seq2 = Request.QueryString("co_seq")
	  
	  'response.write intSeq &"</br>"
	  'response.write Co_Seq &"</br>"
	  'response.write "tttttt"
	  
	  'response.write intSeq2 &"</br>"
	  'response.write Co_Seq2 &"</br>"
	  'response.write "rrr"
	  'response.End 

	  Set DBHelper = new clsDBHelper 	
  
	  Dim paramInfo(1)
	  paramInfo(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)
	  paramInfo(1) = DBHelper.MakeParam("@Coseq",adInteger,adParamInput,4, Co_Seq)

	  Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Comment_Delete", paramInfo, Nothing)

	  Select Case (rs(0))
		 case 20	
			response.write "20"	'글이 존재하지 않음.
			rs.close
			Set rs = Nothing
		 case 10	
			response.write "10" '삭제 되었음
			rs.close
			Set rs = Nothing 
		 case Else :
		   response.write "<script>alert('알수 없는 오류입니다.');history.go(-1);</script>"
	  End Select

	  DBHelper.Dispose
	  Set DBHelper = Nothing
%>

