<%
   Option Explicit '이 페이지에서 사용되는 모든 변수들은 반드시 선언되어진 이후에 사용 될 수 있다'
  
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
   strSearchWord = Request.QueryString("search_word")'Searching'
   strSearchString = Request.QueryString("search_string")'Searching'
   blnSearch = false'Searching'
   intPageSize = 10
   intBlockPage = 10
   

   'login page 에서 온 내 아이디 받기
   myid = Request.QueryString("myid")

   If Len(intNowPage) = 0 Then
       intNowPage = 1
   End If
   
   'Searching'
   If Len(strSearchString) <> 0 Then
        blnSearch = true
        strSearchSQL = " Where " & strSearchWord
        strSearchSQL = strSearchSQL & " like '%" & strSearchString & "%'"
   End If

   strSQL = "SELECT Count(*)"
   strSQL = strSQL & ",CEILING(CAST(Count(*) AS FLOAT)/" & intPageSize & ")"
   strSQL = strSQL & " FROM board"
   If blnSearch Then
       strSQL = strSQL & strSearchSQL
   End If

   Set objDBConn = Server.CreateObject("ADODB.Connection")
   Set objRs = Server.CreateObject("ADODB.RecordSet")
   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   objRs.Open strSQL, objDBConn
   intTotalCount = objRs(0)
   intTotalPage = objRs(1)
   objRs.Close 


   strSQL = "SELECT Top " & intNowPage * intPageSize & " inx"   ' objRs(0) - 번호
   strSQL = strSQL & ",strID"                 ' objRs(1) - 이름
   strSQL = strSQL & ",strNotice"                ' objRs(2) - 메일주소
   strSQL = strSQL & ",strSubject"              ' objRs(3) - 제목
   strSQL = strSQL & ",WriteDate"               ' objRs(4) - 날짜
   strSQL = strSQL & ",WriteEnt"                ' objRs(5) - 조회수
   strSQL = strSQL & " FROM board"
   'Searching'
   If blnSearch Then
        strSQL = strSQL & strSearchSQL
   End If 
   strSQL = strSQL & " ORDER BY inx DESC"
 
   objRs.Open strSQL, objDBConn  
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
	  <% If objRs.BOF or objRs.EOF Then %>
	  <tr align="center">
		<td colspan="5">등록된 게시가 없습니다</td>
	  </tr>
	 <%
		   Else
			  'paging'
			  objRs.Move (intNowPage - 1) * intPageSize
			  '↑paging'
			  Do Until objRs.EOF
	 %>
	  <tr align="center">
	   <td><%=objRs(0)%></td>
		<td>
		   <a href="content.asp?seq=<%=objRs(0)%>"><%=objRs(3)%></a>
		</td>
		<td><%=objRs(1)%></td> 
		<td>
			<!-- 날짜 -->
			<%If IsNull(objRs(4)) Then 
				response.write "날짜없음" 
			  Else 
				response.write(Replace(Mid(objRs(4),1,10),"-",".")) 
			  End If%></td> 
		<td>
			<!-- 조회수 -->
			<%If IsNull(objRs(5)) Then 
				response.write "0" 
			  Else 
				response.write(objRs(5))
			  End If %>
		</td> 
	  </tr>
	 <%
					  objRs.MoveNext
				  Loop
		   End If

		   objRs.Close
		   Set objRs = nothing
		   objDBConn.Close
		   Set objDBConn = nothing
	 %>
	 </table>
	 <!-- paging -->
	 <table width="600">
	  <tr>
		<td align="center">
		<%
			' intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1

			' If intTemp = 1 Then
			'	 Response.Write "[이전 " & intBlockPage & "개]"
			' Else
			'	 Response.Write"<a href=list.asp?page=" & intTemp - intBlockPage &  _
			'		"&search_word=" & strSearchWord & _
			'		"&search_string=" & strSearchString & _ 
			'		">[이전 " & intBlockPage & "개]</a>"

			'End If

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

			'If intTemp > intTotalPage Then
			' Response.Write "[다음 " &intBlockPage&"개]"
			'Else
			'	  Response.Write"<a href=list.asp?page=" & intTemp &  _
			'		"&search_word=" & strSearchWord & _
			'		"&search_string=" & strSearchString & _ 
			'		">[다음 " & intBlockPage & "개]</a>"
			'End If
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