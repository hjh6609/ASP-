<%@ Language=VBScript %>
<%  Option Explicit   %>
<% '디비 커넥션 %>
<!--#include file="./inc/inc_dbCon.asp"-->
<% '/디비 커넥션 %>
<html>
<head>
<title>Board</title>
<link href="./inc/css1.css" rel="stylesheet" type="text/css">
<script Language='JavaScript' src='js/board.js'></script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<%
    Response.Write("<script language=javascript>")
	Response.Write("alert(1);")
	Response.Write("</script>")

	Dim GetTable,GetPage, intTotalCount, intTotalPage, intBlockPage, intPageSize
    Dim intTemp, intLoop ,order_num
    Dim GetSearchStr, GetSearchPart, wc , Rs1

    GetTable     = request("table")
    GetPage      = request("page")
    intPageSize  = 10
    intBlockPage = 10
    GetSearchStr = request("SearchStr")
    GetSearchPart= request("SearchPart")
    
    if GetTable      = "" then GetTable       = "AspBoard"
    if GetSearchPart = "" then GetSearchPart  = "BD_SUBJECT"
	if GetSearchStr  <> "" then
	    wc = " where " & GetSearchPart & " like '%" & GetSearchStr & "%' and BD_STATE = 1"
	else
	    wc = " where BD_STATE = 1"
	end if

    If Len(GetPage) = 0 Then
        GetPage = 1
    End If
 
    sql = "Select Count(*)"
    sql = sql & ",CEILING(CAST(Count(*) AS FLOAT)/" & intPageSize & ")"
    sql = sql & " from " & GetTable & wc
 
    Set Rs = Con.Execute(sql)
    intTotalCount = Rs(0)
    intTotalPage = Rs(1)
    Rs.Close 
    
	
	 sql = "SELECT TOP 10  BD_SEQ , BD_THREAD , BD_DEPTH ,  BD_NAME , BD_SUBJECT, BD_INPUTDATE, BD_READCOUNT  "
     sql = sql & " FROM " & GetTable & wc 
     sql = sql & "  AND BD_THREAD NOT IN "
     sql = sql & " (SELECT Top "  &  Cstr(10 * (GetPage-1)) &  " BD_THREAD FROM " &GetTable & wc & " ORDER BY BD_THREAD DESC) "
     sql = sql & "  ORDER BY BD_THREAD DESC "
     
	
    set Rs = Con.execute(sql)
%> 
<table width="657" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="10">&nbsp;</td>
  </tr>
   <tr>  
   <form method="post" name="search" action="list.asp">
    <td >		
		<table>
		<tr>
		<td align="left" width="225">
			<select name=SearchPart>
				<option value=BD_SUBJECT <% if GetSearchPart = "BD_SUBJECT" then Response.Write("selected") end if %>>제목 
				<option value=BD_CONTENT <% if GetSearchPart = "BD_CONTENT" then Response.Write("selected") end if %>>내용 
				<option value=BD_NAME    <% if GetSearchPart = "BD_NAME" then Response.Write("selected") end if %>>작성자 
			</select>
			<input type="text" size=20 name=SearchStr value="<%= GetSearchStr %>">			
	     </td>
		 <td width="350">
			<input type="image" src="./image/search.gif" value="찾  기" name="submit" onclick="submit();">
		 </td>
		 <td align="right">
		 	<a href="write.asp?table=<%=GetTable%>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"><img src="./image/write.gif" border="0"></a> 
		 </td>
		 </tr>
		 </table>	     
    </td>  
	</form>
  </tr>
  <tr> 
    <td height="3"></td>
  </tr>
  <tr> 
    <td> 
     <table width="657" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr bgcolor="4B6377"> 
                      <td height="3" colspan="6"></td>
                    </tr>
                    <tr> 
                      <td width="41" height="27" align="center" bgcolor="f2f2f2">번호 </td>
                      <td width="364" height="27" align="center" bgcolor="f2f2f2">내용 </td>
					  <td width="51" align="center" bgcolor="f2f2f2">파일 </td>
                      <td width="102" align="center" bgcolor="f2f2f2">작성일</td>
                      <td width="48" align="center" bgcolor="f2f2f2">작성자 </td>
                      <td width="51" align="center" bgcolor="f2f2f2">조회수 </td>
                    </tr>
					<tr> 
					  <td height="1" colspan="6" align="center" bgcolor="7D8E9D"></td>
					</tr>
