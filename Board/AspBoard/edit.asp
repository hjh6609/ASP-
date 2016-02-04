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
    'C_id       = Request.Cookies("USER")("C_id")
    'C_passwd   = Request.Cookies("USER")("C_pw")
	Dim C_passwd      : C_passwd      = Request.Form("formDelPasswd")

    '/수정부분 암호 확인 부분
	Sql = "select BD_PASSWD from " & GetTable & " where BD_SEQ = " & GetSeq
	Set Rs = Con.Execute(Sql)
	
	if rs.BOF or rs.EOF then
	    Response.Write("<script language=javascript>")
        Response.Write("    alert('게시물이 존재하지 않습니다...');")
        Response.Write("    history.back();")
		Response.Write("</script>")
    	Response.End 
	else 
	    Dim GetPasswd : GetPasswd = Rs(0)	
		Rs.close()
	end if

	if not GetPasswd  = C_passwd then
   
		Response.Write("<script language=javascript>")
		Response.Write("    alert('게시물에 대한 권한이 없습니다..');")
		Response.Write("    history.back();")
		Response.Write("</script>")
		Response.End 

	End If	

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
        Dim GetBD_CONTENT	: GetBD_CONTENT         = Rs(6)
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
<form method="post" name="board_edit" action="edit_ok.asp" enctype="MULTIPART/FORM-DATA">
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
					  <td colspan="3">&nbsp; <input type="text" name="formBD_NAME" size="50" value="<%=GetBD_NAME%>"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">이메일  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_EMAIL" size="50" value="<%=GetBD_EMAIL%>"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>                  
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">비밀번호  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_PASSWD" size="50" value="수정시 입력이 필요없습니다." readonly></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D" ></td>
					</tr>
					<tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2" maxlength="27">제목  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_SUBJECT" size="50"  value="<%=GetBD_SUBJECT%>"></td> 
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
						<%				
						Dim Rs1
						Sql = "SELECT Right(File_NAME,3) , File_Name , FILE_SEQ FROM  " & GetTable & "_PDS WHERE  FILE_BD_SEQ = " & GetSeq & " and FILE_BD_TABLE ='" & GetTable &"'"
						Set Rs1 = Con.Execute(Sql)
								if not Rs1.Eof then
						%>
							<tr> 
							  <td width="81" height="27" align="center" bgcolor="f2f2f2">기존파일  </td>
							  <td width="1"  bgcolor="7D8E9D">
							  </td> 
							  <input type="hidden" name="formDelFileName"  value="<%= Rs1(1) %>" >
							  <input type="hidden" name="formDelFileSeq"  value="<%= Rs1(2) %>" >
						<%
								  Response.write ("<td colspan=3>")
								  Response.Write ("&nbsp; <img src='./image/"+Rs1(0)+".gif' alt='"&Rs1(1)&"' border=0> : " & Rs1(1) &"의 파일이 존재합니다.")			
								  Response.write ("아래 파일첨부를 할시 기존파일은 삭제가 됩니다.</td></tr> ")
								end if
						Rs1.close
					  
						%>
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
				<td align=center height="10"></td>
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