<%@ Language=VBScript %>
<%  Option Explicit   %>
<% '��� Ŀ�ؼ� %>
<!--#include file="./inc/inc_dbCon.asp"-->
<% '/��� Ŀ�ؼ� %>
<%
    Dim up_form
    Set up_form = Server.CreateObject("SiteGalaxyUpload.Form")
    

    Dim GetId      : GetId		= Request.Cookies("USER")("C_id")
    Dim GetName    : GetName	= Request.Cookies("USER")("C_name")
    Dim GetEmail   : GetEmail   = Request.Cookies("USER")("C_mail")
    Dim GetPasswd  : GetPasswd  = Request.Cookies("USER")("C_pw")

    Dim GetTable    : GetTable  = up_form("table")
	Dim GetSeq      : GetSeq    = up_form("seq")

    Dim GetFile_space : GetFile_space  = 5000000   '���ε� 5�ް��� ����
    Dim GetPage       : GetPage        = up_form("page")
    Dim GetSearchPart : GetSearchPart  = up_form("SearchPart")
	Dim GetSearchStr  : GetSearchStr   = up_form("SearchStr")

    Dim GetBD_SUBJECT  : GetBD_SUBJECT  = replace(up_form("formBD_SUBJECT"),"'","''")
    Dim GetBD_CONTENT  : GetBD_CONTENT  = replace(up_form("MinBoardContents"),"'","''")

    Dim GetBD_ID       : GetBD_ID    = up_form("formBD_ID")
	GetBD_ID = 1 '���������� �ʱ�ȭ ��Ų��.

	Dim GetBD_NAME     : GetBD_NAME  = up_form("formBD_NAME")
	Dim GetBD_EMAIL    : GetBD_EMAIL = up_form("formBD_EMAIL")
	Dim GetBD_PASSWD   : GetBD_PASSWD= up_form("formBD_PASSWD")
	Dim GetUser_IP     : GetUser_IP  = Request.ServerVariables("Remote_addr")

	'�θ���� data ���ְ� ����
	Sql = "SELECT BD_SEQ , BD_THREAD , BD_DEPTH FROM " & GetTable & "  WHERE BD_SEQ =" & GetSeq

    Set Rs = Con.Execute(Sql)
	Dim GetBD_SEQ    : GetBD_SEQ    = Rs(0)
	Dim GetBD_THREAD : GetBD_THREAD = Rs(1)
	Dim GetBD_DEPTH  : GetBD_DEPTH  = Rs(2)
	Dim GetPreBD_THREAD : GetPreBD_THREAD = (GetBD_THREAD-1)/1000 * 1000
	Rs.close
	

	    
	Sql = " UPDATE " & GetTable & " SET BD_THREAD = BD_THREAD - 1 "
    Sql = Sql & "	Where BD_THREAD < " & GetBD_THREAD & " AND BD_THREAD > "  & GetPreBD_THREAD
		
	con.Execute(Sql)
    

    '�Է�
    Sql = "insert into " & GetTable & " (BD_THREAD, BD_DEPTH , BD_ID ,  BD_NAME, BD_EMAIL , BD_SUBJECT , "
	Sql = Sql & " BD_CONTENT,  BD_PASSWD, BD_INPUTDATE, BD_IP , BD_READCOUNT, BD_STATE) "
	Sql = Sql & " values ( "
    Sql = Sql &  GetBD_THREAD-1 & ", '"& GetBD_DEPTH + 1 &"' ,  "
	Sql = Sql & "'"& GetBD_ID &"','"& GetBD_NAME &"','"& GetBD_EMAIL &"','"& GetBD_SUBJECT &"','"& GetBD_CONTENT 
	Sql = Sql & "','"& GetBD_PASSWD  &"',getdate(), '" &GetUser_IP & "', 0, 1)"
    
	con.Execute(Sql)
  
'======================== ȭ�� ���ε� ========================
    dim fc
    dim folder
    dim storedir
    dim checkEmpty
    
    set fc = CreateObject("Scripting.FileSystemObject")
    folder=".\upload\"		
    storedir=server.mappath(folder)+"\"
    		
    checkEmpty = up_form("formFile")
    if Len(checkEmpty) > 0 then	

    	dim attach_file
    	dim attach_size
    	dim attach_name
    	dim strname
    	dim strext
    	dim full_attach_name
    	dim fexist
    	dim count
    	
    	attach_file	= up_form("formFile").filepath   '������ ����� ��θ� ����
    	attach_size	= up_form("formFile").size
    	
    	if Clng(attach_size / (1024 * 1000)) > Clng(GetFile_space) then
            Response.Write("<script language=javascript>")
            Response.Write("    alert('���Ͽ뷮�� �ʹ� Ů�ϴ�.\n\n 5Mbyte �̻���ε� �Ҽ������ϴ�.');")
            Response.Write("    history.back();")
			Response.Write("</script>")
    		Response.End 
    	end if
    	 

    	attach_name = mid(attach_file, instrrev(attach_file,"\")+1)     '��θ��� ������ ���ϸ��� ����
    	strname		= mid(attach_name, 1, instrrev(attach_name,".")-1)  '���ϸ����� �̸��� Ȯ���ڸ� �и�
    	strext		= mid(attach_name,instrrev(attach_name,".")+1)
    	  	
    	full_attach_name = storedir & attach_name
    						
    	fexist = true
    	count=0		
    	do while fexist  '������ �ߺ��� ��� �̸��� �ٽ� ���� -�����̸� �ڿ� ���ڸ� �ٿ��� ��
    		if(fc.fileexists(full_attach_name)) then
    			count			 = count + 1
    			attach_name		 = strname&"-"&count&"."&strext
    			full_attach_name = storedir & attach_name
    		else
    		fexist=false
    		end if
    	loop
    	
    	'������Ʈ�� ���� ���� ������ ���ε�
    	up_form("formFile").saveas full_attach_name
    	'seq max��
		Sql = "SELECT MAX(BD_SEQ) FROM  " & GetTable 
		Set Rs = Con.Execute(Sql)
			if not Rs(0) = "" then
			   Dim GetMaxBD_SEQ    : GetMaxBD_SEQ    = Rs(0)
			end if
		Rs.close

    	'���� ���� �Է�
    	Sql = "insert into "  & GetTable &"_pds(FILE_BD_SEQ, FILE_BD_TABLE, FILE_NAME, FILE_SIZE) values "
    	Sql = Sql & "('"& GetMaxBD_SEQ &"', '"& GetTable &"', '"& attach_name &"', '"& attach_size &"')"
		
		Con.Execute(Sql)
    end if
    set fc=nothing
'======================== ȭ�� ���ε� �� ========================

'������ �̵�
Response.Redirect "list.asp?table=" & GetTable & "&page=" & GetPage & "&SearchPart=" & GetSearchPart & "&SearchStr=" & GetSearchStr
%>