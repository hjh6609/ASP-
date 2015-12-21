<%
      Option Explicit

      Dim objDBConn, objRs
      Dim strSQL
      Dim intSeq
      Dim strName, strEmail, strSubject, strContent

      intSeq = Request.QueryString("seq")

      Set objDBConn = Server.CreateObject("ADODB.Connection")
      Set objRs = Server.CreateObject("ADODB.RecordSet")

      objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

      strSQL = "Select strName"                    ' objRs(0) - 이름
      strSQL = strSQL & ",strEmail"                ' objRs(1) - 이메일
      strSQL = strSQL & ",strSubject"              ' objRs(2) - 제목
      strSQL = strSQL & ",strContent"              ' objRs(3) - 내용
      strSQL = strSQL & " From board"
      strSQL = strSQL & " Where inx = " & intSeq

      objRs.Open strSQL, objDBConn

      strName = objRs("strName")
      strEmail = objRs("strEmail")
      strSubject = objRs("strSubject")
      strContent = objRs("strContent")

      objRs.Close
      Set objRs = nothing
      objDBConn.Close
      Set objDBConn = nothing
%>
<html>
<head>
<title>태지의 게시판 - 수정하기</title>
</head>
<body>
<form name="editForm" method="post" action="edit_ok.asp?seq=<%=intSeq%>">
<table border cellspacing="0" width="500">
  <tr>
    <td colspan="2" align="center"><b>글을 수정합니다</b></td>
  </tr>
  <tr>
    <td align="center">이름</td>
    <td>
      <input type="text" name="userName" size="15" value="<%=strName%>">
    </td>
  </tr>
  <tr>
    <td align="center">Email</td>
    <td>
      <input type="text" name="userEmail" size="50" value="<%=strEmail%>">
    </td>
  </tr>
  <tr>
    <td align="center">제목</td>
    <td>
      <input type="text" name="subject" size="50" value="<%=strSubject%>">
    </td>
  </tr>
  <tr>
    <td align="center">내용</td>
    <td>
      <textarea name="content" cols="50" rows="10"><%=strContent%></textarea>
   </td>
  </tr>
  <tr>
    <td align="center">비밀번호</td>
    <td>
      <input type="password" name="userPwd" size="15">
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <input type="submit" value="작성 완료">&nbsp;&nbsp;
      <input type="button" onClick="javascript:history.back();" value="이전으로">
    </td>
  </tr>
</table>
</form>
</body>
</html>