<% 
           order_num = intTotalCount - Int((GetPage - 1))*intPageSize
           If Rs.BOF or Rs.EOF Then 

		   
%>

					  <tr height="22" bgcolor="#FFFFFF">
						<td colspan="6" align="center"><font color="blue"><B>게시글</B></font>이 <font color="red">없습니다.</font></td>
					  </tr>    
					<tr> 
					  <td height="1" colspan="6" align="center" bgcolor="7D8E9D"></td>
					</tr>
<% 
           Else 
             
              Do Until Rs.EOF
%>        

	   <tr> 
		  <td height="25" align="center" bgcolor="f2f2f2"><%=order_num%></td>
		  <td height="25">
		    <%				
			    If Rs(2) > 0 Then 
				    Response.Write ("<img src='./image/blank.gif' height='1' width='"& Rs(2) * 15& "'>")
					Response.Write ("<img src='./image/re.gif'>")
				End IF
			%>&nbsp;
			<A href="view.asp?table=<%=GetTable%>&seq=<%=Rs(0)%>&page=<%=GetPage%>&SearchPart=<%=GetSearchPart%>&SearchStr=<%=GetSearchStr%>">
				<% 
					if len( Rs(4) ) >27 Then 
						Response.write ( mid(rs(4), 1 ,27) & "..." )
					Else
                        Response.write rs(4)
					End If
				%>
			</a>
		  </td>
		  <td width="51" align="center" bgcolor="f2f2f2"> 
 			<%				
			   
		  	Sql = "SELECT Right(File_NAME,3) , File_Name FROM  " & GetTable & "_PDS WHERE  FILE_BD_SEQ = " & RS(0) & " and FILE_BD_TABLE ='" & GetTable &"'"
         	Set Rs1 = Con.Execute(Sql)
					if not Rs1.Eof then
					  Response.Write ("<a href='#'>")
					  Response.Write ("<img src='./image/"+Rs1(0)+".gif' alt='"&Rs1(1)&"' border=0>")
					  Response.Write ("</a>")
					end if
			Rs1.close
		  
			%>
		  </td>
		  <td align="center"><%=left(Rs(5),10)%></td>
		  <td align="center" bgcolor="f2f2f2"><%=Rs(3)%></td>
		  <td height="25" align="center"><%=Rs(6)%></td>
		</tr>
		<tr> 
		  <td height="1" colspan="6" align="center" bgcolor="7D8E9D"></td>
		</tr>

<%			  
		   If Rs(6) == "" Then
			  Response.Write "0"
		   End If
              order_num = order_num - 1
              Rs.MoveNext
              Loop
           End If

		   

	Response.Write("<script language=javascript>")
	Response.Write("alert();")
	Response.Write("</script>")
    
    Rs.close()    
    Con.close()
    set Con = nothing
%>

		<tr bgcolor="4B6377"> 
		  <td height="3" colspan="6"></td>
		</tr>
    </table>

    <br>
<!--//장수 페이징-->    
    <table width="657" border="0" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td align="center">
<%
            intTemp = Int((GetPage - 1) / intBlockPage) * intBlockPage + 1

            If intTemp = 1 Then
                Response.Write "[이전 " & intBlockPage & "개]"
            Else 
                Response.Write"<a href=list.asp?table=" & GetTable & "&page=" & intTemp - intBlockPage & ">[이전 " & intBlockPage & "개]</a>"
            End If

            intLoop = 1

            Do Until intLoop > intBlockPage Or intTemp > intTotalPage
                If intTemp = CInt(GetPage) Then
                    Response.Write "<b>" & intTemp &"</b>&nbsp;" 
                Else
                    Response.Write"<a href=list.asp?table=" & GetTable & "&page=" & intTemp & ">" & intTemp & "</a>&nbsp;"
                End If
                intTemp = intTemp + 1
                intLoop = intLoop + 1
            Loop

            If intTemp > intTotalPage Then
                Response.Write "[다음 " &intBlockPage&"개]"
            Else
                Response.Write"<a href=list.asp?table=" & GetTable & "&page=" & intTemp & ">[다음 " & intBlockPage & "개]</a>"
            End If
%>
        </td>
      </tr>
    </table>

    </td>
  </tr>
</table>
</body>
</html>


