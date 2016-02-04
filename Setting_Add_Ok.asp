<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include File="DBHelper.asp"-->
<%
      Response.CharSet="utf-8"
	  Session.codepage="65001"
	  Response.codepage="65001"
	  Response.ContentType="text/html;charset=utf-8"
	  
	  If Request.Form("Gubun") = "Object" Then
		  
		  Dim SeqNo , Content , SecretNo , Moon
		  
		  If Request.Form("division") = "A" Then 
				'게시판 이름 수정
				Moon = Request.Form("division") 
				SeqNo= Request.Form("seq") 
				Content= Request.Form("content") 
				SecretNo= Request.Form("secretno") 

				'response.write Moon
				'response.write SeqNo
				'response.write Content
				'response.write SecretNo
				'response.End 

			   Set DBHelper = new clsDBHelper 	
	  
			   Dim paramInfo2(3)
			   paramInfo2(0) = DBHelper.MakeParam("@Division",adVarWChar,adParamInput,1, Moon)
			   paramInfo2(1) = DBHelper.MakeParam("@SeqNo",adInteger,adParamInput,4, SeqNo)
			   paramInfo2(2) = DBHelper.MakeParam("@Content",adVarWChar,adParamInput,100, Content)
			   paramInfo2(3) = DBHelper.MakeParam("@SecretNo",adInteger,adParamInput,4, SecretNo)


			   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Category_Edit", paramInfo2, Nothing)
			   
			   'response.write rs(0)
			   'response.End 

			   Select Case (rs(0))
				  case 10	
					 response.write "10"    ' 게시판 제목 수정성공
					 rs.close
					 Set rs = Nothing 
				  case Else :
				    response.write "20"      '알수 없는 오류
			   End Select

		  Else
				'게시판 이름 삭제
				SeqNo = Request.Form("seq") 

				Set DBHelper = new clsDBHelper 	
				
			   Dim paramInfo3(3)
			   paramInfo3(0) = DBHelper.MakeParam("@Division",adVarWChar,adParamInput,1, "")
			   paramInfo3(1) = DBHelper.MakeParam("@SeqNo",adInteger,adParamInput,4, SeqNo)
			   paramInfo3(2) = DBHelper.MakeParam("@Content",adVarWChar,adParamInput,100, "")
			   paramInfo3(3) = DBHelper.MakeParam("@SecretNo",adInteger,adParamInput,4, "")

			   Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Category_Edit", paramInfo3, Nothing)

			   response.write rs(0)
			   response.End 

			   Select Case (rs(0))
				  case 30	
					 response.write "30"    ' 게시판 제목 삭제 성공
					 rs.close
					 Set rs = Nothing 
				  case Else :
				    response.write "40"      '알수 없는 오류
			   End Select

		  End If 
		  response.End 
	  Else 
		  Dim BoardNm , SelectVal , KindNo

		  BoardNm  = Request.Form("txtBoardNm1")
		  SelectVal  = Request.Form("PublicYN1_B")
		  KindNo = Request.Form("Kind_Board1")
		  
		  'response.write BoardNm &"</br>"
		  'response.write SelectVal &"</br>"
		  'response.End 

		  Set DBHelper = new clsDBHelper 	
	  
		  Dim paramInfo(2)
		  paramInfo(0) = DBHelper.MakeParam("@Content",adVarWChar,adParamInput,50, BoardNm)
		  paramInfo(1) = DBHelper.MakeParam("@SelectVal",adInteger,adParamInput,4, SelectVal)
		  paramInfo(2) = DBHelper.MakeParam("@KindNo",adInteger,adParamInput,4, KindNo)


		  Set rs = DBHelper.ExecSPReturnRS("dbo.Board_Category_Insert", paramInfo, Nothing)

		  Select Case (rs(0))
			 case 10	
				'response.write "10"    '& Content '수정성공
				response.write "<script>alert('게시판이 저장되었습니다.'); location.href='/setting_add_board.asp'</script>"   
				rs.close
				Set rs = Nothing 
			 case Else :
			   response.write "20"      '알수 없는 오류
		  End Select

	  End If 

	  DBHelper.Dispose
	  Set DBHelper = Nothing
%>