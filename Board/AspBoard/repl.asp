<%@ Language=VBScript %>
<%  Option Explicit   %>
<% '디비 커넥션 %>
<!--#include file="./inc/inc_dbCon.asp"-->
<% '/디비 커넥션 %>
<%
    Dim GetTable      : GetTable      = request("table")
    Dim GetPage       : GetPage       = request("page")
    Dim GetSearchPart : GetSearchPart = request("SearchPart")
	Dim GetSearchStr  : GetSearchStr  = request("SearchStr")
	Dim GetSeq        : GetSeq        = request("seq")
	
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
        Dim GetBD_CONTENT	
		GetBD_CONTENT =  "====================================================<br>" 
        GetBD_CONTENT = GetBD_CONTENT & GetBD_NAME & "님이 작성한 글"
		GetBD_CONTENT = GetBD_CONTENT & "====================================================" 
        GetBD_CONTENT = GetBD_CONTENT & replace(Rs(6),"\n","\n>")
					

		Dim GetBD_BD_PASSWORD : GetBD_BD_PASSWORD   = Rs(7)
        Dim GetBD_BD_INPUTDATE: GetBD_BD_INPUTDATE  = Rs(8)
        Dim GetBD_BD_IP		: GetBD_BD_IP			= Rs(9)
        Dim GetBD_READCOUNT : GetBD_READCOUNT		= Rs(10)
	    Dim GetBS_STATE		: GetBS_STATE		    = Rs(11)
    Rs.close
	set rs = nothing

%>
<html>
<head>
<title>Board</title>
<link href="./inc/css1.css" rel="stylesheet" type="text/css">
<script Language='JavaScript' src='./inc/editor.js'></script>
<script language="Javascript1.2" src='./inc/JsEditor.js'></script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<form method="post" name="board_repl" action="repl_ok.asp" enctype="MULTIPART/FORM-DATA">
		<input type="hidden" name="table"      value="<%= GetTable %>"     >
		<input type="hidden" name="page"       value="<%= GetPage %>"      >
		<input type="hidden" name="seq"       value="<%= GetSeq %>"      >
		<input type="hidden" name="SearchPart" value="<%= GetSearchPart %>">
		<input type="hidden" name="SearchStr"  value="<%= GetSearchStr %>" >
	    
		<table width="606" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr bgcolor="4B6377"> 
                      <td height="3" colspan="5"></td>
                    </tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2" >성명  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_NAME" size="50"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">이메일  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_EMAIL" size="50"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">비밀번호  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_PASSWD" size="50"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
					<tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2" maxlength="27">제목  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_SUBJECT" size="50"  value="re:<%=GetBD_SUBJECT%>"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">내용  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3" bgcolor="#ece9d8"><TEXTAREA style="WIDTH: 500px; HEIGHT: 200px" name="MinBoardContents" border="1"><%=GetBD_CONTENT%></TEXTAREA><br><br>
                      </td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">파일첨부  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="File" name="formFile" size="50"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>                  
					<tr bgcolor="4B6377"> 
					  <td height="3" colspan="5"></td>
					</tr>

		 </table>

		 <table  width="606" border="0" cellspacing="0" cellpadding="0" align="center">
		    <tr> 
			    <td height="10"></td>
			</tr>
			<tr>
				<td align=center>
					<a href="#"><img src="./image/INPUT_OK.gif" onclick="submit();" border="0"></a>&nbsp;&nbsp;
					<a href="#"><img src="./image/reset.gif" onclick="reset();" border="0"></a>&nbsp;&nbsp;
					<a href="list.asp?table=<%=GetTable%>&page=<%= GetPage %>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>"><img src="./image/list.gif" border="0"></a>
				</td>
			</tr>
		 </table>

		 <script language="javascript1.2">
             editor_generate('MinBoardContents');
         </script>

</form>
</body>
</html>