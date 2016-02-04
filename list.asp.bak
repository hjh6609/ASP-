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
   If session("id") = "" Then
		response.redirect "login.asp"
   End If
   
   'paging'
   Dim intNowPage, intTotalCount, intTotalPage, intBlockPage, intPageSize
   Dim intTemp, intLoop 
   'Searching'
   Dim strSearchWord, strSearchString, strSearchSQL, blnSearch ,imsiNO

   myid = session("id")
   intNowPage = Request.QueryString("page")	'현재 페이지 

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
	

	'페이징
	Dim paramInfo(4)
	paramInfo(0) = DBHelper.MakeParam("@intPageSize",adInteger,adParamInput,4, intPageSize)
	paramInfo(1) = DBHelper.MakeParam("@Search",adVarWChar,adParamInput,1, blnSearch)
	paramInfo(2) = DBHelper.MakeParam("@SearchList",adVarWChar,adParamInput,20, strSearchWord)
	paramInfo(3) = DBHelper.MakeParam("@SearchString",adVarWChar,adParamInput,20, strSearchString)
	paramInfo(4) = DBHelper.MakeParam("@NowPage",adInteger,adParamInput,4, intNowPage)

	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Paging", paramInfo, Nothing)

    intTotalCount = rs(0)	'전체페이지개수
    intTotalPage = rs(1)	

    '이 페이지에서 시작할 임시번호를 구한다
	'총레코드 개수(totrecord)에다가
	'앞페이지까지의 숫자를(ipage-1)*(Rcount) 제외한 
	'숫자를 이페이지의 시작번호로 한다
	imsiNO=intTotalCount-(intNowPage)*(intTotalPage)	'여기

	'response.write intTotalCount

	
	Set rs = Nothing
	rs.Close
	
	'내용
	Dim paramInfo2(4)
	paramInfo2(0) = DBHelper.MakeParam("@intPageSize",adInteger,adParamInput,4, intPageSize)
	paramInfo2(1) = DBHelper.MakeParam("@Search",adVarWChar,adParamInput,1, blnSearch)
	paramInfo2(2) = DBHelper.MakeParam("@SearchList",adVarWChar,adParamInput,20, strSearchWord)
	paramInfo2(3) = DBHelper.MakeParam("@SearchString",adVarWChar,adParamInput,20, strSearchString)
	paramInfo2(4) = DBHelper.MakeParam("@NowPage",adInteger,adParamInput,4, intNowPage)

	'response.write intPageSize	 &"</br>"
	'response.write blnSearch &"</br>"
	'response.write strSearchWord &"</br>"
	'response.write strSearchString &"</br>"
	'response.write intNowPage &"</br>"

	Set rs = DBHelper.ExecSPReturnRS("dbo.Board_List", paramInfo2, Nothing)

	'Do Until rs.EOF
	'	 response.write rs(1)
	'	 rs.MoveNext
	'Loop 
%>
 <!DOCTYPE html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>목록보기</title>
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
 </head>
 <body>
 <div class="container">
  <div class="header">
	 <nav>
          <ul class="nav nav-pills pull-right">
            <li role="presentation" class="active"><a href="list.asp">Main</a></li> 
			<li role="presentation"><a href="Setting_Add_Board.asp">Basic setting</a></li> 
			<li role="presentation"><a href="/logout.asp">LogOut</a></li>
          </ul>
     </nav>
        <h3 class="text-muted">First ASP Board</h3>
    </div>
	 <div align="center">
	 <h2>목록보기</h2>
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
			 </td>
		   </tr>
		 </form>
	 </table>
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
		<td colspan="5">등록된 게시가 없습니다</td>
	  </tr>
	 <%
		   Else
			  'paging'
			  rs.Move (intNowPage - 1) * intPageSize
			  '↑paging'
			  Do Until rs.EOF
	 %>
	  <tr align="center">
	   <!-- <td><%=rs("inx")%></td>  -->
	   <td><%=imsiNO%></td> 
		<td>
		   <a href="content.asp?seq=<%=rs("inx")%>&page=<%=intNowPage%>"><%=rs("strSubject")%>&nbsp;&nbsp;[<%=rs(5)%>]</a>
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
					  intTotalPage = intPageSize -1	 '여기
					  imsiNO=imsiNO-1					 '여기
				  Loop
		   End If

		   rs.Close
		   Set rs = nothing
		   DBHelper.Dispose
		   Set DBHelper = Nothing
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
				 Response.Write"<a href=list.asp?page=" & intTemp - intBlockPage &  _
					"&search_word=" & strSearchWord & _
					"&search_string=" & strSearchString & _ 
					">&nbsp;&nbsp;&nbsp;[이전 " & intBlockPage & "개]&nbsp;&nbsp;&nbsp;</a>"
			End If

			intLoop = 1
			Do Until intLoop > intBlockPage Or intTemp > intTotalPage
				 If intTemp = CInt(intNowPage) Then
					 Response.Write "<font size= 3><b>" & intTemp &"</b></font>&nbsp;"
				 Else
					 Response.Write"<a href=list.asp?page=" & intTemp &  _
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
				  Response.Write"<a href=list.asp?page=" & intTemp &  _
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
	 <a href="list.asp">목록으로&nbsp;
	 <% End If %> 
	 	 <a href="regist.asp?page="<%=intNowPage%>>글쓰기</a>
	 </div>
	</div>
 </body>
</html> 