<%
   Option Explicit '�� ���������� ���Ǵ� ��� �������� �ݵ�� ����Ǿ��� ���Ŀ� ��� �� �� �ִ�'
   
   'Session 
   If session("id") = "" Then
		response.redirect "login.asp"
   End if

   Dim objDBConn
   Dim objRs
   Dim strSQL
   
   'paging'
   Dim intNowPage, intTotalCount, intTotalPage, intBlockPage, intPageSize
   Dim intTemp, intLoop , num

   'Searching'
   Dim strSearchWord, strSearchString, strSearchSQL
   Dim blnSearch

   intNowPage = Request.QueryString("page")
   strSearchWord = Request.QueryString("search_word")'Searching'
   strSearchString = Request.QueryString("search_string")'Searching'
   blnSearch = false'Searching'
   intPageSize = 10
   intBlockPage = 10

   If Len(intNowPage) = 0 Then
       intNowPage = 1
   End If
   
   'Searching'
   If Len(strSearchString) <> 0 Then
        blnSearch = true
        strSearchSQL = " Where " & strSearchWord
        strSearchSQL = strSearchSQL & " like '%" & strSearchString & "%'"
   End If

   strSQL = "SELECT Count(*)"
   strSQL = strSQL & ",CEILING(CAST(Count(*) AS FLOAT)/" & intPageSize & ")"
   strSQL = strSQL & " FROM board"
   If blnSearch Then
       strSQL = strSQL & strSearchSQL
   End If

   Set objDBConn = Server.CreateObject("ADODB.Connection")
   Set objRs = Server.CreateObject("ADODB.RecordSet")
   objDBConn.Open = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=testDB;User ID=computer;Password=qlalfqjsgh!@#4;"

   objRs.Open strSQL, objDBConn
   intTotalCount = objRs(0)
   intTotalPage = objRs(1)
   objRs.Close 


   strSQL = "SELECT Top " & intNowPage * intPageSize & " inx"   ' objRs(0) - ��ȣ
   strSQL = strSQL & ",strID"                 ' objRs(1) - �̸�
   strSQL = strSQL & ",strEmail"                ' objRs(2) - �����ּ�
   strSQL = strSQL & ",strSubject"              ' objRs(3) - ����
   strSQL = strSQL & ",WriteDate"               ' objRs(4) - ��¥
   strSQL = strSQL & ",WriteEnt"                ' objRs(5) - ��ȸ��
   strSQL = strSQL & " FROM board"
   'Searching'
   If blnSearch Then
        strSQL = strSQL & strSearchSQL
   End If 
   strSQL = strSQL & " ORDER BY inx DESC"
 
   objRs.Open strSQL, objDBConn  
