<% 

Response.Expires = -1 
Response.ExpiresAbsolute = Now() - 1 
Response.AddHeader "pragma", "no-cache" 
Response.AddHeader "Cache-Control", "no-cache" 
Response.CacheControl = "no-cache" 
Response.Buffer = true

response.Cookies("savedLogin").Domain = ".com" 
response.Cookies("savedLogin").Path = "/"
response.Cookies("savedLogin")("txtID") = ""
response.Cookies("savedLogin")("txtPwd") = ""
response.cookies("savedLogin").Expires = Now

response.redirect "../list.asp" 
%>