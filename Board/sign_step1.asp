<!Doctype html>
<head>
	<title>ȸ������</title>
	<!-- Bootstrap core CSS -->
    <link href="../BootStrap/bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../BootStrap/bootstrap-dist/js/jumbotron-narrow.css" rel="stylesheet">

    <script src="../BootStrap/bootstrap-dist/js/ie-emulation-modes-warning.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../bootstrap-dist/js/ie10-viewport-bug-workaround.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
	<script src="http://connect.facebook.net/en_US/all.js"></script>

	<style type="text/css">
		.align{
			text-align:center;
			/*display: table; margin-left: auto; margin-right: auto;*/
		}
	</style>
</head>
	<body>
	 <div class="container">
		  <div class="header">
			 <nav>
				  <ul class="nav nav-pills pull-right">
					<li role="presentation"><a href="javascript:alert('2')">Home</a></li>
					<li role="presentation"><a href="javascript:alert('2')">About</a></li>
					<li role="presentation"><a href="javascript:alert('3')">Contact</a></li>
					<li role="presentation" class="active"><a href="/sign_step1.asp">Sign Up</a></li>
				  </ul>
			 </nav>
				<h3 class="text-muted">First ASP BOARD</h3>
			</div>
			<!-- <p class="align">���̽��� �α��� �ϱ�</p> -->

			<div id="fb-root"></div>
			<a id="fb-auth" title="���̽��� ���̵�� �α���" href="javascript:;">�α��� ��ư</a>

			<p class="align"><a href="/sign_up.asp">ȸ������ �ϱ�</a></p>
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
				if(confirm('facebookID:'+response.email+' �� �α����Ͻðڽ��ϱ�?')==true){
							// Ȯ���� �������� ����� ó��.
				  }else{
							  // ��Ҹ� �������� ����� ó��(�Ʒ��� ���̽��� �α׾ƿ� ó��)
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
	 
	</script>

	<!-- facebook login -->
</html>

