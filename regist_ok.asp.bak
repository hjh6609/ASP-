<%@Language="VBScript" codepage="65001" %>
<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"--> 
<!--#include File="DBHelper.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<% 
   '//에러코드 시작 상단에 두고 
   On Error Resume Next
	Set theForm = Server.CreateObject("ABCUpload4.XForm")
	theForm.CodePage = 65001     
   
   Dim  strPassword, strSubject, strContent ,txtInx ,num1,num2, temp ,Parent,txtGubun,txtGubun2
   strPassword  = theForm.Item("userPwd")
   strSubject     = theForm.Item("subject")
   strContent    = theForm.Item("content")
   txtInx    = theForm.Item("txtInx")	 '고유 seq번호 , 부모글번호
   txtCateNm    = theForm("txtCateNm")
   txtGubun    = theForm.Item("txtGubun")
   Parent    = theForm.Item("txtPos")	'답글에서 넘어오는 부모글 번호
   Group = theForm.Item("txtGroup")	'답글에서 넘어오는 group_num 
   Cnt = theForm.Item("txtCnt")	' 답글의 답글 group_count ++용
   CateNum = theForm.Item("txtCateNum") '카테고리 고유번호
   KindNum = theForm.Item("txtKindNum") '카테고리 번호 0: 공지사항 1:자유게시판 2: 자료실
   strFileName =theForm.Item("attachFile")
	
   '자료실이 아닐땐 null
    If Not(KindNum = 2) Then 
			If theForm.Item("txtGubun") = "WR" Then
				'일반글쓰기
				txtGubun= "WR"
				strFileName = "NULL"
				FileSize= 0
				txtGubun2= ""
				If txtInx = "" Then 
					txtInx =1
					num2 = 0
					Group=1
				Else
					txtInx = txtInx + 1
					Group = 1
					num2 = 0
				End If 
			ElseIf theForm.Item("txtGubun") ="RE" Then  
				'답글쓰기
				txtGubun= "RE"
				txtInx = Parent 
				Group = Group
				num2 = Cnt
			End If			
	   Else
			'자료실 일 때	: 자료실은 답글 금지
			If theForm.Item("txtGubun") = "WR" Then
				'일반글쓰기
				txtGubun= "WR"
				txtGubun2= "DA"
				If txtInx = "" Then 
					txtInx =1
					num2 = 0
					Group=1
				Else
					txtInx = txtInx + 1
					Group = 1
					num2 = 0
				End If 
			End If	
			
			theForm.AbsolutePath = True
			Set theField = theForm("attachFile")(1)
			theForm.Overwrite = True

			If theField.FileExists Then 
				theField.Save "E:\Board\Uploaded_Files\" & theField.safeFileName
				'Response.Write "빠일이 업로드 ㅇㅋ"
				strFileName = theField.SafeFileName
				FileSize = theField.Length

				If theField.Length > 4096000 Then
				   Response.Write "<script language=javascript>"
				   Response.Write "alert(""4MB 이상 파일을 업로드 할 수 없습니다!"");"
				   Response.Write "history.back();"
				   Response.Write "</script>"
				   Response.End
			   Else
				   strFileWholePath = GetUniqueName(strFileName,DirectoryPath)
				   theField.Save strFileWholePath
			   End If
			Else
				Response.Write "파일 업로드 실패"
			End If
	   End If 

   Set DBHelper = new clsDBHelper 
   
   Dim paramInfo(12)
   paramInfo(0) = DBHelper.MakeParam("@UserID",adVarWChar,adParamInput,20, session("id"))
   paramInfo(1) = DBHelper.MakeParam("@Pwd",adVarWChar,adParamInput,20, strPassword)
   paramInfo(2) = DBHelper.MakeParam("@strSubject",adVarWChar,adParamInput,50, strSubject)
   paramInfo(3) = DBHelper.MakeParam("@strContent",adVarWChar,adParamInput,300, strContent)
   paramInfo(4) = DBHelper.MakeParam("@CateNm",adVarWChar,adParamInput,50, txtCateNm)
   paramInfo(5) = DBHelper.MakeParam("@num1",adInteger,adParamInput,4, txtInx)
   paramInfo(6) = DBHelper.MakeParam("@num2",adInteger,adParamInput,4, Group)
   paramInfo(7) = DBHelper.MakeParam("@num3",adInteger,adParamInput,4, num2)
   paramInfo(8) = DBHelper.MakeParam("@Gubun",adVarWChar,adParamInput,2, txtGubun)
   paramInfo(9) = DBHelper.MakeParam("@temp",adInteger,adParamInput,4, txtInx)
   paramInfo(10) = DBHelper.MakeParam("@strFileName",adVarWChar,adParamInput,50, strFileName)
   paramInfo(11) = DBHelper.MakeParam("@Path",adInteger,adParamInput,4, FileSize)
   paramInfo(12) = DBHelper.MakeParam("@Gubun2",adVarWChar,adParamInput,2, txtGubun2)
   
   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Regist", paramInfo, Nothing)

   Select Case (rs(0))
     case 50
	   response.write "<script>alert('등록 되었습니다.');location.href='./MultiBoard.asp?categoryNm="+ txtCateNm+"&kindnum="+ KindNum +"';</script>"
	   rs.Close
	   Set rs = Nothing
	 case 10
	   response.write "<script>alert('등록 되었습니다.');location.href='./MultiBoard.asp?categoryNm="+ txtCateNm+"&kindnum="+ KindNum +"';</script>"
	   rs.Close
	   Set rs = Nothing
	 case 20
	   response.write "<script>alert('일반 글쓰기 에러');history.go(-1);</script>"
	   rs.Close
	   Set rs = Nothing
	 case 30
	   response.write "<script>alert('등록 되었습니다.');location.href='./MultiBoard.asp?categoryNm="+ txtCateNm+"&kindnum="+ KindNum +"';</script>"
	   rs.Close
	   Set rs = Nothing
     case Else :
       response.write "<script>alert('알수 없는 오류입니다.');history.go(-1);</script>"
   End Select

	DBHelper.Dispose
   Set DBHelper = Nothing

	'유니크한 파일경로및 파일이름을 얻어내는 함수
	Function GetUniqueName(byRef strFileName, DirectoryPath)
		Dim strName, strExt
		' 확장자를 제외한 파일명을 얻는다.
		strName = Mid(strFileName, 1, InstrRev(strFileName, ".") - 1)	
		 '확장자를 얻는다
		strExt = Mid(strFileName, InstrRev(strFileName, ".") + 1)

		Dim fso
		Set fso = Server.CreateObject("Scripting.FileSystemObject")

		Dim bExist : bExist = True	
		'우선 같은이름의 파일이 존재한다고 가정
		Dim strFileWholePath : strFileWholePath = DirectoryPath & "\" & strName & "." & strExt	
		'저장할 파일의 완전한 이름(완전한 물리적인 경로) 구성
		Dim countFileName : countFileName = 0	
		'파일이 존재할 경우, 이름 뒤에 붙일 숫자를 세팅함.

		Do While bExist ' 우선 있다고 생각함.
			If (fso.FileExists(strFileWholePath)) Then	' 같은 이름의 파일이 있을 때
				countFileName = countFileName + 1	'파일명에 숫자를 붙인 새로운 파일 이름 생성
				strFileName = strName & "(" & countFileName & ")." & strExt
				strFileWholePath = DirectoryPath & "\" & strFileName
			Else
				bExist = False
			End If
		Loop
		GetUniqueName = strFileWholePath
	End Function


   If Err.Number <> 0 Then
		response.write  "에러가 있음 </br>"
		response.write  "에러번호: " & Err.Number  &"</br>"
		response.write  "원인: " & Err.Description  &"</br>"
		response.write  "에러발생 객체 " & Err.Source  &"</br>"
		Err.Clear
	Else
		response.write "No Error"
	End If 
%>