<%@ Language=VBScript %>
<%  Option Explicit   %>
<% '디비 커넥션 %>
<!--#include file="./inc/inc_dbCon.asp"-->
<% '/디비 커넥션 %>
<%
    Dim up_form
    Set up_form = Server.CreateObject("SiteGalaxyUpload.Form")
    

    Dim GetId      : GetId		= Request.Cookies("USER")("C_id")
    Dim GetName    : GetName	= Request.Cookies("USER")("C_name")
    Dim GetEmail   : GetEmail   = Request.Cookies("USER")("C_mail")
    Dim GetPasswd  : GetPasswd  = Request.Cookies("USER")("C_pw")

    Dim GetTable    : GetTable  = up_form("table")

    Dim GetFile_space : GetFile_space  = 5000000   '업로드 5메가로 제한
    Dim GetPage       : GetPage        = up_form("page")
    Dim GetSearchPart : GetSearchPart  = up_form("SearchPart")
	Dim GetSearchStr  : GetSearchStr   = up_form("SearchStr")

    Dim GetBD_SUBJECT  : GetBD_SUBJECT  = replace(up_form("formBD_SUBJECT"),"'","''")
    Dim GetBD_CONTENT  : GetBD_CONTENT  = replace(up_form("MinBoardContents"),"'","''")

    Dim GetBD_ID       : GetBD_ID    = up_form("formBD_ID")
	GetBD_ID = 1 '보드종류를 초기화 시킨다.

	Dim GetBD_NAME     : GetBD_NAME  = up_form("formBD_NAME")
	Dim GetBD_EMAIL    : GetBD_EMAIL = up_form("formBD_EMAIL")
	Dim GetBD_PASSWD   : GetBD_PASSWD= up_form("formBD_PASSWD")
	Dim GetUser_IP     : GetUser_IP  = Request.ServerVariables("Remote_addr")

    'seq max값
	Sql = "SELECT (ISNULL(MAX(BD_THREAD),0) + 1000 ), (ISNULL(MAX(BD_SEQ),0) + 1 ) FROM  " & GetTable 
    Set Rs = Con.Execute(Sql)
        if not Rs(0) = "" then
           Dim GetBD_THREAD : GetBD_THREAD = Rs(0)
		   Dim GetBD_SEQ    : GetBD_SEQ    = Rs(1)
        end if
    Rs.close

    '입력
    Sql = "insert into " & GetTable & " (BD_THREAD, BD_DEPTH , BD_ID ,  BD_NAME, BD_EMAIL , BD_SUBJECT , "
	Sql = Sql & " BD_CONTENT,  BD_PASSWD, BD_INPUTDATE, BD_IP , BD_READCOUNT, BD_STATE) "
	Sql = Sql & " values ( "
    Sql = Sql &  GetBD_THREAD & ", '0' ,  "
	Sql = Sql & "'"& GetBD_ID &"','"& GetBD_NAME &"','"& GetBD_EMAIL &"','"& GetBD_SUBJECT &"','"& GetBD_CONTENT 
	Sql = Sql & "','"& GetBD_PASSWD  &"',getdate(), '" &GetUser_IP & "', 0, 1)"
    
	con.Execute(Sql)
    
'======================== 화일 업로드 ========================
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
    	
    	attach_file	= up_form("formFile").filepath   '파일이 저장될 경로를 지정
    	attach_size	= up_form("formFile").size
    	
    	if Clng(attach_size / (1024 * 1000)) > Clng(GetFile_space) then
            Response.Write("<script language=javascript>")
            Response.Write("    alert('파일용량이 너무 큽니다.\n\n 5Mbyte 이상업로드 할수없습니다.');")
            Response.Write("    history.back();")
			Response.Write("</script>")
    		Response.End 
    	end if
    	 

    	attach_name = mid(attach_file, instrrev(attach_file,"\")+1)     '경로명을 제외한 파일명을 축출
    	strname		= mid(attach_name, 1, instrrev(attach_name,".")-1)  '파일명에서 이름과 확장자를 분리
    	strext		= mid(attach_name,instrrev(attach_name,".")+1)
    	  	
    	full_attach_name = storedir & attach_name
    						
    	fexist = true
    	count=0		
    	do while fexist  '파일이 중복될 경우 이름을 다시 지정 -파일이름 뒤에 숫자를 붙여서 업
    		if(fc.fileexists(full_attach_name)) then
    			count			 = count + 1
    			attach_name		 = strname&"-"&count&"."&strext
    			full_attach_name = storedir & attach_name
    		else
    		fexist=false
    		end if
    	loop
    	
    	'콤포넌트에 의해 실지 파일을 업로드
    	up_form("formFile").saveas full_attach_name
    	
    	'파일 정보 입력
    	Sql = "insert into "  & GetTable &"_pds(FILE_BD_SEQ, FILE_BD_TABLE, FILE_NAME, FILE_SIZE) values "
    	Sql = Sql & "('"& GetBD_SEQ &"', '"& GetTable &"', '"& attach_name &"', '"& attach_size &"')"
		
		Con.Execute(Sql)
    end if
    set fc=nothing
'======================== 화일 업로드 끝 ========================

'페이지 이동
Response.Redirect "list.asp?table=" & GetTable & "&page=" & GetPage & "&SearchPart=" & GetSearchPart & "&SearchStr=" & GetSearchStr
%>