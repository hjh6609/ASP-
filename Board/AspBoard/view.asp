<%@ Language=VBScript %>
<%  Option Explicit   %>
<% '디비 커넥션 %>
<!--#include file="./inc/inc_dbCon.asp"-->
<% '/디비 커넥션 %>
<%
	Dim GetTable , GetSeq
	Dim GetPage, GetSearchPart, GetSearchStr
       
    GetTable		= request("table")
    GetSeq			= request("seq")
    GetPage			= request("page")
    GetSearchPart	= request("SearchPart")
    GetSearchStr	= request("SearchStr")
       
    '내용 출력
    Sql = "select BD_SEQ, BD_THREAD , BD_DEPTH , BD_NAME, BD_EMAIL ,BD_SUBJECT, BD_CONTENT, BD_PASSWD ,  BD_INPUTDATE, BD_IP, BD_READCOUNT ,BD_STATE from "
    Sql = Sql & GetTable & " where BD_seq = " & GetSeq

    Set Rs = Con.Execute(Sql)
        Dim GetBD_SEQ		: GetBD_SEQ				= Rs(0)
        Dim GetBD_THREAD	: GetBD_THREAD			= Rs(1)
        Dim GetBD_DEPTH		: GetBD_DEPTH			= Rs(2)
        Dim GetBD_NAME		: GetBD_NAME			= Rs(3)
        Dim GetBD_EMAIL		: GetBD_EMAIL			= Rs(4)
        Dim GetBD_SUBJECT	: GetBD_SUBJECT			= Rs(5)
        Dim GetBD_CONTENT	: GetBD_CONTENT			= Rs(6)
		Dim GetBD_BD_PASSWORD : GetBD_BD_PASSWORD   = Rs(7)
        Dim GetBD_BD_INPUTDATE: GetBD_BD_INPUTDATE  = Rs(8)
        Dim GetBD_BD_IP		: GetBD_BD_IP			= Rs(9)
        Dim GetBD_READCOUNT : GetBD_READCOUNT		= Rs(10)
	    Dim GetBS_STATE		: GetBS_STATE		    = Rs(11)
    Rs.close
    
    '파일 정보 출력
	Sql = "select FILE_SEQ , FILE_BD_SEQ, FILE_BD_TABLE , FILE_NAME , FILE_SIZE from "& GetTable &"_pds"
	Sql = Sql & " where FILE_BD_SEQ = " & GetBD_SEQ & " and FILE_BD_TABLE = '" & GetTable & "'"

	Set Rs = Con.Execute(Sql)
	 Dim GetFILE_NAME , GetFILE_SIZE , GetFileImage
	    if not (Rs.BOF or Rs.EOF) then
    	   GetFILE_NAME      = Rs(3)
    	   GetFILE_SIZE      = Rs(4)
		   GetFileImage      = "<td width=20><img src='./image/"+Right(GetFILE_NAME,3)+".gif' border=0></td>"

		Else
		   GetFILE_NAME      = " no"
    	   GetFILE_SIZE      = " no"
		   GetFileImage      = " "
    	end if
	Rs.close
	
	Sql = "update " & GetTable & " set BD_READCOUNT = BD_READCOUNT + 1 where BD_SEQ = " & GetSeq
    Con.Execute(Sql)
