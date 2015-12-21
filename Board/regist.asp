<html>
<head>글쓰기 폼</head>
<body>
	<form name="registForm" method= "post" action="regist_ok.asp">
   <table border cellspacing="0" width="500">
      <tr>
         <td colspan="2" align="center"><b>글을 적어주세요</b></td>
      </tr>
      <tr>
         <td align="center">이름</td>
         <td><input type="text" name="userName" size="15"></td>
      </tr>
      <tr>
         <td align="center">비밀번호</td>
         <td><input type="password" name="userPwd" size="15"></td>
      </tr>
      <tr>
         <td align="center">Email</td>
         <td><input type="text" name="userEmail" size="50"></td>
      </tr>
      <tr>
         <td align="center">제목</td>
         <td><input type="text" name="subject" size="50"></td>
      </tr>
      <tr>
         <td align="center">내용</td>
         <td><textarea name="content" cols="50" rows="10"></textarea></td>
      </tr>
      <tr>
         <td colspan="2" align="center">
            <input type="submit" value="작성 완료">&nbsp;&nbsp;&nbsp;
            <input type="reset" value="다시 작성">
         </td>
      </tr>
   </table>
   </form>
</body>
</html>