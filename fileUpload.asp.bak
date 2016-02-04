<% @Language="VBScript" %> 
<!doctype html> 
<body> 
<% 
     Dim theForm,theField   
     Set theForm = Server.CreateObject("ABCUpload4.XForm") 
     theForm.AbsolutePath = True 
     Set theField = theForm("file")(1) 
     If theField.FileExists Then 
     theField.Save "C:\temp\" & theField.SafeFileName 
       Response.Write "File uploaded..." 
     Else 
       Response.Write "No file uploaded..." 
     End If 
%> 
</body> 
</html>