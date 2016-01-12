<%
   Option Explicit

   Dim objDBConn, objRs
   Dim strSQL 
   Dim intSeq 
   Dim strRealPassword, strPassword ,Check ,Num ,i

   Check = Request.Form("Remove")
   Num = Split(Check, ",")

   'Response.Write ubound(Num)+1 & "개가 선택되었습니다.<br>" 
   '몇개의 선택값이 선택되었는지 출력

   'For i = 0 To ubound(Num)
   '		Response.write TRIM(Num(i)) & "<br>"
	   ' ","기준으로 잘린 문자열 뿌려주기
   'Next
   
   Set objDBConn = Server.CreateObject("ADODB.Connection")
   Set objRs = Server.CreateObject("ADODB.RecordSet")

   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"
   
   For i = 0 To ubound(Num)
   		'Response.write TRIM(Num(i)) & "<br>"
		strSQL = "DELETE FROM board"
		strSQL = strSQL & " WHERE inx = " & Num(i)
   Next

   objDBConn.Execute strSQL
   objDBConn.Close
   Set objDBConn = nothing

%>

<script language="javascript">

      alert("삭제되었습니다");
      location.href="list_ad.asp";

</script>
