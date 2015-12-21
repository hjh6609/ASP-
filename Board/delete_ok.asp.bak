<%
      Option Explicit

      Dim objDBConn, objRs
      Dim strSQL 
      Dim intSeq 
      Dim strRealPassword, strPassword

      intSeq = Request.QueryString("seq")
      strPassword = Request.Form("userPwd")

      Set objDBConn = Server.CreateObject("ADODB.Connection")
      Set objRs = Server.CreateObject("ADODB.RecordSet")

      objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

      strSQL = "SELECT strPassword"
      strSQL = strSQL & " FROM board"
      strSQL = strSQL & " WHERE inx = " & intSeq

      objRs.Open strSQL, objDBConn
      strRealPassword = objRs("strPassword")
      objRs.Close
      Set objRs = nothing

      If strRealPassword <> strPassword Then
%>
<script language="javascript">

      alert("비밀번호가 일치하지 않습니다");
      history.back();

</script>
<%
          Response.End
      End If

      strSQL = "DELETE FROM board"
      strSQL = strSQL & " WHERE inx = " & intSeq

      objDBConn.Execute strSQL
      objDBConn.Close
      Set objDBConn = nothing
%>
<script language="javascript">

      alert("삭제되었습니다");
      location.href="list.asp";

</script>
