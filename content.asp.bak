<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"

'//에러코드 시작 상단에 두고 
On Error Resume Next

'Session 
'If session("id") = "" Then
'	response.redirect "login.asp"
'End if

Dim strName , strSubject,strContent,intSeq , WriteDate, WriteEnt, myid
Dim Co_seq, Co_name , Co_content ,Gotopage ,name ,CateNm ,Variable ,Parent,group_num,Cnt, group,CateNum,filename

GoTopage= Request.QueryString("page")
intSeq	= Request.QueryString("seq")
CateNm = Request.QueryString("categoryNm")
name = session("id") 
Parent = Request.QueryString("pos")
Variable = "RE"
CateNum = Request.QueryString("catenum")
KindNum = Request.QueryString("kindnum")

Set DBHelper = new clsDBHelper

'글보기
Dim paramInfo(0)
paramInfo(0) = DBHelper.MakeParam("@IntSeq",adInteger,adParamInput,4, intSeq)

Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Content", paramInfo, Nothing)

group_num = rs("group_num")
Cnt = rs("group_Count")
group = rs("group_b") '부모글번호
filename= rs("strfilename")
'response.End 

'에러가 있다면 메세지 보여주기 
if err.number <> 0 then 
	response.Write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
ElseIf intSeq = "" Then 
	response.Write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
ElseIf rs(0) <> 10 Then 
	strName = rs(0)
	strSubject = rs(1)
	strContent = rs(2)
	WriteDate =rs(3)
	WriteEnt =rs(4)
Else
	response.write "<script>alert('조회하시려는 글 번호가 없습니다.\n이전페이지로 이동합니다.');history.go(-1);</script>"
	response.End
End If 

mineid = rs(0)

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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>게시판 - 내용보기</title>
<!-- Bootstrap core CSS -->
<link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

<script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>

<script>
	$(document).ready(function(){
		//alert(1111);
		//세션 값이 없으면(로그인이 안되어 있으면) 뒤로가기 못감.
		//if(session("id") = "")
		//{
		//	history.forward(1);
		//}
		//else
		//{
		//	location.href="/list.asp";
		//}
	});

	function aEdit(co_seq ,content,seq)
	{
			//alert(content);			return;		
			$("#comment_list_" + co_seq ).html("<textarea id='txtBox_"+co_seq+"'>" + content + "</textarea>");			
			$("#comment_list_" + co_seq ).after("<a href='#' onclick='btnEdit("+co_seq+", "+seq+" );'>수정</a>&nbsp;<a href='#' onclick='btnReset("+co_seq+");'>취소</a>");	
			//console.log("End");
	}

	function btnReset(co_seq)
	{
		$("#txtBox_" + co_seq).val("");
	}

	function btnEdit(num1 , num2)
	{
		//alert(seq);
		var co_seq = num1;
		var intseq = num2;
		var content = $("#txtBox_" + co_seq).val();
		//alert(content);

		//공백 검사
		if(content == "")
		{
			alert("글을 입력해 주세요.");
			return;
		}
		
		$.ajax({
			 type: "POST",
			 url: "Comment_Edit.asp", //이페이지에서 중복체크를 한다
			 data:({"co_seq":co_seq,"seq":intseq, "content":content}),
			 cache: false,
			 dataType: "text",
			 success: function(data){
				 //alert(data);
				 //return;
				 if(data == "10")
				 {
				 	 //alert("글이 수정 되었습니다.");						
					 location.reload();
				 }
				 else if(data == "20")
				 {
					 alert("글이 존재하지 않습니다.");
					 return;
				 }
				 else
				 {
					 aldert("알 수 없는 에러.");
				 }
			 }
		 });
	}

	function aDelete(num1,num2)
	{
		var co_seq = num1;
		var intseq = num2;
		
		if(confirm("삭제하시겠습니까?") == true)
		{
			$.ajax({
				type: "POST",
				url: "Comment_Delete.asp", //이페이지에서 중복체크를 한다
				data:({"co_seq":co_seq,"seq":intseq }),
				cache: false,
				dataType: "text",
				success: function(data){
					//alert(data);
					//return;
					if(data == "10")
					{
						alert("삭제되었습니다.");
						location.reload();
					}
					else if(data == "20")
					{
						alert("글이 존재하지 않습니다.");
						return;
					}
					else
					{
						aldert("알 수 없는 에러.");
					}
				}
			});
		}
	}

	function addComment()
	{		
		//alert(1);
		var content = document.frmMent.txtContent.value;
		var intSeq = document.frmMent.board_idx.value;
		var GoTopage = document.frmMent.page.value;
		var Catenm =document.frmMent.hdnCatenm.value;
		var Group_b = document.frmMent.hdnGroup.value;
		
		//alert(content);
		if ( content == "" ) {
		  alert("커멘트 내용을 입력해 주세요");
		  document.frmMent.txtContent.focus();
		  return;
		}
		$.ajax({
			type: "POST",
			url: "reply_ok.asp", //이페이지에서 중복체크를 한다
			data:({"page":GoTopage, "board_idx": intSeq , "txtContent": content ,"Catenm":Catenm ,"group_b":Group_b }),
			cache: false,
			dataType: "text",
			success: function(data){
				//alert(data);
				//return;
				if(data == "10")
				{
					//alert("등록되었습니다.");
					location.reload();
				}
				else
				{
					aldert("알 수 없는 에러.");
					return;
				}
			}
		});
	}
