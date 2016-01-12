<!--#include File="DBHelper.asp"-->
<%
'//에러코드 시작 상단에 두고 
On Error Resume Next

'Session 
If session("id") = "" Then
	response.redirect "login.asp"
End if

Dim objDBConn 
Dim objRs
Dim strSQL 
Dim strName , strSubject,strContent,intSeq , WriteDate, WriteEnt, myid
Dim Co_seq, Co_name , Co_content ,Gotopage 


GoTopage= Request.QueryString("page")
intSeq	= Request.QueryString("seq")
myid = Request.QueryString("myid")

Set DBHelper = new clsDBHelper

'글보기
Dim paramInfo(0)
paramInfo(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)

Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Content", paramInfo, Nothing)

'에러가 있다면 메세지 보여주기 
if err.number <> 0 then 
	response.Write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
ElseIf intSeq = "" Then 
	response.Write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
ElseIf rs(0) <> 10 Then 
	strName = rs(0)
	strSubject = rs(1)
	strContent = rs(2)
Else
	response.write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
	response.End
End If 

rs.close
Set rs = Nothing

'댓글보기
Dim paramInfo2(0)
paramInfo2(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)

Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Comment", paramInfo2, Nothing)

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

<script>
	
	$(document).ready(function(){
		//세션 값이 없으면(로그인이 안되어 있으면) 뒤로가기 못감.
		if(session("id") = "")
		{
			history.forward(1);
		}
		else
		{
			location.href="/list.asp";
		}
	})
	
	function addComment()
	{
		//alert(1);
		//var name = document.frmMent.txtName.value;
		//if (CheckStr(name, " ", "")==0) {
		//  alert("이름을 입력해 주세요");
		//  document.frmMent.txtName.focus();
		//  return;
		//}
		//alert(2);
		var content = document.frmMent.txtContent.value;
		if (CheckStr(content, " ", "")==0) {
		  alert("커멘트 내용을 입력해 주세요");
		  document.frmMent.txtContent.focus();
		  return;
		}
		//alert(3);
		document.frmMent.submit();
	}

	function CheckStr(strOriginal, strFind, strChange){
		var position, strOri_Length;
		position = strOriginal.indexOf(strFind); 

		while (position != -1){
		  strOriginal = strOriginal.replace(strFind, strChange);
		  position = strOriginal.indexOf(strFind);
		}

		strOri_Length = strOriginal.length;
		return strOri_Length;
	  }
</script>
</head>
<body>
<div class="container">
	<div class="header">
		<nav>
		<ul class="nav nav-pills pull-right">
			<li role="presentation" class="active"><a href="/list.asp?myid="<%=myid%>>Home</a></li>
			<li role="presentation"><a href="/logout.asp">LogOut</a></li>
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
			<a href="list.asp?page=<%=GoTopage%>">목록으로</a>
			<a href="delete.asp?seq=<%=intSeq%>">삭제하기</a>
		</td>
	</tr>
	</table>
	<!-- --------------------------------------------- -->
	<form name="frmMent" action="reply_ok.asp?page=<%=GoTopage%>" Method="post">
	  <table width="700" bgcolor="slategray" cellspacing="1">	
		<tr bgcolor="#eeeeee">
		  <td colspan=2>댓글을 남겨주세요</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr bgcolor="white">
		  <INPUT class= "inputa" type="hidden" name= "GoTopage" value="<%=GoTopage%>">
		  <INPUT class= "inputa" type="hidden" name= "board_idx" value="<%=intSeq%>">
		  <!-- <td>이름 : <INPUT class="inputa" name="txtName" size="7"></td> -->
		  <td>이름 : <%=session("id")%></td>
		  <td align="center">
			내용 : 
			<INPUT class="inputa" name="txtContent" size="50" maxlength="200">
			<Input class="buttona" type="button" onClick="addComment();" value="저장">
		  </td>
		</tr>
	  </table>
	</form>
	<br><font size=2><b>Comment</b></font></br>
	<p>――――――――――――――――――――――――――――</p>
	  <table width="700" bgcolor="slategray" cellspacing="1" border="0">	
		<!--Do-->
		<% If rs.BOF or rs.EOF Then %>
			<tr>
				<td>등록된 댓글이 없습니다.</td>
			</tr>
		
		<% Else 
			Do Until rs.EOF %>
				<tr bgcolor="white">  
				  <td><b><%=rs("Co_name")%></b></br>내용 :<%=rs("Co_content")%>
				  </td>
				</tr>
		<%
				rs.MoveNext
			Loop
		End If	
		rs.Close
		Set rs = Nothing
		DBHelper.Dispose
		Set DBHelper = Nothing
		%>
		<!--Loop-->
	  </table>
	<footer class="footer">
	<p>&copy; ASP Board. 201512   By.Hanjihyeon :-)</p>
	</footer>
</div>
</body>
</html>
