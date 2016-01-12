<!--#include File="DBHelper.asp"-->
<%
   'Session 
   If session("id") = "" Then
		response.redirect "login.asp"
   End if
   
   Dim objDBConn
   Dim objRs
   Dim strSQL
   
   'paging'
   Dim intNowPage, intTotalCount, intTotalPage, intBlockPage, intPageSize
   Dim intTemp, intLoop  , myid

   'Searching'
   Dim strSearchWord, strSearchString, strSearchSQL
   Dim blnSearch

   intNowPage = Request.QueryString("page")
   strSearchWord = Request.QueryString("search_word")'Searching  셀렉트'
   strSearchString = Request.QueryString("search_string")'Searching  검색박스 즉 검색할 단어'
   blnSearch = false'Searching'
   intPageSize = 10
   intBlockPage = 10

   'login page 에서 온 내 아이디 받기
   myid = Request.QueryString("myid")

   If Len(intNowPage) = 0 Then
       intNowPage = 1
   End If
   
   Set DBHelper = new clsDBHelper

   'Searching'
   If Len(strSearchString) <> 0 Then
        blnSearch = true
        strSearchSQL = " Where " & strSearchWord
        strSearchSQL = strSearchSQL & " like '%" & strSearchString & "%'"
   End If

   Set rs = DBHelper.ExecSQLReturnRS("SELECT Count(*),CEILING(CAST(Count(*) AS FLOAT)/" & intPageSize & ") FROM board" , Nothing, Nothing)
   If blnSearch Then
	   Set rs = DBHelper.ExecSQLReturnRS("SELECT Count(*),CEILING(CAST(Count(*) AS FLOAT)/" & intPageSize & ") FROM board "& strSearchSQL &"" , Nothing, Nothing)
   End If

   intTotalCount = rs(0)
   intTotalPage = rs(1)
   rs.Close 

   Set rs = DBHelper.ExecSQLReturnRS("SELECT Top " & intNowPage * intPageSize & "inx,strID,strNotice,strSubject,WriteDate,WriteEnt FROM board ORDER BY inx DESC", Nothing, Nothing)
   'Searching'
   If blnSearch Then
	   Set rs = DBHelper.ExecSQLReturnRS("SELECT Top " & intNowPage * intPageSize & " inx,strID,strNotice,strSubject,WriteDate,WriteEnt FROM board "& strSearchSQL &"" , Nothing, Nothing)
   End If 

%>
 <!DOCTYPE html>
 <head>
	<title>목록보기</title>
    <!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
	
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

	</script>

	<!-- 스크롤 내리면서 로딩 -->
	<!--
	<script type="text/javascript">
		$( document ).ready( function() {
			$( 'img' ).removeAttr( 'style' );
		} );
		
		function lastPostFunc()  
		{  
			$("div#lastPostsLoader").html("로딩중...");  
			$.get("/Ding_data.html?action=getLastPosts&lastID=" + $(".wrdLatest:last").attr("id"),     
		   
			function(data){  
				if (data != "") {  
				$(".wrdLatest:last").after(data);             
				}  
				$("div#lastPostsLoader").empty();  
			});  
		};  

		$(window).scroll(function(){  
				if  ($(window).scrollTop() == $(document).height() - $(window).height()){  
				   lastPostFunc();  
				}  
		});  
	</script>
	
	<style>
		img {
		  width: inherit;
		  max-width: 100%;
		  height: auto;
		}
	</style>
	-->	
	<!-- 스크롤 내리면서 로딩 -->
 </head>
 <body>
 <div class="container">
  <div class="header">
	 <nav>
          <ul class="nav nav-pills pull-right">
            <li role="presentation" class="active"><a href="/list.asp">Board</a></li>
			<li role="presentation"><a href="/logout.asp">LogOut</a></li>
          </ul>
     </nav>
        <h3 class="text-muted">First ASP Board</h3>
    </div>
	 <div align="center">
	 <h2>목록보기</h2>
	 <table class="table table-condensed">
		 <form name= "searchForm" method="get">  <!-- Searching -->
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
				  <input type="text" name="search_string" size="15">
				  <input type="submit" value="검색">
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
	   <td><%=rs(0)%></td>
		<td>
		   <a href="content.asp?seq=<%=rs(0)%>"><%=rs(3)%></a>
		</td>
		<td><%=rs(1)%></td> 
		<td>
			<!-- 날짜 -->
			<%If IsNull(rs(4)) Then 
				response.write "날짜없음" 
			  Else 
				response.write(Replace(Mid(rs(4),1,10),"-",".")) 
			  End If%></td> 
		<td>
			<!-- 조회수 -->
			<%If IsNull(rs(5)) Then 
				response.write "0" 
			  Else 
				response.write(rs(5))
			  End If %>
		</td> 
	  </tr>
	 <%
					  rs.MoveNext
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
		%>	
		</td>
	  </tr>
	</table>
	 <!-- paging -->
	 <% If blnSearch Then %>
	 <a href="list.asp">목록으로&nbsp;
	 <% End If %> 
	 <a href="regist.asp?myid=<%=myid%>">글쓰기</a>
	 </div>
		<!--
		<div class="wrdLatest">
			<table class="table table-condensed">
				<tr>
					<td>
					 <img src="http://cfile9.uf.tistory.com/image/245BE64D53BED145179B8F" style="width: 300px; height: 200px;">
					</td>
				</tr>
			</table>
		</div>
		-->
		<!--
		<div class="wrdLatest" id=9>content</div>  
		<div class="wrdLatest" id=8>content</div>
		-->
		<!-- <div id="lastPostsLoader"></div> -->
	</div>
 </body>
</html> 