</script>
</head>
<body>
<div class="container">
	<div class="header">
		<nav>
		<ul class="nav nav-pills pull-right">
			<!-- 관리자일 때-->
				<%If Grade = 1 Or  session("id") = "hjh6609" Then %>
					<li role="presentation"><a href="/Setting_Add_Board.asp">Basic setting</a></li> 
					<li role="presentation"><a href="/logout.asp">LogOut</a></li>
				<!-- 일반 회원일 때 -->
				<%ElseIf Not (session("id") = "") Then %>
					<li role="presentation"><a href="/list2.asp">Main</a></li>
					<li role="presentation"><a href="/logout.asp">LogOut</a></li>
				<!-- 비회원 일 때 -->
				<%Else%>
					<li role="presentation"><a href="/list2.asp">Main</a></li>
					<li role="presentation"><a href="/login.asp">Login</a></li>
					<li role="presentation"><a href="/sign_up.asp">Sign Up</a></li>
				<%End If%>
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
			<% If IsNull(WriteEnt) Then
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
	<% If KindNum = 2 Then  %>
	<tr>
		<td>첨부파일</td>
		<td colspan="3"><a href="/DataRoom.asp?kindnum=<%=KindNum%>&filename=<%=filename%>"><%=filename%></a></td>
	</tr>
	<% End If  %>
	<tr>
		<td colspan="6" align="center">
			<% If mineid = session("id") Then %>
				<a href="edit.asp?seq=<%=intSeq%>&catenm=<%=CateNm%>">수정</a>
				<a href="delete.asp?seq=<%=intSeq%>">삭제</a>
				<a href="regist.asp?categoryNm=<%=CateNm%>&page=<%=GoTopage%>&seq=<%=intSeq%>&Gubun=<%=Variable%>&pos=<%=Parent%>&Sand=<%=strSubject%>&group_num=<%=group_num%>&cnt=<%=Cnt%>&catenum=<%=CateNum%>">답글</a>
				<a href="MultiBoard.asp?categoryNm=<%=CateNm%>&page=<%=GoTopage%>&catenum=<%=CateNum%>&kindnum=<%=Kindnum%>">목록</a>
			<% ElseIf Not(session("id") ="")  Then %>
				<% If CateNm = "공지사항" Then %>
					<a href="MultiBoard.asp?categoryNm=<%=CateNm%>&page=<%=GoTopage%>&catenum=<%=CateNum%>&kindnum=<%=Kindnum%>">목록</a>
				<% Else  %>
					<a href="regist.asp?categoryNm=<%=CateNm%>&page=<%=GoTopage%>&seq=<%=intSeq%>&Gubun=<%=Variable%>&pos=<%=Parent%>&Sand=<%=strSubject%>&group_num=<%=group_num%>&cnt=<%=Cnt%>&catenum=<%=CateNum%>">답글</a>
					<a href="MultiBoard.asp?categoryNm=<%=CateNm%>&page=<%=GoTopage%>&catenum=<%=CateNum%>&kindnum=<%=Kindnum%>">목록</a>
				<% End If %>
			<% ElseIf session("id") =""  Then %>
				<a href="MultiBoard.asp?categoryNm=<%=CateNm%>&page=<%=GoTopage%>&catenum=<%=CateNum%>&kindnum=<%=Kindnum%>">목록</a>
			<% End If  %>
		</td>
	</tr>
	</table>
	<!-- --------------------------------------------- -->
	<form name="frmMent" Method="post">
	  <table width="700" bgcolor="slategray" cellspacing="1">	
		<tr bgcolor="#eeeeee">
		  <td colspan=2>댓글을 남겨주세요</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr bgcolor="white">
		  <input type="hidden" name= "page" value="<%=GoTopage%>">
		  <input type="hidden" name= "board_idx" value="<%=intSeq%>">
		  <input type="hidden" name ="hdnCatenm" value="<%=CateNm%>">
		  <input type="hidden" name ="hdnGroup" value="<%=group%>">
		  <td>이름 : <%=session("id")%></td>
		  <td align="center">
			내용 : 
			<input name="txtContent" size="50" maxlength="200">
			<input type="button" onClick="addComment();" value="저장">
		  </td>
		</tr>
	  </table>
	</form>
	<br><font size=2><b>Comment</b></font></br>
	<p>――――――――――――――――――――――――――――</p>
	<form name="Co_editForm" method="post" action="Comment_Delete.asp?seq=<%=intSeq%>&Co_seq=<%=rs("Co_seq")%>">
	  <table width="700" bgcolor="slategray" cellspacing="1" border="0">
		<% If rs.BOF or rs.EOF Then %>
			<tr>
				<td>등록된 댓글이 없습니다.</td>
			</tr>
		
		<% Else 
				Do Until rs.EOF 
					'response.write rs("Co_name") & "<br>"
		%>
			<tr>
				<td>
					<input type="hidden" name = "co_id" value="<%=session("id")%>">
				</td>
			</tr>
			<tr bgcolor="white">
				<%  If rs("Co_name") = session("id") Then 
						'response.write "나임"
				%>
				<td>
					<b><%=rs("Co_name") %></b>
					<div id="comment_list_<%=rs("Co_seq")%>">
						내용 :<%=rs("Co_Content") %>  
						<a href="#" onclick="aEdit('<%=rs("Co_seq")%>','<%=rs("Co_Content")%>','<%=intSeq%>');">수정</a> <a href="#" onclick="aDelete('<%=rs("Co_seq")%>','<%=intSeq%>');">삭제</a>
					</div>
			<%
					Else
			%>
					<b><%=rs("Co_name")%></b></br>
					<div id="idid2">
						<p>내용 :<%=rs("Co_content")%></p>
					</div>
				</td>
			</tr>
		<%
					End If 
					rs.MoveNext
				Loop			
		  End If 				
		rs.Close
		Set rs = Nothing
		DBHelper.Dispose
		Set DBHelper = Nothing
		%>
	  </table>
	</form>
	<footer class="footer">
	<p>&copy; ASP Board. 201512   By.Hanjihyeon :-)</p>
	</footer>
</div>
</body>
</html>