%>
<html>
<head>
<title>Board</title>
<link href="./inc/css1.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <br>
	<table width="657" border="0" cellpadding="0" cellspacing="0" align="center">
			  <tr bgcolor="4B6377"> 
                <td height="3"></td>
              </tr>
			  <tr> 
				<td align="center" >
				  <table width="657" border="0" cellspacing="0" cellpadding="0">
					<tr align="center"> 
					  <td height="24" width="500" bgcolor="f2f2f2"><strong>* <%= GetBD_SUBJECT %> * </strong></td>
					  <td height="24" bgcolor="f2f2f2">[ 조회수 : <%= GetBD_READCOUNT %> ]</td>
					</tr>
				  </table>
				 </td>
			  </tr>
			  <tr> 
					<td height="1" align="center" bgcolor="7D8E9D"></td>
			  </tr>
			  <tr> 
				<td height="24"  bgcolor="f2f2f2" align="center">
				  
				  <table border="0" width="657" cellspacing="0" cellpadding="0">
					<tr> 
					  <td width="100" height="24" align="center">작성자 : <%= GetBD_NAME %> </td>
					  <td width="230" height="24" align="left">(<%= GetBD_EMAIL %>)  </td>
					  <td width="35" height="24" align="right">파일 : </td>
					  <%=GetFileImage%>
					  <td  height="24" align="left" valign="middle">&nbsp;
					  <a href="./upload/<%= GetFILE_NAME %>">
						<%= GetFILE_NAME %> (<%= GetFILE_SIZE %> KByte)
					  </a>
					  </td>
					</tr>
				  </table>
				 
				 </td>
			  </tr>
			  <tr> 
					<td height="1" align="center" bgcolor="7D8E9D"></td>
			  </tr>
			  <tr> 
				<td height="5" align="center"></td>
			  </tr>
			  <tr> 
				<td height="22" align="center">
					
					<table width="100%" border="2" cellpadding="5" cellspacing="0" bordercolor="#CCCCCC">
					<tr> 
					  <td>
					    
						<div align="right"><U><%=GetBD_BD_IP%> 에서<B> <%= GetBD_BD_INPUTDATE %></B> 작성됨</div></U><br><br>

						<!-내용이 들어가는곳 START -->
					    
						<%= GetBD_CONTENT %>
						                        
						<!-내용이 들어가는곳 END -->

						
					  </td>
					</tr>				
				   </table>
				  </td>
			  </tr>
			  <tr> 
				<td height="15" align="center"></td>
			  </tr>
			  <tr> 
					<td height="1" align="center" bgcolor="7D8E9D"></td>
			  </tr>
			  <tr> 
				<td height="24"  bgcolor="f2f2f2" align="center">
				    <table width="95%">
						<tr>
						<%
							'================== 이전 글
							Sql = "select BD_SEQ, BD_NAME, BD_SUBJECT from " & GetTable
							Sql = Sql & " where BD_THREAD = (select min(BD_THREAD) from " & GetTable & " where BD_THREAD > " & GetBD_THREAD & ")"
							Set Rs = Con.Execute(Sql)
							if Rs.BOF or Rs.EOF then
						%>
							<td align="center">이전 글이 없습니다.</td>
						<%            
							else
						%>
							<td width="13%" align="left">&nbsp이전글△</td>
							<td width="72%" align="left"> 
								<a href="view.asp?table=<%=GetTable%>&seq=<%= Rs(0) %>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"> 
								<%= Rs(2) %></a> 
							</td>
							<td width="15%" align="center"><%= Rs(1) %></td>
						<%
							end if
							Rs.close
						%>	
						</tr>
					</table>					
				 </td>
			  </tr>
			  <tr> 
					<td height="1" align="center" bgcolor="7D8E9D"></td>
			  </tr>
			  <tr> 
				<td height="24"  bgcolor="#D4D4D4" align="center">
				  
				    <table width="95%">
						<tr>
						<%
							  '================== 다음 글
							Sql = "select BD_SEQ, BD_NAME, BD_SUBJECT from " & GetTable
							Sql = Sql & " where BD_THREAD = (select max(BD_THREAD) from " & GetTable & " where BD_THREAD < " & GetBD_THREAD & ")"
							Set Rs = Con.Execute(Sql)
							
							if Rs.BOF or Rs.EOF then
						%>
							<td align="center">다음 글이 없습니다.</td>
						<%            
							else
						%>
							<td width="13%" align="left">&nbsp다음글▽</td>
							<td width="72%" align="left"> 
								<a href="view.asp?table=<%=GetTable%>&seq=<%= Rs(0) %>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"> 
								<%= Rs(2) %></a> 
							</td>
							<td width="15%" align="center"><%= Rs(1) %></td>
						<%
							end if
							Rs.close
						%>	
						</tr>
					</table>				 
				 </td>
			  </tr>
			  <tr> 
					<td height="1" align="center" bgcolor="7D8E9D"></td>
			  </tr>
			  <tr bgcolor="4B6377"> 
                <td height="3"></td>
              </tr>
			</table>
	


      <table width="657" border="0" cellspacing="0" cellpadding="0" ALIGN="CENTER">
        <tr> 
          <td height="5">&nbsp;</td>
        </tr>
        <tr>          
			<td align="center">
			<a href="list.asp?table=<%=GetTable%>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"><img src="./image/list.gif" border="0"></a>&nbsp;&nbsp;
			<a href="write.asp?table=<%=GetTable%>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"><img src="./image/write.gif" border="0"></a>&nbsp;&nbsp;
			<a href="repl.asp?table=<%=GetTable%>&page=<%= GetPage %>&seq=<%=GetSeq%>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"><img src="./image/reply.gif" border="0"></a>&nbsp;&nbsp;
			<a href="ensure.asp?table=<%=GetTable%>&ReactionUrl=E&seq=<%= GetSeq %>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"><img src="./image/edit.gif" border="0"></a>&nbsp;&nbsp;
			<a href="ensure.asp?table=<%=GetTable%>&ReactionUrl=D&seq=<%= GetSeq %>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"><img src="./image/del.gif" border="0"></a>&nbsp;&nbsp;
			</td>
        </tr>
		 <tr> 
          <td height="30">&nbsp;</td>
        </tr>
      </table>

		
