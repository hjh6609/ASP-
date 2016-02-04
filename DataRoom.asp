<!--#include File="DBHelper.asp"-->
<%
'//에러코드 시작 상단에 두고 
On Error Resume Next

KindNum = Request.QueryString("kindnum")
FileName = Request.QueryString("filename")

'response.write KindNum & "bbbbbbbb </br>"
'response.write FileName & "fff </br>"
'response.End 

If KindNum =2 Then
	 '파일 이름
	file = FileName
	'ContentType 를 선언합니다.
    Response.ContentType = "application/unknown"
	'헤더값이 첨부파일을 선언합니다.
    Response.AddHeader "Content-Disposition","attachment; filename=" & file 
    'Stream 을 이용합니다.
	Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Open
    objStream.Type = 1
    '절대경로
	objStream.LoadFromFile Server.MapPath("./data/")&"\"& file
    download = objStream.Read
	'이게 보통 Response.Redirect 로 파일로 연결시켜주는 부분을 대신하여 사용된 것입니다.
    Response.BinaryWrite download 
    '초기화
	Set objstream = nothing 
End If 


'If Err.Number <> 0 Then
'		response.write  "에러가 있음 </br>"
'		response.write  "에러번호: " & Err.Number  &"</br>"
'		response.write  "원인: " & Err.Description  &"</br>"
'		response.write  "에러발생 객체 " & Err.Source  &"</br>"
'		Err.Clear
'Else
'		response.write "No Error"
'End If 

%>