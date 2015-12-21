
<%
   Option Explicit

   Dim objDBConn
   Dim objRs
   Dim strSQL

   Dim strName , strEmail, strSubject,strContent,intSeq , WriteDate, WriteEnt

   intSeq	= Request.QueryString("seq")

   Set objDBConn = Server.CreateObject("ADODB.Connection")
   Set objRs = Server.CreateObject("ADODB.RecordSet")

   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   strSQL = "Update board Set WriteEnt = WriteEnt + 1"
   strSQL = strSQL & " Where inx = " & intSeq

   objDBConn.Execute strSQL

   strSQL = "SELECT strName"                     ' objRs(0) - 이름
   strSQL = strSQL & ",strEmail"                 ' objRs(1) - 메일주소
   strSQL = strSQL & ",strSubject"               ' objRs(2) - 제목
   strSQL = strSQL & ",strContent"               ' objRs(3) - 내용
   strSQL = strSQL & ",WriteDate"               ' objRs(4) - 날짜
   strSQL = strSQL & ",WriteEnt"               ' objRs(5) - 조회수
   strSQL = strSQL & " FROM board"
   strSQL = strSQL & " WHERE inx = " + intSeq

   objRs.Open strSQL, objDBConn

   strName = objRs(0)
   strEmail= objRs(1)
   strSubject = objRs(2)
   strContent = objRs(3)
   WriteDate = objRs(4)
   WriteEnt = objRs(5)

   objRs.Close
   Set objRs = nothing

   objDbConn.Close
   Set objDBConn = nothing

   strContent = Replace(strContent, vbLf, vbLf & "<br>")
%>
<!DOCTYPE html>
<head>
	<title>게시판 - 내용보기</title>

	<!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>

</head>
<body>
<div class="container">
  <div class="header">
	 <nav>
          <ul class="nav nav-pills pull-right">
            <li role="presentation" class="active"><a href="javascript:alert('1')">Home</a></li>
            <li role="presentation"><a href="javascript:alert('2')">About</a></li>
            <li role="presentation"><a href="javascript:alert('3')">Contact</a></li>
          </ul>
     </nav>
        <h3 class="text-muted">First ASP Board</h3>
    </div>
	<table class="table table-striped">
	   <tr>
		   <td>이름</td>
		   <td><%=strName%></td>
		   <td>조회수</td>
		   <td colspan="3">
				<%If IsNull(WriteEnt) Then 
					response.write "0" 
				  Else
					response.write(WriteEnt)
				  End If %>
			</td>
	   </tr>
	   <tr>
		   <td>Email</td>
		   <td colspan="5"><a href="mailto:<%=strEmail%>"><%=strEmail%></a></td>
	   </tr>
	   <tr>
			<td>제목</td>
			<td colspan="3"><%=strSubject%></td>
			<td>등록일</td>
			<td colspan="3">
				<%If IsNull(WriteDate) Then 
					response.write "날짜없음" 
				  Else
					response.write(Replace(Mid(WriteDate,1,10),"-","."))
				  End If %>
			</td>
	   </tr>
	   <tr>
		   <td colspan="6" style="padding:15px;"><%=strContent%></td>
	   </tr>
	   <tr>
		   <td colspan="6" align="center">
			   <a href="edit.asp?seq=<%=intSeq%>">수정하기</a>
			   <a href="list.asp">목록으로</a>
			   <a href="delete.asp?seq=<%=intSeq%>">삭제하기</a>
		   </td>
	   </tr>
	 </table>
	 <footer class="footer">
       <p>&copy; ASP Board. 201512 </p>
     </footer>
  </div>
</body>
</html>
