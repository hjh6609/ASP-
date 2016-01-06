<!--#include File="DBHelper.asp"-->
<%
      Dim objDBConn, objRs
      Dim strSQL 
      Dim intSeq 
      Dim strRealPassword, strPassword 

      intSeq = Request.QueryString("seq")
      strPassword = Request.Form("userPwd")
	  
	  Set DBHelper = new clsDBHelper 	
      Set rs = DBHelper.ExecSQLReturnRS("SELECT strPassword FROM board WHERE inx = " & intSeq , Nothing, Nothing)
      strRealPassword = rs("strPassword")

      rs.Close
      Set rs = Nothing
      DBHelper.Dispose
      Set DBHelper = Nothing

      If strRealPassword <> strPassword Then
%>
<script language="javascript">

      alert("비밀번호가 일치하지 않습니다");
      history.back();

</script>
<%
          Response.End
      End If

      Set DBHelper = new clsDBHelper 
	  DBHelper.ExecSQL "DELETE FROM board WHERE inx='"& intSeq &"'" , Nothing , Nothing
	  
	  DBHelper.Dispose
      Set DBHelper = Nothing


%>
<script language="javascript">

      alert("삭제되었습니다");
      location.href="list.asp";

</script>
