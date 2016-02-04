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

   Set DBHelper = new clsDBHelper
   
   'Session 
   'If session("id") = "" Then
	'	response.redirect "login2.asp"
   'End If
   
   'paging'
   Dim intNowPage, intTotalCount, intTotalPage, intBlockPage, intPageSize ,pgsize
   Dim CtNm , Grade ,KindNo ,Inx ,Variable ,Parent ,intTemp
   'Searching'
   Dim strSearchWord, strSearchString, strSearchSQL, blnSearch  ,Rowcount , Rowcount1

   myid = session("id")
   intNowPage = Request.QueryString("page")	'현재 페이지 
   CtNm = Request.QueryString("categoryNm")
   KindNum=Request.QueryString("kindnum")
   CateNum =Request.QueryString("catenum")	'카테고리 고유번호
   strSearchWord = Request.QueryString("search_word")'Searching  셀렉트'
   strSearchString = Request.QueryString("search_string")'Searching  검색박스 즉 검색할 단어'
   blnSearch = "N"'Searching'
   intPageSize = 10
   intBlockPage = 10 ' 페이지를 몇개씩 구분할 것 인지 - 이전 O개, 다음 O개 할때 사용하지요 - 를 나타내는 변수

   If intNowPage = 0 Or intNowPage = "" Then
       intNowPage = 1
   End If

	'Searching'
    If Len(strSearchString) <> 0 Then
        blnSearch = "Y"
    Else
		strSearchWord = ""
		strSearchString =""
	End If
	
	'일반글쓰기
	Variable = "WR"

	'등급확인용
	Dim paramInfo6(0)
	paramInfo6(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, session("id"))
	Set rs4 = DBHelper.ExecSPReturnRS("dbo.Board_Users", paramInfo6, Nothing)

	Grade = rs4("Grade")

	Set rs4 = Nothing
	rs4.Close

	'페이징	:  상단에 나타나는 개수
	Dim paramInfo1(5)
	paramInfo1(0) = DBHelper.MakeParam("@intPageSize",adInteger,adParamInput,4, intPageSize)
	paramInfo1(1) = DBHelper.MakeParam("@Search",adVarWChar,adParamInput,1, blnSearch)
	paramInfo1(2) = DBHelper.MakeParam("@SearchList",adVarWChar,adParamInput,20, strSearchWord)
	paramInfo1(3) = DBHelper.MakeParam("@SearchString",adVarWChar,adParamInput,20, strSearchString)
	paramInfo1(4) = DBHelper.MakeParam("@NowPage",adInteger,adParamInput,4, intNowPage)
	paramInfo1(5) = DBHelper.MakeParam("@CateNm",adVarWChar,adParamInput,20, CtNm)
	
	'response.write intPageSize &"</br>"
	'response.write blnSearch &"</br>"
	'response.write strSearchWord &"</br>"
	'response.write strSearchString &"</br>"
	'response.write intNowPage &"</br>"
	'response.write CtNm &"</br>"
	'response.End 

	Set rs3 = DBHelper.ExecSPReturnRS("dbo.Board_Paging", paramInfo1, Nothing)

    intTotalCount = rs3(0)	'전체 게시글 개수
    intTotalPage = rs3(1)
	
	Set rs3 = Nothing
	rs3.Close

	'생성한 게시판명 리스트
	Dim paramInfo3(0)
	paramInfo3(0) = DBHelper.MakeParam("@Val",adInteger,adParamInput,4, "")
	Set rs2 = DBHelper.ExecSPReturnRS("dbo.Board_CateNm_list", paramInfo3, Nothing)
	
	'Set rs2 = Nothing
	'rs2.Close

	Dim paramInfo(5)
	paramInfo(0) = DBHelper.MakeParam("@intPageSize",adInteger,adParamInput,4, intPageSize)
	paramInfo(1) = DBHelper.MakeParam("@Search",adVarWChar,adParamInput,1, blnSearch)
	paramInfo(2) = DBHelper.MakeParam("@SearchList",adVarWChar,adParamInput,20, strSearchWord)
	paramInfo(3) = DBHelper.MakeParam("@SearchString",adVarWChar,adParamInput,20, strSearchString)
	paramInfo(4) = DBHelper.MakeParam("@NowPage",adInteger,adParamInput,4, intNowPage)
	paramInfo(5) = DBHelper.MakeParam("@CateNm",adVarWChar,adParamInput,50, CtNm)

	'response.write intPageSize  & "</br>"
	'response.write blnSearch & "</br>"
	'response.write strSearchWord & "</br>"
	'response.write strSearchString & "</br>"
	'response.write intNowPage & "</br>"
	'response.write CtNm & "</br>"
	'response.End 

	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Category_Mix", paramInfo, Nothing)
	Inx = rs("group_b")  'board 테이블에 모든 글이 저장 되는데 거기 고유한 글번호

	 '각 게시판마다 추가되는 부모글의 번호
	'do until rs.eof 
	'		Parent = rs("pos") 
	'		response.write Parent & "</br>"
	'	rs.movenext
	'loop
	'response.End 
	
	'전체 레코드 수 구하기
	Rowcount = rs.RecordCount   
	'do until rs.eof or i>rs.pagesize
	'	Rowcount = Rowcount -1  
	'		Rowcount1= Rowcount +1
	'		response.write Rowcount1 & "</br>"
	'	rs.movenext
	'loop
	'response.End 
