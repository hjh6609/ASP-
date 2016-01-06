<%

Set DBConn = Server.CreateObject("ADODB.Connection") 
strCon="Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

DBConn.ConnectionString = strCon
DBConn.Open
	If IsObject(dbconn) then
		Response.Write strCon & "SQL Server에 연결 ㅇㅋ<br>"
	Else
		Response.Write strCon & "SQL Server에 연결 ㄴㄴ<br>"
	End if
%>


