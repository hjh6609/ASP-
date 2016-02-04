<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"

   '//에러코드 시작 상단에 두고 
   On Error Resume Next
   Response.Expires = 0
   Response.ExpiresAbsolute = now() - 1
   Response.AddHeader "pragma","no-cache"
   Response.AddHeader "cache-control","private"
   Response.CacheControl = "no-cache"
   
   'Session 
   'If session("id") = "" Then
	'	response.redirect "login.asp"
   'End If
   
   'paging'
   Dim intNowPage, intTotalCount, intTotalPage, intBlockPage, intPageSize
   Dim intTemp, intLoop 
   'Searching'
   Dim strSearchWord, strSearchString, strSearchSQL, blnSearch ,imsiNO ,Grade,CateNum,KindNum

   myid = session("id")
   intNowPage = Request.QueryString("page")	'현재 페이지 
   Catenm ="공지사항"

   strSearchWord = Request.QueryString("search_word")'Searching  셀렉트'
   strSearchString = Request.QueryString("search_string")'Searching  검색박스 즉 검색할 단어'
   blnSearch = "N"'Searching'
   intPageSize = 10
   intBlockPage = 10 ' 페이지를 몇개씩 구분할 것 인지 - 이전 O개, 다음 O개 할때 사용하지요 - 를 나타내는 변수

   If intNowPage = 0 Or intNowPage = "" Then
       intNowPage = 1
   End If
   
   Set DBHelper = new clsDBHelper

	'Searching'
    If Len(strSearchString) <> 0 Then
        blnSearch = "Y"
    Else
		strSearchWord = ""
		strSearchString =""
	End If
	
	'등급확인용
	Dim paramInfo6(0)
	paramInfo6(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, session("id"))
	Set rs4 = DBHelper.ExecSPReturnRS("dbo.Board_Users", paramInfo6, Nothing)

	Grade = rs4("Grade") 
	Set rs4 = Nothing
	rs4.Close

	'페이징
	Dim paramInfo(5)
	paramInfo(0) = DBHelper.MakeParam("@intPageSize",adInteger,adParamInput,4, intPageSize)
	paramInfo(1) = DBHelper.MakeParam("@Search",adVarWChar,adParamInput,1, blnSearch)
	paramInfo(2) = DBHelper.MakeParam("@SearchList",adVarWChar,adParamInput,20, strSearchWord)
	paramInfo(3) = DBHelper.MakeParam("@SearchString",adVarWChar,adParamInput,20, strSearchString)
	paramInfo(4) = DBHelper.MakeParam("@NowPage",adInteger,adParamInput,4, intNowPage)
	paramInfo(5) = DBHelper.MakeParam("@CateNm",adVarWChar,adParamInput,20, "공지사항")

	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Paging", paramInfo, Nothing)

    intTotalCount = rs(0)	'전체 게시글 개수
    intTotalPage = rs(1)	

	Set rs = Nothing
	rs.Close

	'생성한 게시판명 리스트 /카테고리번호 가져오기
	Dim paramInfo3(0)
	paramInfo3(0) = DBHelper.MakeParam("@Val",adInteger,adParamInput,4, "")
	Set rs2 = DBHelper.ExecSPReturnRS("dbo.Board_CateNm_list", paramInfo3, Nothing)

	'메인 리스트는 공지사항게시물 Top5개만.
	Dim paramInfo2(5)
	paramInfo2(0) = DBHelper.MakeParam("@intPageSize",adInteger,adParamInput,4, intPageSize)
	paramInfo2(1) = DBHelper.MakeParam("@Search",adVarWChar,adParamInput,1, blnSearch)
	paramInfo2(2) = DBHelper.MakeParam("@SearchList",adVarWChar,adParamInput,20, strSearchWord)
	paramInfo2(3) = DBHelper.MakeParam("@SearchString",adVarWChar,adParamInput,20, strSearchString)
	paramInfo2(4) = DBHelper.MakeParam("@NowPage",adInteger,adParamInput,4, intNowPage)
	paramInfo2(5) = DBHelper.MakeParam("@CateNm",adVarWChar,adParamInput,50, "Main")
	
	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Category_Mix", paramInfo2, Nothing)
	
	'전체 레코드 수 구하기
	Rowcount = rs.RecordCount   
	
