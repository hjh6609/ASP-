<!Doctype html>
<head>
	<title>Login</title>
	<!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
	
	<style type="text/css">
		td{ padding: 3px;}
	</style>
</head>
<body>
 <div class="container">
	  <div class="header">
		 <nav>
			  <ul class="nav nav-pills pull-right">
				<li role="presentation"><a href="/list.asp" id="board">Board</a></li>
				<li role="presentation" class="active"><a href="/login.asp">Login</a></li>
				<li role="presentation"><a href="/sign_up.asp">Sign Up</a></li>
			  </ul>
		 </nav>
			<h3 class="text-muted">First ASP BOARD</h3>
		</div>
		<form name="FormLogin" method="post" action="login_ok.asp">
			<table table align="center" border="0">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="txtID"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="txtPwd"></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><input type="submit" value="Login"></td>
				</tr>
			</table>
		</form>
		<div align="center" style="padding-top: 40px;">
			<div id="fb-root"></div>
			<a id="fb-auth" title="페이스북 아이디로 로그인" href="javascript:;">페이스북 로그인하기</a>
		</div>
 </div>
</body>
	<!-- Facebook login -->
	<script language=javascript>
	
	window.fbAsyncInit = function(){
		FB.init({ appId: '1051730418213126', 
			status: true, 
			//channelUrl : "http://www.aspboard_test.com/list.asp",
			cookie: true,
			xfbml: true,
			oauth: true});
	}
	 
	function updateButton(response) {
		var button = document.getElementById('fb-auth');
			
			if (response.authResponse) {
			   
			  FB.api('/me', function(response) {
				if(confirm('facebookID:'+response.email+' 로 로그인하시겠습니까?')==true){
					// 확인을 선택했을 경우의 처리.
					var $form = $('<form></form>');
					$form.attr('action', 'facebook.asp');
					$form.attr('method', 'post');
					$form.attr('target', 'iFrm');  // 타겟은 임의로 지정함
					$form.appendTo('body');
                 
					
					var fuid = $('<input type="hidden" value="'+response.email+'" name="fuid">');
					var fname = $('<input type="hidden" value="'+response.name+'" name="fname">');
					var fsex = $('<input type="hidden" value="'+response.sex+'" name="fsex">');
					var ffirst_name = $('<input type="hidden" value="'+response.first_name+'" name="ffirst_name">');
					var flast_name = $('<input type="hidden" value="'+response.last_name+'" name="flast_name">');
					var flocale = $('<input type="hidden" value="'+response.locale+'" name="flocale">');
					var fbirthday = $('<input type="hidden" value="'+response.birthday+'" name="fbirthday">');
                 
					$form.append(fuid).append(fname).append(fsex).append(ffirst_name).append(flast_name).append(flocale).append(fbirthday);
					$form.submit();
				  }else{
							  // 취소를 선택했을 경우의 처리(아래는 페이스북 로그아웃 처리)
						      FB.logout(function(response) {
							 
					  });
				  }
			  });
			   
			   
			} else {
				 FB.login(function(response) {
					if (response.authResponse) {
						FB.api('/me', function(response) {
							
						});    
					} else {
						 
					}
				}, {scope:'email'});    
			}
	  }
	 
	document.getElementById('fb-auth').onclick = function() {
		 
		FB.Event.subscribe('auth.statusChange', updateButton);  
		FB.getLoginStatus(updateButton);
	};
		 
	(function() {
	  var e = document.createElement('script'); e.async = true;
	  e.src = document.location.protocol 
		+ '//connect.facebook.net/ko_KR/all.js';
	  document.getElementById('fb-root').appendChild(e);
	}());

	document.getElementById('board').onclick = function(){
		alert("로그인한 사용자만 사용가능 합니다.");
	}
	
	

	</script>
	<!-- facebook login -->
</html>