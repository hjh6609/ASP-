<%@ Language=VBScript %>
<%  Option Explicit   %>
<% '��� Ŀ�ؼ� %>
<!--#include file="./inc/inc_dbCon.asp"-->
<% '/��� Ŀ�ؼ� %>
<%
	'���� ����
	Dim GetTable,GetPage, GetSeq, GetId, GetPasswd, GetSearchPart, GetSearchStr
	Dim C_id, C_passwd, file_name, fc, storedir
	
	GetTable      = request("table")
	GetSeq        = request("seq")
	GetPage	      = request("page")
	GetSearchPart = request("SearchPart")
	GetSearchStr  = request("SearchStr")
	
	'C_id       = Request.Cookies("USER")("C_id")
    'C_passwd   = Request.Cookies("USER")("C_pw")
	C_passwd    = Request.Form("formDelPasswd")

	if GetPage         = "" then GetPage        = 1
	
    Sql = "select BD_PASSWD from " & GetTable & " where BD_SEQ = " & GetSeq
	Set Rs = Con.Execute(Sql)
	
	if rs.BOF or rs.EOF then
	    Response.Write("<script language=javascript>")
        Response.Write("    alert('�Խù��� �������� �ʽ��ϴ�...');")
        Response.Write("    history.back();")
		Response.Write("</script>")
    	Response.End 
	else 
	    GetPasswd = Rs(0)	    
	end if
	Response.write C_passwd
	Sql = "select FILE_NAME from " & GetTable & "_PDS  where FILE_BD_SEQ = " & GetSeq & " and FILE_BD_TABLE = '" & GetTable & "'"
	
	Set Rs = Con.Execute(Sql)
	
	if not (rs.BOF or rs.EOF) then
	    file_name = Rs(0)
	end if
	
	Rs.close
	
	if GetPasswd  = C_passwd then
	    '********************  �Խñ� ����
	    Sql = "delete from " & GetTable & " where BD_SEQ = " & GetSeq
	    Con.Execute(Sql)
	
	    if not file_name = "" then
			'********************  ���� ����
			Sql = "delete from " & GetTable & "_PDS where  FILE_BD_SEQ = " & GetSeq & " and FILE_BD_TABLE = '" & GetTable & "'"
			Con.Execute(Sql)

	        set fc   = CreateObject("Scripting.FileSystemObject") 
            storedir = server.mappath(".") & "\upload\"
            fc.DeleteFile(storedir & file_name)
			set fc=nothing
	    end if
	else
	    Response.Write("<script language=javascript>")
        Response.Write("    alert('�Խù��� ���� ������ �����ϴ�..');")
        Response.Write("    history.back();")
		Response.Write("</script>")
    	Response.End 
	end if
   
'������ �̵�
Response.Redirect "list.asp?page=" & GetPage & "&SearchPart=" & GetSearchPart & "&SearchStr=" & GetSearchStr
%>