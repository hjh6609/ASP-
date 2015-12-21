<%
   Option Explicit '�� ���������� ���Ǵ� ��� �������� �ݵ�� ����Ǿ��� ���Ŀ� ��� �� �� �ִ�'
 
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


   strSQL = "SELECT Top " & intNowPage * intPageSize & " inx"   ' objRs(0) - ��ȣ
   strSQL = strSQL & ",strName"                 ' objRs(1) - �̸�
   strSQL = strSQL & ",strEmail"                ' objRs(2) - �����ּ�
   strSQL = strSQL & ",strSubject"              ' objRs(3) - ����
   strSQL = strSQL & ",WriteDate"               ' objRs(4) - ��¥
   strSQL = strSQL & ",WriteEnt"                ' objRs(5) - ��ȸ��
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
 <title>��Ϻ���</title>
 </head>
 <body>
 <div align="center">
 <h2>��Ϻ���</h2>
 <table width="600">
 <form name= "searchForm" method="get">  <!-- Searching -->
   <tr>
     <!-- paging -->
	 <% If intTotalCount > 0 Then %>
	 <td>��ü�Խ� <%=intTotalCount%> �� &nbsp;&nbsp;&nbsp;&nbsp;
            ���������� : <%=intNowPage%> / <%=intTotalPage%>
     </td>
	<%  End If  %>
	 <!-- Searching -->
	 <td align="right">
		  <select name="search_word">
			  <option value="strName">�̸�</option>
			  <option value="strSubject">����</option>
			  <option value="strContent">����</option>
		  </select>
		  <input type="text" name="search_string" size="15">
		  <input type="submit" value="�˻�">
	 </td>
   </tr>
 </form>
 </table>
 <!-- paging -->
 <table border width="600">
	  <tr align="center">
		 <td>��ȣ</td>
		 <td>����</td>
		 <td>�ۼ���</td>
		 <td>��¥</td>
		 <td>��ȸ��</td>
	  </tr>
  <% If objRs.BOF or objRs.EOF Then %>
  <tr align="center">
    <td colspan="5">��ϵ� �Խð� �����ϴ�</td>
  </tr>
 <%
       Else
          'paging'
		  objRs.Move (intNowPage - 1) * intPageSize
		  '��paging'
		  Do Until objRs.EOF
 %>
  <tr align="center">
   <td><%=objRs(0)%></td>
    <td>
       <a href="content.asp?seq=<%=objRs(0)%>"><%=objRs(3)%></a>
    </td>
    <td><%=objRs(1)%></td> 
	<td>
		<!-- ��¥ -->
		<%If IsNull(objRs(4)) Then 
			response.write "��¥����" 
		  Else 
			response.write(Replace(Mid(objRs(4),1,10),"-",".")) 
		  End If%></td> 
	<td>
		<!-- ��ȸ�� -->
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
             Response.Write "[���� " & intBlockPage & "��]"
         Else
             Response.Write"<a href=list.asp?page=" & intTemp - intBlockPage &  _
                "&search_word=" & strSearchWord & _
                "&search_string=" & strSearchString & _ 
                ">[���� " & intBlockPage & "��]</a>"

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
             Response.Write "[���� " &intBlockPage&"��]"
         Else
              Response.Write"<a href=list.asp?page=" & intTemp &  _
                "&search_word=" & strSearchWord & _
                "&search_string=" & strSearchString & _ 
                ">[���� " & intBlockPage & "��]</a>"
         End If
    %>	
    </td>
  </tr>
</table>
 <!-- paging -->
 <% If blnSearch Then %>
 <a href="list.asp">�������&nbsp;
 <% End If %> 
 <a href="regist.asp">�۾���</a>
 </div>
 </body>
</html> 