%>
 <!DOCTYPE html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=CtNm%></title>
    <!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">
    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		//회원등급
		var MineID =  $("#hdnID").val();
		$("#btnWrite").click(function(){
			if ( MineID == "" )
			{
					alert("글쓰기는 회원만 가능합니다.");
					return false;
			}
		});
	})

	function Confirm()
	{
		//검색창이 공백일 때.
		if($("#txtBox").val() == "")
		{
			alert("검색어를 입력하세요.");
			$("#txtBox").focus();
		}
		
		document.searchForm.submit(); 
		return true;
	}

	</script>
	<style>
		.Roundbox{
			border-radius : 10px;
			-moz-border-radius : 10px;
			-webkit-border-radius : 10px;
			border : 1px solid #cbcbcb;
			background : #ffffff;
			font-size : 15px;
			color : #2e5d7f;
			padding : 12px 10px;
			width : 500px;
			text-align : center;
			margin: 100px 200px;
		}
	</style>
 </head>
 <body>
 <div class="container">
  <div class="header">
	 <nav>
          <ul class="nav nav-pills pull-right">
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
     </nav>
        <h3 class="text-muted">First ASP Board</h3>
    </div>
	 <div align="center">
	 <h2><%=CtNm%></h2>
	 <table class="table table-condensed">
		 <form name= "searchForm" method="get"  onSubmit="Confirm();return false">  <!-- Searching -->
		   <tr>
			 <!-- paging -->
			 <% If intTotalCount > 0 Then %>
			 <td>전체게시 <%=intTotalCount%> 개 &nbsp;&nbsp;&nbsp;&nbsp;
					현재페이지 : <%=intNowPage%> / <%=intTotalPage%>
			 </td>
			<%  End If  %>
			 <!-- Searching -->
			 <td align="right">
				  <select name="search_word">
					  <option value="strID">작성자</option>
					  <option value="strSubject">제목</option>
					  <option value="strContent">내용</option>
				  </select>
				  <input type="text" name="search_string" id="txtBox" size="15">
				  <input type="submit" id="txtSearch" value="검색">

				  <!-- <input type="hidden" name="page" id="page1" value=<%=intNowPage%>> -->
				  <input type="hidden" name="categoryNm" id="categoryNm1" value=<%=CtNm%>> 
			 </td>
		   </tr>
		 </form>
	 </table>
	 <!-- paging -->
	 <table class="table table-striped">
		  <tr align="center">
			 <!-- <td>POS</td> -->
			 <!--<td>번호</td>-->
			 <td>번호</td>
			 <td>제목</td>
			 <td>작성자</td>
			 <td>날짜</td>
			 <td>조회수</td>
		  </tr>
		  <% If rs.BOF or rs.EOF Then %>
		  <tr align="center">
			<td colspan="6">등록된 게시가 없습니다.</td>
		  </tr>
		<%
		   Else
			  'paging'
			  rs.Move (intNowPage - 1) * intPageSize
			  '↑paging'
			 Do Until rs.EOF
			  Rowcount = Rowcount - 1 
			  Rowcount1= Rowcount +1
			  Parent = rs("pos") 
				if rs(8) > 0 Then ' count가 0 보다 크면 답글임
					Dim Sp , Title ,  j 
					Sp=""
					Title =""
					For j=1 To rs(8)	'레벨수 만큼 들여쓰기
						Sp =  "&nbsp;&nbsp;" &Sp+ "&nbsp;"
						Title = rs("strSubject")
					Next		
		%>
						<tr  align="center">
							<!-- <td><%=Parent%></td> -->
							<!--<td><%=Rowcount1%></td>-->
							<td><%=rs("group_b")%></td>
							<td align="left"><a href="content.asp?seq=<%=rs("inx")%>&page=<%=intNowPage%>&categoryNm=<%=rs("CateNm")%>&pos=<%=Parent%>&catenum=<%=CateNum%>&kindnum=<%=KindNum%>"><%=Sp%><%=Title%>&nbsp;&nbsp;[<%=rs(10)%>]</a></td>
							<td><%=rs("strID")%></td>
							<td>
								<%If IsNull(rs(3)) Then 
									response.write "날짜없음" 
								  Else 
									response.write(Replace(Mid(rs("WriteDate"),1,10),"-",".")) 
								  End If
								 %>
							</td>
							<td>
								<%  If IsNull(rs(4)) Then 
										response.write "0" 
									 Else 
										response.write(rs("WriteEnt"))
									 End If 
								%>
							</td>
					 </tr>
				<%
				 Else 
						'response.write  rs("strSubject")   '답글 없음		
				%>
					<tr  align="center">
						<!-- <td><%=Parent%></td> -->
						<!--<td><%=Rowcount1%></td>-->
						<td><%=rs("group_b")%></td>
						<td align="left"><a href="content.asp?seq=<%=rs("inx")%>&page=<%=intNowPage%>&categoryNm=<%=rs("CateNm")%>&pos=<%=Parent%>&catenum=<%=CateNum%>&kindnum=<%=KindNum%>"><%=rs("strSubject")%>&nbsp;&nbsp;[<%=rs(10)%>]</a></td>
						<td><%=rs("strID")%></td>
						<td>
							<%If IsNull(rs(3)) Then 
								response.write "날짜없음" 
							  Else 
								response.write(Replace(Mid(rs("WriteDate"),1,10),"-",".")) 
							  End If
							 %>
						</td>
						<td>
							<%  If IsNull(rs(4)) Then 
									response.write "0" 
								 Else 
									response.write(rs("WriteEnt"))
								 End If 
							%>
						</td>
					</tr>
				<%
				 End If 
				 rs.MoveNext
			 Loop  
		 End If 
	rs.Close
	Set rs = nothing				
	%>
	 </table>
	 <!-- paging -->
	 <table width="600">
	  <tr>
		<td align="center">
		<%
			 intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1

			 If intTemp = 1 Then
				 Response.Write "[이전 " & intBlockPage & "개]&nbsp;&nbsp;&nbsp;"
			 Else
				 Response.Write"<a href=MultiBoard.asp?page=" & intTemp - intBlockPage &  _
					"&categoryNm=" & CtNm & _ 
					"&search_word=" & strSearchWord & _
					"&search_string=" & strSearchString & _ 
					">&nbsp;&nbsp;&nbsp;[이전 " & intBlockPage & "개]&nbsp;&nbsp;&nbsp;</a>"
			End If

			intLoop = 1
			Do Until intLoop > intBlockPage Or intTemp > intTotalPage
				 If intTemp = CInt(intNowPage) Then
					 Response.Write "<font size= 3><b>" & intTemp &"</b></font>&nbsp;"
				 Else
					 Response.Write"<a href=MultiBoard.asp?page=" & intTemp &  _
						"&categoryNm=" & CtNm & _ 
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
				  Response.Write"<a href=MultiBoard.asp?page=" & intTemp &  _
					"&categoryNm=" & CtNm & _ 
					"&search_word=" & strSearchWord & _
					"&search_string=" & strSearchString & _ 
					">&nbsp;&nbsp;[다음 " & intBlockPage & "개]</a>"
			End If
		%>	
		</td>
	  </tr>
	</table>
	 <!-- paging -->
	 <% If blnSearch = "Y" Then %>
	 <a href="MultiBoard.asp?page=1&categoryNm=<%=CtNm%>">처음&nbsp;
	 <% End If %>
	 <% If CtNm = "공지사항" And Grade = 1 Then %> <!-- 공지사항은 관리자만 글쓰기 보임 --> 
			<a id="btnWrite" href="regist.asp?categoryNm=<%=CtNm%>&page=<%=intNowPage%>&seq=<%=Inx%>&pos=<%=Parent%>&catenum=<%=CateNum%>&kindnum=<%=KindNum%>">글쓰기</a>
	<%ElseIf Not (CtNm = "공지사항") Then%> <!-- 회원과 비회원은 공지사항 빼고 다 글쓰기 보임 -->
			<a id="btnWrite" href="regist.asp?categoryNm=<%=CtNm%>&page=<%=intNowPage%>&seq=<%=Inx%>&Gubun=<%=Variable%>&pos=<%=Parent%>&catenum=<%=CateNum%>&kindnum=<%=KindNum%>">글쓰기</a>
	<%End If %>	 	 
		 <input type="hidden" id="hdnID" value="<%=myid%>">  
		 <input type="hidden" id="hdnGrade" value="<%=Grade%>">  
	 </div>
	</div>
	<!-- 생성한 게시판 목록 -->
	<div class="Roundbox">
          <div>
			<form name= "NoticeForm" method="get"  onSubmit="Confirm();return false">
			<% If rs2.BOF or rs2.EOF Then %>
					<a href="#" class="list-group-item">게시판을 등록해 주세요</a>
			<% Else
					Do Until rs2.EOF
			%>
					<a href="MultiBoard.asp?page=1&categoryNm=<%=rs2("CateNm")%>&catenum=<%=rs2("inx")%>&kindnum=<%=rs2("KindNo")%>" > - <%=rs2("CateNm")%> </a>	
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