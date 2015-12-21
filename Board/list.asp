<%
   Option Explicit '이 페이지에서 사용되는 모든 변수들은 반드시 선언되어진 이후에 사용 될 수 있다'
 
   Dim objDBConn
   Dim objRs
   Dim strSQL
   
   'paging'
   Dim intNowPage, intTotalCount, intTotalPage, intBlockPage, intPageSize
   Dim intTemp, intLoop

   'Searching'
   Dim strSearchWord, strSearchString, strSearchSQL
   Dim blnSearch

   intNowPage = Request.QueryString("page")
   strSearchWord = Request.QueryString("search_word")'Searching'
   strSearchString = Request.QueryString("search_string")'Searching'
   blnSearch = false'Searching'
   intPageSize = 10
   intBlockPage = 10

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
   strSQL = strSQL & ",strName"                 ' objRs(1) - 이름
   strSQL = strSQL & ",strEmail"                ' objRs(2) - 메일주소
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
 <html>
 <head>
 <title>목록보기</title>
 </head>
 <body>
 <div align="center">
 <h2>목록보기</h2>
 <table width="600">
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
			  <option value="strName">이름</option>
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
 <table border width="600">
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
         intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1
		 'intTemp = 2

         If intTemp = 1 Then
             Response.Write "[이전 " & intBlockPage & "개]"
         Else
             Response.Write"<a href=list.asp?page=" & intTemp - intBlockPage &  _
                "&search_word=" & strSearchWord & _
                "&search_string=" & strSearchString & _ 
                ">[이전 " & intBlockPage & "개]</a>"

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
             Response.Write "[다음 " &intBlockPage&"개]"
         Else
              Response.Write"<a href=list.asp?page=" & intTemp &  _
                "&search_word=" & strSearchWord & _
                "&search_string=" & strSearchString & _ 
                ">[다음 " & intBlockPage & "개]</a>"
         End If
    %>	
    </td>
  </tr>
</table>
 <!-- paging -->
 <% If blnSearch Then %>
 <a href="list.asp">목록으로&nbsp;
 <% End If %> 
 <a href="regist.asp">글쓰기</a>
 </div>
 </body>
</html> 