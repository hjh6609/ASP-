<%
      Option Explicit

      Dim objDBConn, objRs
      Dim strSQL 
      Dim intSeq 
      Dim strID, strEmail, strSubject, strContent
      Dim strRealPassword, strPassword

      intSeq = Request.QueryString("seq")
      strID = Request.Form("userID")
      strEmail = Request.Form("userEmail")
      strSubject = Request.Form("subject")
      strContent = Request.Form("content")
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

      alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
      history.back();

</script>
<%
          Response.End
      End If

      strSQL = "UPDATE board SET"
      strSQL = strSQL & " strID = '" & strID & "',"
      strSQL = strSQL & " strEmail = '" & strEmail & "',"
      strSQL = strSQL & " strSubject = '" & strSubject & "',"
      strSQL = strSQL & " strContent = '" & strContent & "'"
      strSQL = strSQL & " WHERE inx = " & intSeq

      objDBConn.Execute strSQL
      objDBConn.Close
      Set objDBConn = nothing
%>
<script language="javascript">

      alert("�����Ǿ����ϴ�");
      location.href="list.asp";

</script>