%>
 <!DOCTYPE html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Main</title>
    <!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">
    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="offcanvas.js"></script>
	<script src="/BootStrap/bootstrap-dist/js/bootstrap.min.js"></script>

	<script type="text/javascript">
	
	$(document).ready(function(){
		//세션 값이 없으면(로그인이 안되어 있으면) 뒤로가기 못감.
		//if(session("id") = "")
		//{
		//	history.forward(1);
		//}
		//else
		//{
		//	location.href="/list.asp";
		//}
	})

	function Confirm()
	{
		//검색창이 공백일 때.
		if($("#txtBox").val() == "")
		{
			alert("검색어를 입력하세요.");
			$("#txtBox").focus();
		}
		
		document.NoticeForm.submit(); 
		return true;
	}
	</script>
 </head>
 <body>
 <nav class="navbar navbar-fixed-top navbar-inverse">
      <div class="container">
		<a class="navbar-brand" href="#">First ASP Board</a>
		 <div id="navbar" class="collapse navbar-collapse">
			  <ul class="nav navbar-nav">
				<li role="presentation" class="active"><a href="/list2.asp">Main</a></li> 
				<!-- 관리자일 때-->
				<%If Grade = 1 Or  session("id") = "hjh6609" Then %>
					<li role="presentation"><a href="/Setting_Add_Board.asp">Basic setting</a></li> 
					<li role="presentation"><a href="/logout.asp">LogOut</a></li>
				<!-- 일반 회원일 때 -->
				<%ElseIf Not (session("id") = "") Then %>
					<li role="presentation"><a href="/logout.asp">LogOut</a></li>
				<!-- 비회원 일 때 -->
				<%Else%>
					<li role="presentation"><a href="/login.asp">Login</a></li>
					<li role="presentation"><a href="/sign_up.asp">Sign Up</a></li>
				<%End If%>				
			  </ul>
		</div>
      </div>