%>
 <!DOCTYPE html>
 <head>
	<title>��Ϻ���</title>
    <!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
	
	<script type="text/javascript">

	$(document).ready(function(){
		
		history.forward(1)
		
	})

	</script>
	
	<!-- ��ũ�� �����鼭 �ε� -->
	<!--
	<script type="text/javascript">
		$( document ).ready( function() {
			$( 'img' ).removeAttr( 'style' );
		} );
		
		function lastPostFunc()  
		{  
			$("div#lastPostsLoader").html("�ε���...");  
			$.get("/Ding_data.html?action=getLastPosts&lastID=" + $(".wrdLatest:last").attr("id"),     
		   
			function(data){  
				if (data != "") {  
				$(".wrdLatest:last").after(data);             
				}  
				$("div#lastPostsLoader").empty();  
			});  
		};  

		$(window).scroll(function(){  
				if  ($(window).scrollTop() == $(document).height() - $(window).height()){  
				   lastPostFunc();  
				}  
		});  
	</script>
	
	<style>
		img {
		  width: inherit;
		  max-width: 100%;
		  height: auto;
		}
	</style>
	-->	
	<!-- ��ũ�� �����鼭 �ε� -->
	 <script type="text/javascript">
		 $(document).ready(function(){
			//alert(1);

			$("#cheVal").click(function(){
				 //alert(1111);return;
				 
				 if( confirm("�����Ͻðڽ��ϱ�?"))
				 {
					var checkCnt = document.formSeldel.Remove.length;
					var Arrnum = new Array();
					m = 0;
					 
					for(var i=0; i< checkCnt; i++)
					{
						if(document.formSeldel.Remove[i].checked == true)
						{
							Arrnum[m] = document.formSeldel.Remove[i].value;
							//alert(Arrnum[m]);
							m+1;
							//document.formSeldel.action="list_ad_del.asp?bundel=" + Arrnum[m];
							//document.formSeldel.submit();
						}
					 }
					 //alert(Arrnum[m]);return;
					 //document.formSeldel.action="list_ad_del.asp?bundel=" + Arrnum;
					 //document.formSeldel.action="list_ad_del.asp"
					 //location.href="/list_ad_del.asp"
					 document.formSeldel.submit();
					 //document.location.href="/list_ad_del.asp";
					 //alert(1);
				 }
			 });
		 })
	 
	 </script>
 </head>
 <body>
 <div class="container">
  <div class="header">
	 <nav>
          <ul class="nav nav-pills pull-right">
            <li role="presentation" class="active"><a href="/list.asp">Board</a></li>
			<li role="presentation"><a href="/logout.asp">LogOut</a></li>
          </ul>
     </nav>
        <h3 class="text-muted">First ASP Board</h3>
    </div>
	 <div align="center">
	 <h2>��Ϻ���</h2>
	 <table class="table table-condensed">
		 <form name= "searchForm" method="get">  <!-- Searching -->
		   <tr>
			 <!-- paging -->
			 <% If intTotalCount > 0 Then %>
			 <td>��ü�Խ� <%=intTotalCount%> �� &nbsp;&nbsp;&nbsp;&nbsp;
					���������� : <%=intNowPage%> / <%=intTotalPage%>
			 </td>
			<%  End If  %>
			 <!-- Searching -->
			 <td align="right">
				  <select name="search_word">
					  <option value="strID">�ۼ���</option>
					  <option value="strSubject">����</option>
					  <option value="strContent">����</option>
				  </select>
				  <input type="text" name="search_string" size="15">
				  <input type="submit" value="�˻�">
			 </td>
		   </tr>
		 </form>
	 </table>
	 <!-- paging -->
	 <table class="table table-striped">
		<form name="formSeldel" method="post" action="list_ad_del.asp">  
		  <tr align="center">
			 <td></td>
			 <td>��ȣ</td>
			 <td>����</td>
			 <td>�ۼ���</td>
			 <td>��¥</td>
			 <td>��ȸ��</td>
		  </tr>
	  <% If objRs.BOF or objRs.EOF Then %>
	  <tr align="center">
		<td colspan="5">��ϵ� �Խð� �����ϴ�</td>
	  </tr>
	 <%
		   Else
			  'paging'
			  objRs.Move (intNowPage - 1) * intPageSize
			  '��paging'
			  num = 1
			  Do Until objRs.EOF
	 %>
	  <tr align="center">
	   <td><input type="checkbox" id="test" name="Remove" value="<%=objRs(0)%>" /></td> <!-- üũ�ڽ� -->
	   <td><%=objRs(0)%></td>
		<td>
		   <a href="content.asp?seq=<%=objRs(0)%>"><%=objRs(3)%></a>
		</td>
		<td><%=objRs(1)%></td> 
		<td>
			<!-- ��¥ -->
			<%If IsNull(objRs(4)) Then 
				response.write "��¥����" 
			  Else 
				response.write(Replace(Mid(objRs(4),1,10),"-",".")) 
			  End If%></td> 
		<td>
			<!-- ��ȸ�� -->
			<%If IsNull(objRs(5)) Then 
				response.write "0" 
			  Else 
				response.write(objRs(5))
			  End If %>
		</td> 
	  </tr>
	 <%
					  'response.write "Remove"&num 'test��� vlaue�� ��
					  objRs.MoveNext
					  num = num + 1
				  Loop
		   End If

		   objRs.Close
		   Set objRs = nothing
		   objDBConn.Close
		   Set objDBConn = nothing
	 %>
	 </table>
	 <!-- paging -->
	 <table width="600">
	  <tr>
		<td align="center">
		<%
			' intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1

			' If intTemp = 1 Then
			'	 Response.Write "[���� " & intBlockPage & "��]"
			' Else
			'	 Response.Write"<a href=list.asp?page=" & intTemp - intBlockPage &  _
			'		"&search_word=" & strSearchWord & _
			'		"&search_string=" & strSearchString & _ 
			'		">[���� " & intBlockPage & "��]</a>"

			'End If

			 intLoop = 1

			 Do Until intLoop > intBlockPage Or intTemp > intTotalPage
				 If intTemp = CInt(intNowPage) Then
					 Response.Write "<font size= 3><b>" & intTemp &"</b></font>&nbsp;"
				 Else
					 Response.Write"<a href=list.asp?page=" & intTemp &  _
						"&search_word=" & strSearchWord & _
						"&search_string=" & strSearchString & _ 
						">" & intTemp & "</a>&nbsp;"
				 End If
				 intTemp = intTemp + 1
				 intLoop = intLoop + 1
			 Loop

			'If intTemp > intTotalPage Then
			' Response.Write "[���� " &intBlockPage&"��]"
			'Else
			'	  Response.Write"<a href=list.asp?page=" & intTemp &  _
			'		"&search_word=" & strSearchWord & _
			'		"&search_string=" & strSearchString & _ 
			'		">[���� " & intBlockPage & "��]</a>"
			'End If
		%>	
		</td>
	  </tr>
	 </form>
	</table>
	 <!-- paging -->
	 <% If blnSearch Then %>
	 <a href="list.asp">�������&nbsp;
	 <% End If %> 
	 <a href="regist.asp"><input type="button" value="�۾���"></a>
	 <input type="submit" id="cheVal" value="����">
	 </div>
		<!--
		<div class="wrdLatest">
			<table class="table table-condensed">
				<tr>
					<td>
					 <img src="http://cfile9.uf.tistory.com/image/245BE64D53BED145179B8F" style="width: 300px; height: 200px;">
					</td>
				</tr>
			</table>
		</div>
		-->
		<!--
		<div class="wrdLatest" id=9>content</div>  
		<div class="wrdLatest" id=8>content</div>
		-->
		<!-- <div id="lastPostsLoader"></div> -->
	</div>
 </body>
</html> 