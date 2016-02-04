<%@ Language=VBScript %>
<%  Option Explicit   %>
<%
    Dim GetTable      : GetTable      = request("table")
    Dim GetPage       : GetPage       = request("page")
    Dim GetSearchPart : GetSearchPart = request("SearchPart")
	Dim GetSearchStr  : GetSearchStr  = request("SearchStr")
	
%>
<html>
<head>
<title>Board</title>
<link href="./inc/css1.css" rel="stylesheet" type="text/css">

<script language="Javascript1.2" src='./inc/JsEditor.js'></script>
<script Language='JavaScript' src='./inc/editor.js'></script>
<script Language='JavaScript'>
    function goCheck(){
			var var1  = document.board_write.formBD_NAME.value;
			var var2  = document.board_write.formBD_EMAIL.value;
			var var3  = document.board_write.formBD_PASSWD.value;
			var var4  = document.board_write.formBD_SUBJECT.value;
			var var5  = document.board_write.MinBoardContents.value;
			
		    if (var1.length   < 1) {	alert("성명 입력 하십시요!");	document.board_write.formBD_NAME.focus();     return ;	}
			if (var2.length   > 0){
				if (var2.search(/(\S+)@(\S+)\.(\S+)/) == -1 ) {
					alert("전자우편주소의 형식은 '계정@[호스트|도메인]'과 같이 구성되어야 합니다.");        
					document.board_write.formBD_EMAIL.focus();     		
					return;	}
			} 
			if (var3.length   < 1) {	alert("비밀번호 입력 하십시요!");	document.board_write.formBD_PASSWD.focus();	  return;	}
			if (var4.length   < 1) {	alert("제목을 입력 하십시요!");	document.board_write.formBD_SUBJECT.focus();     return;	}				       
			if (var5.length   < 1) {	alert("내용을 입력 하십시요!");	document.board_write.MinBoardContents.focus();	return;	}
					
			document.board_write.submit();    
    }
</script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<form method="post" name="board_write" action="write_ok.asp" enctype="MULTIPART/FORM-DATA">
		<input type="hidden" name="table"      value="<%= GetTable %>"     >
		<input type="hidden" name="page"       value="<%= GetPage %>"      >
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
					  <td colspan="3">&nbsp; <input type="text" name="formBD_NAME" size="50" value=""></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">이메일  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_EMAIL" size="50"  value=""></td> 
                    </tr>					
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">비밀번호  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="password" name="formBD_PASSWD" size="50"  value=""></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
					<tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">제목  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3">&nbsp; <input type="text" name="formBD_SUBJECT" size="50"  value="" maxlength="27"></td> 
                    </tr>
					<tr> 
					  <td height="1" colspan="5" align="center" bgcolor="7D8E9D"></td>
					</tr>
                    <tr> 
                      <td width="81" height="27" align="center" bgcolor="f2f2f2">내용  </td>
                      <td width="1"  bgcolor="7D8E9D">
                      </td>  
					  <td colspan="3" bgcolor="#ece9d8"><TEXTAREA style="WIDTH: 500px; HEIGHT: 200px" name="MinBoardContents" border="1"></TEXTAREA><br><br>
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
					<a href="#"><img src="./image/INPUT_OK.gif" onclick="goCheck();" border="0"></a>&nbsp;&nbsp;
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