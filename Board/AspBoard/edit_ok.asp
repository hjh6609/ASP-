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
	Dim GetDelFile_name: GetDelFile_name   = up_form("formDelFileName")   '������ ������ ���Ͽ� �������ϸ��� �޴���.
	Dim GetDelFileSeq  : GetDelFileSeq     = up_form("formDelFileSeq")   '������ ������ ���Ͽ� ��������Seq�� �޴���.

	

    '�Է�
    
    Sql = "update " & GetTable & " set BD_NAME = '"& GetBD_NAME &"', "
	Sql = Sql & " BD_EMAIL = '"& GetBD_EMAIL &"', "
	Sql = Sql & " BD_SUBJECT = '"& GetBD_SUBJECT &"', "
	Sql = Sql & " BD_CONTENT = '"& GetBD_CONTENT &"' ,"
	Sql = Sql & " BD_IP = '"& GetUser_IP &"', "
	Sql = Sql & " BD_INPUTDATE = getdate() "
	Sql = Sql & " where BD_SEQ = " & GetSeq
    Con.Execute(Sql)
  
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
    	strname		= mid(attach_name, 1, instrrev(attach_name,".")-1)  '���ϸ��� �̸��� Ȯ���ڸ� �и�
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



        '���� ���� ����
    	if Len(GetDelFile_name) > 0 then
        	Dim delfile : delfile = storedir & GetDelFile_name
            fc.DeleteFile(delfile)

			    	'���� ���� �Է�
			Sql = "Update "  & GetTable &"_pds set FILE_NAME = '"& attach_name &"', "
			Sql = Sql & " FILE_SIZE = '"& attach_size &"' "
			Sql = Sql & " where FILE_SEQ = " & GetDelFileSeq
		
		else 

			'���� ���� �Է�
			Sql = "insert into "  & GetTable &"_pds(FILE_BD_SEQ, FILE_BD_TABLE, FILE_NAME, FILE_SIZE) values "
			Sql = Sql & "('"& GetSeq &"', '"& GetTable &"', '"& attach_name &"', '"& attach_size &"')"
			end if

		Con.Execute(Sql)


    end if
    set fc=nothing
'======================== ȭ�� ���ε� �� ========================

'������ �̵�
Response.Redirect "list.asp?table=" & GetTable & "&page=" & GetPage & "&SearchPart=" & GetSearchPart & "&SearchStr=" & GetSearchStr
%>