</nav>
<div class="container" style="padding-top: 50px;">  
	<div class="col-xs-12 col-sm-9">
	 <div align="center" class="row">
	 <h2>공지사항</h2>
	 <table class="table table-condensed">
		<tr>
			<!-- 메인은 공지사항 상위5개만 노출 -->
			<% If intTotalCount > 0 Then %>
			 <td>전체게시 5 개 &nbsp;&nbsp;&nbsp;&nbsp;
					현재페이지 : <%=intNowPage%> 
			 </td>
			<%  End If  %>
		</tr>
	 </table>
	 <!--
	 <table class="table table-condensed">
		 <form name= "searchForm" method="get"  onSubmit="Confirm();return false">  
		   <tr>
			 <!-- paging -->
			 <!--
			 <% If intTotalCount > 0 Then %>
			 <td>전체게시 <%=intTotalCount%> 개 &nbsp;&nbsp;&nbsp;&nbsp;
					현재페이지 : <%=intNowPage%> / <%=intTotalPage%>
			 </td>
			<%  End If  %>
			-->
			<!-- 메인은 공지사항 상위5개만 노출 
			<% If intTotalCount > 0 Then %>
			 <td>전체게시 5 개 &nbsp;&nbsp;&nbsp;&nbsp;
					현재페이지 : <%=intNowPage%>
			 </td>
			<%  End If  %>
			 <!-- Searching 
			 <td align="right">
				  <select name="search_word">
					  <option value="strID">작성자</option>
					  <option value="strSubject">제목</option>
					  <option value="strContent">내용</option>
				  </select>
				  <input type="text" name="search_string" id="txtBox" size="15">
				  <input type="submit" id="txtSearch" value="검색">
			 </td>
		   </tr>
		 </form>
	 </table>
	 -->
	 <!-- paging -->
	 <table class="table table-striped">
		  <tr align="center">
			 <td>번호</td>
			 <td>제목</td>
			 <td>작성자</td>
			 <td>날짜</td>
			 <td>조회수</td>
		  </tr>
	  <% If rs.BOF or rs.EOF Then %>
	  <tr align="center">
		<td colspan="5">등록된 게시가 없습니다.</td>
	  </tr>
	 <%
		   Else
			  'paging'
			  rs.Move (intNowPage - 1) * intPageSize
			  '↑paging'
			  Do Until rs.EOF
			  
			  '글번호
			  Rowcount = Rowcount - 1 
			  Rowcount1= Rowcount +1
	 %>
	  <tr align="center">
	   <!-- <td><%=rs("inx")%></td>  -->
	   <td><%=Rowcount1%></td> 
		<td>
		   <a href="content.asp?seq=<%=rs("inx")%>&page=<%=intNowPage%>&categoryNm=<%=Catenm%>&catenum=<%=rs2("Inx") %>&kindnum=<%=rs2("KindNo")%>"><%=rs("strSubject")%></a>
		</td>
		<td><%=rs("strID")%></td> 
		<td>
			<!-- 날짜 -->
			<%If IsNull(rs(3)) Then 
				response.write "날짜없음" 
			  Else 
				response.write(Replace(Mid(rs("WriteDate"),1,10),"-",".")) 
			  End If%></td> 
		<td>
			<!-- 조회수 -->
			<%  If IsNull(rs(4)) Then 
					response.write "0" 
			     Else 
					response.write(rs("WriteEnt"))
			     End If 
		    %>
		</td> 
	  </tr>
	 <%
					  rs.MoveNext
					  'intTotalPage = intPageSize -1	 '여기
					  'Rowcount1 = Rowcount11-1
				  Loop
		   End If
		   rs.Close
		   Set rs = nothing
	 %>
	 </table>
	 <!-- paging 
	 <table width="600">
	  <tr>
		<td align="center">
		<%
			 intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1
			 If intTemp = 1 Then
				 Response.Write "[이전 " & intBlockPage & "개]&nbsp;&nbsp;&nbsp;"
			 Else
				 Response.Write"<a href=list2.asp?page=" & intTemp - intBlockPage &  _
					"&search_word=" & strSearchWord & _
					"&search_string=" & strSearchString & _ 
					">&nbsp;&nbsp;&nbsp;[이전 " & intBlockPage & "개]&nbsp;&nbsp;&nbsp;</a>"
			End If

			intLoop = 1
			Do Until intLoop > intBlockPage Or intTemp > intTotalPage
				 If intTemp = CInt(intNowPage) Then
					 Response.Write "<font size= 3><b>" & intTemp &"</b></font>&nbsp;"
				 Else
					 Response.Write"<a href=list2.asp?page=" & intTemp &  _
						"&search_word=" & strSearchWord & _
						"&search_string=" & strSearchString & _ 
						">" & intTemp & "</a>&nbsp;"
				 End If
				 intTemp = intTemp + 1
				 intLoop = intLoop + 1
			Loop
				

			If intTemp > intTotalPage Then
				Response.Write "&nbsp;&nbsp;[다음 " &intBlockPage&"개]"
			Else
				  Response.Write"<a href=list2.asp?page=" & intTemp &  _
					"&search_word=" & strSearchWord & _
					"&search_string=" & strSearchString & _ 
					">&nbsp;&nbsp;[다음 " & intBlockPage & "개]</a>"
			End If
			 
		%>	
		</td>
	  </tr>
	</table>
	 <!-- paging -->
	 <!--
	 <% If blnSearch = "Y" Then %>
	 <a href="list.asp">목록으로&nbsp;
	 <% End If %> 
	 	 <a href="regist.asp?page="<%=intNowPage%>>글쓰기</a>
	 -->
	 </div>
	</div>
	<div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar" style="padding-top: 70px;">
          <div class="list-group">
			<form name= "NoticeForm" method="get"  onSubmit="Confirm();return false">
			<% If rs2.BOF or rs2.EOF Then %>
					<a href="#" class="list-group-item">게시판을 등록해 주세요</a>
		<%    Else
					Do Until rs2.EOF
		%>
					<a href="MultiBoard.asp?page=<%=intNowPage%>&categoryNm=<%=rs2("CateNm")%>&catenum=<%=rs2("Inx") %>&kindnum=<%=rs2("KindNo")%>" class="list-group-item"><%=rs2("CateNm")%></a>	
		<%
					  rs2.MoveNext				 
				   Loop
			End If

		    rs2.Close
		    Set rs2 = nothing
		%>
			</form>
          </div>
	</div>
	<%
			DBHelper.Dispose
		   Set DBHelper = Nothing
	%>
 </body>
</html> 