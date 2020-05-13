<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mybean.Login"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login</title>
	<link rel="stylesheet" href="myCSS/myhead.css" />
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="myCSS/login.css" />
		
</head>
<body>

	<div id="myCarousel" class="carousel slide">
				<!-- 轮播（Carousel）指标 -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
					
				</ol>   
				<!-- 轮播（Carousel）项目 -->
				<div class="carousel-inner">
					<div class="item active">
						<img src="img/a1.jpeg" alt="First slide">
					</div>
					<div class="item">
						<img src="img/a2.png
							" alt="Second slide">
					</div>
					<div class="item">
						<img src="img/a3.jpg" alt="Third slide">
					</div>
					
				</div>
				<!-- 轮播（Carousel）导航 -->
				<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div> 
	
		<div style="top:0px;	left: 0px;	height: 100px;	width: 100%;position: absolute;">
			<div class="system_title">
				工资管理系统
			</div>
			<div style="top:100px;	left: 0px;	height: 3px;	width: 100%;position: absolute;background-color: white;">
			</div>
			<div style="top:106px;	left: 0px;	height: 4px;	width: 100%;position: absolute;background-color: #D4D4D4; box-shadow:2px 8px 10px #255625;">
			</div>
		</div>
		
			
		<div class="wrap" id="wrap">
			<div class="logGet">		
					<div class="logD logDtip">
						<p class="p1">登录/注册</p>
					</div>

					<form action="" method="post">
				<div class="lgD">
					<img src="img/logName.png" width="20" height="20" alt=""/>
					<input type="text" name="username" placeholder="输入用户名" />
				</div>
	
				<div class="lgD">
					<img src="img/logPwd.png" width="20" height="20" alt=""/>
					<input type="password" name="password" placeholder="输入用户密码" />
				</div>
	
				
				<div class="logC">
					<input type="button" value="登录" onclick="login()">
				</div>
				<br>
				<div class="logC">
					<input type="button" onclick="javascript:window.location.href='register.jsp';" value="注册" />
				</div>
			</form>

		</div>

	</div>
</body>

<script type="text/javascript">
	function login(){
		//window.alert("666");
		$.ajax({
			type:"GET",
			url:"HandleLogin",
			//xhrFields: {withCredentials: true},
			data:$('form').serializeArray(),
			dataType: "text",
	        success: function(data){
	        	
	        	if(data=="登录成功")	window.location.href="main.jsp";
	        	else window.alert(data);
	        },
	        error: function(){
	            
	        }
		});
	}    	
</script>

<script>
		$('#myCarousel').carousel({
    		interval: 2000
		})
	</script>
</html>