<%

Set DBConn = Server.CreateObject("ADODB.Connection") 
strCon="Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

DBConn.ConnectionString = strCon
DBConn.Open
	If IsObject(dbconn) then
		Response.Write strCon & "SQL Server�� ���� ����<br>"
	Else
		Response.Write strCon & "SQL Server�� ���� ����<br>"
	End if
%>


