<%@ Language=VBScript %>
<%  Option Explicit   %>
<% '��� Ŀ�ؼ� %>
<!--#include file="./inc/inc_dbCon.asp"-->
<% '/��� Ŀ�ؼ� %>
<%
	Dim GetTable , GetSeq
	Dim GetPage, GetSearchPart, GetSearchStr , GetReactionUrl
	Dim strTitle , strButton
       
    GetTable		= request.Querystring("table")
    GetSeq			= request.Querystring("seq")
    GetPage			= request.Querystring("page")
    GetSearchPart	= request.Querystring("SearchPart")
    GetSearchStr	= request.Querystring("SearchStr")
	GetReactionUrl  = request.Querystring("ReactionUrl")

	If GetReactionUrl = "D" Then 
		GetReactionUrl ="Del.asp"
		strTitle = "����"
		strButton = "del.gif"
	ElseIf GetReactionUrl = "E" Then 
        GetReactionUrl ="Edit.asp"
		strTitle = "����"
		strButton = "edit.gif"
	Else 
        Response.Write("<script language=javascript>")
        Response.Write("    alert('�ҹ� ����Դϴ�.�����ڿ��� ������...');")
        Response.Write("    history.back();")
		Response.Write("</script>")
    	Response.End 
	End If
%>
<html>
<head>
<title>Board</title>
<link href="./inc/css1.css" rel="stylesheet" type="text/css">
<script Language='JavaScript'>
    function goCheck(){
			var var1  = document.board_ensure.formDelPasswd.value;
						
		    if (var1.length   < 1) {	alert("���� ���� �Է��Ͻ� ��ȣ�� �����ּ���!");	document.board_ensure.formDelPasswd.focus();     return ;	}
								
			document.board_ensure.submit();    
    }
</script>
</head>
<form action="<%=GetReactionUrl%>?table=<%=GetTable%>&page=<%= GetPage %>&seq=<%=GetSeq%>&SearchPart=<%= GetSearchPart %>&SearchStr=<%= GetSearchStr %>" name="board_ensure" method="post">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">

	<table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr> 
		  <td height="23" colspan="3"></td>
		</tr>
		<tr bgcolor="4B6377"> 
		  <td height="3" colspan="3"></td>
		</tr>
		<tr> 
		  <td width="250" height="27" colspan="3" align="center" bgcolor="f2f2f2">
			<B>�Խù� <%=strTitle%></B>
          </td>		 	  
		</tr>
		<tr> 
			<td height="1" colspan="3" bgcolor="7D8E9D"></td>
		</tr>
		<tr> 
		  <td width="70" height="27" align="center"> ��й�ȣ </td>
		  <td height="27" colspan="2" align="center">
		     <input type="password" name="formDelPasswd">			
		  </td>		   
		</tr>
		<tr> 
			<td height="1" colspan="3" align="center">
			  <FONT COLOR="#FF6666"> * �� ��Ͻ� ����� <B>��ȣ</B>�� �Է��ϼ���.</FONT>
			</td>
		</tr>
		<tr> 
			<td height="1" colspan="3" bgcolor="7D8E9D"></td>
		</tr>
		<tr> 
		  <td width="250" height="30" align="center" colspan="3"  bgcolor="f2f2f2" valign="bottom">
				<a href="#"><img src="./image/<%=strButton%>" onclick="goCheck();" border="0"></a>&nbsp;&nbsp;			
				<a href="#"><img src="./image/cancel.gif" border="0" onclick="history.back();"></a>
				
		  </td>			  
		</tr>
		<tr bgcolor="4B6377"> 
		  <td height="3" colspan="3"></td>
		</tr>
	</table>
</form>
</body>
</html>