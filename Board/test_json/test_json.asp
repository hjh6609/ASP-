<!DOCTYPE>
<html>
<head>
<title>Test Json</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){

		$("input[id=btnCall]").click(function(){

				$.ajax({

					type:"post",
					url:"/test/test_json_data.asp",
					data:"",
					dateType:"json",
					error:function(){
						$("div[id=username]").html("<span style='color:red;'>불러오기 오류!</span>");
					},
					success:function(JsonData){
						JsonData =  $.trim(JsonData);
						if (JsonData != ""){
							var evalData = eval('(' + JsonData + ')');
							with(evalData.result){
								$("div[id=username]").html("<span>"+name+"</span>님 안녕하세요.");
							}
						}
					}

				});

		});


	});



</script>
</head>
<body>
<input type="button" id="btnCall" value="불러오기" onclick="FindName();" />
<div id="username">여기에 뿌려준다.</div>
</body>
</html>