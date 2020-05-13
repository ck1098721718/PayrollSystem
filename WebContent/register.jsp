<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>sign</title>
	<link rel="stylesheet" href="myCSS/signin.css" />
	<link rel="stylesheet" href="myCSS/myhead.css" />
	<script type="text/javascript" src="js/jquery-3.4.1.min.js" ></script>
</head>
<body>

	<div class="container">
		<div class="system_head" id="head">
  			<div class="system_title">企业工资管理系统/注册用户</div>
		</div>
		
		<div class="register-box">
			
			<form action="" method="get">
				<div class="username-box">
					<span class="require">*</span>
					<label for="username">用户名</label>
					<div class="username-input">
						<input type="text" id="username" name="username" placeholder="请输入用户名 长度:6-12个字符" />
					</div>

				</div>


				<div class="userPassword-box">
					<span class="require">*</span>
					<label for="userPassword">密码</label>
					<div class="userPassword-input">
						<input type="password" id="userPassword" name="password" placeholder="请输入密码 长度:6-12个字符" />
					</div>
				</div>

 
				<div class="userRePassword-box">
				<span class="require">*</span>
						<label for="userRePassword">确认密码</label>
					<div class="userRePassword-input">
						<input type="password" id="userRePassword" name="confirmPassword" placeholder="请重复输入密码" />
					</div>
				</div>

 
				<div class="userPhone-box">
					<span class="require">*</span>
					<label for="userPhone">手机号码</label>
					<div class="userPhone-input">
						<input type="text" id="userPhone" name="phone" placeholder="请输入您的手机号码，11位有效数字" />
					</div>
				</div>

				
				<div class="userGender-box">
					<span class="require">*</span>
					<label for="userGender">性别</label>
					<div class="userGender-input">
						<input type="radio" id="userGender_01" name="sex" value="男" checked="checked" />男   
						<input type="radio" id="userGender_02" name="sex" value="女" />女
					</div>
				</div>

				<div class="userRealName-box">	
					<span class="require">*</span>
					<label for="userRealName">真实姓名</label>
					<div class="userRealName-input">
						<input type="text" id="userRealName" name="realname" placeholder="请输入您的真实姓名" />
					</div>
				</div>


				<div class="submit-box">
					<!--input id = "submit-button" type="submit" value="注册" onclick="ensurePWD()"-->
					<input id = "submit-button"  type="button" value="注册" onclick="ensurePWD()" >
				</div>

				
				<div class="goLogin-box">
					<a href="login.jsp" style="text-decoration: none;">已有账号？去登录</a>
				</div>
				
			</form>
		</div>
	</div>

</body>

<script type="text/javascript">
	function ensurePWD(){
		//window.alert("666");
		$.ajax({
			type:"GET",
			url:"HandleRegister",
			data:$('form').serializeArray(),
			dataType: "text",
	        success: function(data){
	        	if(data=="注册成功")	window.location.href="login.jsp";
	        	window.alert(data);
	        },
	        error: function(){
	            
	        }
		});
	}    	
</script>

</html>