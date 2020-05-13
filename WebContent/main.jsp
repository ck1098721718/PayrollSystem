<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>welcome</title>
    <link rel="stylesheet" href="myCSS/myhead.css" />
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
</head>

<body>
			
			<div id="myCarousel2" class="carousel slide">
				<!-- 轮播（Carousel）指标 -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel2" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel2" data-slide-to="1"></li>
					<li data-target="#myCarousel2" data-slide-to="2"></li>
					<li data-target="#myCarousel2" data-slide-to="3"></li>
					
				</ol>   
				<!-- 轮播（Carousel）项目 -->
				<div class="carousel-inner">
					<div class="item active">						
						<img src="img/c1.jpg" alt="First slide">
						<p>员工管理</p>
					</div>
					<div class="item">
						<img src="img/c2.jpg" alt="Second slide">
						<p>考勤管理</p>
					</div>
					<div class="item">
						<img src="img/c3.jpg" alt="Third slide">
						<p>工资管理</p>
					</div>
					<div class="item">
						<img src="img/c4.jpg" alt="Third slide">
						<p>报表查询</p>
					</div>
					
				</div>
				<!-- 轮播（Carousel）导航 -->
				<a class="left carousel-control" href="#myCarousel2" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#myCarousel2" role="button" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div> 
	
		<div style="top:0px;	left: 0px;	height: 100px;	width: 100%;position: absolute;">
			<div class="system_title">
				工资管理系统
			</div>
			<div class="system_exit" onclick="window.location.href='Logout'">
          		<span class="glyphicon glyphicon-off" style="top: 3px;"></span>&nbsp;退出
			</div>	
			<div style="top:100px;	left: 0px;	height: 3px;	width: 100%;position: absolute;background-color: white;">
			</div>
			<div style="top:106px;	left: 0px;	height: 4px;	width: 100%;position: absolute;background-color: #D4D4D4; box-shadow:2px 8px 10px #255625;">
			</div>
			
			<div >
			<div class="system_navi">
  				<div class="btn-group btn-group-justified" id="myButtonGroup" style="bottom: 3px;">
    				<button type="button" class="btn " style="background: linear-gradient(#255625, #5CB85C);color: white;">首页</button>
    				<button type="button" class="btn" onclick="window.location.href='employeeManage.jsp'">员工管理</button>
    				<button type="button" class="btn" onclick="window.location.href='attendanceManage.jsp'">考勤管理</button>
    				<div class="btn-group">
      					<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
      					工资管理 <span class="caret"></span></button>
      					<ul class="dropdown-menu" role="menu">
        				<li><a href="salaryProject.jsp">工资项目</a></li>
        				<li><a href="fixedSalary.jsp">固定工资</a></li>
        				<li><a href="salaryCalculation.jsp">工资结算</a></li>
      				</ul>
    				</div>
    				<button type="button" class="btn " onclick="window.location.href='report.jsp'">报表查询</button>
  				</div>
			</div>
		</div>
		</div>
		
		<div style="width: 100%;padding:1% 5% 2% 5%">
			<div style="width:100%;text-align: center;">
				<h1>工资管理系统，让管理工资更简易</h1>
				<br />
				<h4>员工管理 | 考勤管理 | 工资管理 | 报表查询</h4>
			</div>
			<div>
		
			</div>
		</div>	
	
		<div style="width: 100%;height: 50px; border-top:double 10px #FFFFFF;background-color:#255625 ;">
		
		
		</div>	
		
		
		

	</body>
	<script>
		$('#myCarousel2').carousel({
    		interval: 2000
		})
	</script>

</html>