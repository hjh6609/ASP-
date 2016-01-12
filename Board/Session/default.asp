<%@ Language=VBScript %> 
<frameset rows="0,177,*" frameborder="no" border="0" framespacing="0"> 
<frame name="session" scrolling="no" noresize src="session.asp?name=<%=Session("name")%>
	&userid=<%=Session("userid")%>" marginwidth="0" frameborder="no"> 
<frame name="menu" scrolling="no" noresize src="menu.asp"  frameborder="no"> 
<frame name="main" noresize scrolling="auto" src="main.asp"  frameborder="no"> 
</frameset> 
<html> 
<head> 
<title>Neovis's ASP</title> 
</head> 
<noframes> 

<body bgcolor="#FFFFFF"> 
</body> 
</noframes> 
</html> 