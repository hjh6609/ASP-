<%
      Option Explicit

      Dim intSeq 

      intSeq = Request.QueryString("seq")
%>
<html>
<head>
<title>태지의 게시판 - 삭제하기</title>
</head>
<body>
<form name="deleteForm" method="post" action="delete_ok.asp?seq=<%=intSeq%>">
<table border cellspacing="0" width="500">
  <tr>
    <td colspan="2" align="center"><b>글을 삭제합니다</b></td>
  </tr>
  <tr>
    <td align="center">비밀번호</td>
    <td>
      <input type="password" name="userPwd" size="15">
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <input type="submit" value="삭제">&nbsp;&nbsp;
      <input type="button" onClick="javascript:history.back();" value="이전으로">
    </td>
  </tr>
</table>
</form>
</body>
</html>
