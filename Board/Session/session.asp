<%@ Language=VBScript %> 
<% 
	name = Request("name") 
	userid = Request("userid") 
	if userid = Request.Cookies("userid") then 
		Session("name") = Request.Cookies("name") 
		Session("userid") = Request("userid") 
	else 
		Session.Abandon 
	end if 
%> 
<meta http-equiv="refresh" content="1140; url=session.asp?userid=
		<%=Session("userid")%>&name=<%=Session("name")%>"> 