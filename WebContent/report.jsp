<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="myCSS/mystuff.css" />
	<link rel="stylesheet" href="myCSS/myhead.css" />
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-3.4.1.min.js" ></script>
</head>

<body data-spy="scroll" data-target="#myScrollspy">
		<div class="system_head">
			<div class="system_title">
				工资管理系统
			</div>
			<div class="system_exit" onclick="window.location.href='Logout'">
          		<span class="glyphicon glyphicon-off" style="top: 3px;"></span>&nbsp;退出
			</div>
			<!--
            	作者：offline
            	时间：2019-06-25
            	描述：导航栏
            -->
			<div class="system_navi">
  				<div class="btn-group btn-group-justified" id="myButtonGroup">
    				<button type="button" class="btn" onclick="window.location.href='main.jsp'">&nbsp;首页&nbsp;</button>
	    			<button type="button" class="btn" onclick="window.location.href='employeeManage.jsp'">员工管理</button>
	   				<button type="button" class="btn " onclick="window.location.href='attendanceManage.jsp'">考勤管理</button>
    				<div class="btn-group">
      					<button type="button" class="btn dropdown-toggle" data-toggle="dropdown" style="background-color: #A94442;">
      					工资管理 <span class="caret"></span></button>
      					<ul class="dropdown-menu" role="menu">
        					<li><a href="salaryProject.jsp">工资项目</a></li>
	        				<li><a href="fixedSalary.jsp">固定工资</a></li>
	        				<li><a href="salaryCalculation.jsp">工资结算</a></li>
      					</ul>
    				</div>
    				<button type="button" class="btn"  style="background: linear-gradient(#255625, #5CB85C);color: white;">报表</button>
  				</div>
			</div>
		</div>
		
		<div class="container" style="width:100%;padding-left: 0;padding-right: 5%;">
    		<div class="row">
        		<div class="col-xs-2" id="myScrollspy" >
            		<ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125" style="text-align: center;">
                		<li class="active"><a href="#section-1">工资查询报表</a></li>
               			<li><a href="#section-2">部门报表</a></li>
               			<li><a href="#section-3">公司报表</a></li>
               			<li><a href="#section-4">员工报表</a></li>
            		</ul>
        	</div>
        	
        	<div class="col-xs-10">
        	    <h2 id="section-1">工资查询报表</h2>
				<div class="s6" style="border:double #FFCCCC 8px;border-radius:12px;padding:0 2%;">
					
					<div class="myQuery">
					<div style="display: inline">
						<div style="display: inline">
						日期：
						<input id="start" placeholder="开始年月" />
						~
						<input id="end" placeholder="结束年月" />	
						</div>
					
						&nbsp;&nbsp;部门：
						<select id="department1">
							<option>人力资源部</option>
							<option>财务部</option>
							<option>生产技术部</option>
							<option>计划营销部</option>
							<option>安全监察部</option>
							<option>宣传部</option>
							<option>后勤部</option>
						</select>
						<button class="btn" onclick="table1('department')">					
          					<span class="glyphicon glyphicon-search"></span>
						</button>	
					</div>
					<div style="display: inline">
						编号：
						<input class="s1" id="id1"/>
						<button class="btn " onclick="table1('id')">					
          					<span class="glyphicon glyphicon-search"></span>
						</button>
					</div>
					
					
						
					
				</div>	
					<div style="overflow:auto;">
						<table class="table table-hover table-bordered" id="mytable_1">
							<caption style="text-align: center; font-size: 18px;"></caption>
							<thead id="mytable_1h">
								<tr>
									
								</tr>
							</thead>
							<tbody id="mytable_1b">
								
							</tbody>
						</table>
					</div>
				</div>
            	<hr>
            
            	<h2 id="section-2">部门统计报表</h2>
            	<div style="border:double #90EE90 8px;border-radius:12px;padding:0 2%;">
					
					<div class="myQuery">
					
					<div style="display: inline">
						年份：
						<select id="year2">
							<option>2019</option>
							<option>2018</option>
							<option>2017</option>
							<option>2016</option>
							<option>2015</option>
							<option>2014</option>
							<option>2013</option>
							<option>2012</option>
							<option>2011</option>
							<option>2010</option>
						</select>
						<button class="btn" onclick="table2('year')">					
          					<span class="glyphicon glyphicon-search"></span>
						</button>
						&nbsp;&nbsp;&nbsp;&nbsp;月份:
						<select id="month2">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
							<option>6</option>
							<option>7</option>
							<option>8</option>
							<option>9</option>
							<option>10</option>
							<option>11</option>
							<option>12</option>
						</select>
						<button class="btn" onclick="table2('month')">					
          					<span class="glyphicon glyphicon-search"></span>
						</button>	
					</div>
				</div>	
					<div style="overflow:auto;">
						<table class="table table-hover table-bordered" id="mytable_3">
							<caption style="text-align: center; font-size: 18px;"></caption>
							<thead id="mytable_2h">
								<tr>
									<th>部门</th>
									<th>年度/月度</th>
									<th>总基本工资</th>
									<th>平均基本工资</th>
									<th>最低基本工资</th>
									<th>最高基本工资</th>
								</tr>
							</thead>
							<tbody id="mytable_2b">
								<tr>

								</tr>
							</tbody>
						</table>
					</div>
				</div>
            	<hr>
            	
            	<h2 id="section-3">公司统计报表</h2>
            	<div  style="border:double #DDA0DD 8px;border-radius:12px;padding:0 2%;">			
					<div class="myQuery">
						<div style="display: inline">
						年份：
						<select id="year3">
							<option>2019</option>
							<option>2018</option>
							<option>2017</option>
							<option>2016</option>
							<option>2015</option>
							<option>2014</option>
							<option>2013</option>
							<option>2012</option>
							<option>2011</option>
							<option>2010</option>
						</select>
						<button class="btn" onclick="table3('year')">					
          					<span class="glyphicon glyphicon-search"></span>
						</button>	
					</div>
						
							
						
					</div>	
					<div style="overflow:auto;">
						<table class="table table-hover table-bordered"  id="mytable_4">
							<caption style="text-align: center; font-size: 18px;"></caption>
							<thead>
								<tr>
									<th>年度/月度</th>
									<th>总工资</th>
									<th>平均工资</th>
									<th>最低工资</th>
									<th>最高工资</th>
								</tr>
							</thead>
							<tbody id="mytable_3b">
															
							</tbody>
						</table>
					</div>
				</div>
            	<hr>
            	
            	<h2 id="section-4">员工统计报表</h2>
            	<div style="border:double #AFEEEE 8px;border-radius:12px;padding:0 2%;">
					
					<div class="myQuery">
					<div style="display: inline">
						年份：
						<select id="year4">
							<option>2019</option>
							<option>2018</option>
							<option>2017</option>
							<option>2016</option>
							<option>2015</option>
							<option>2014</option>
							<option>2013</option>
							<option>2012</option>
							<option>2011</option>
							<option>2010</option>
						</select>
						<button class="btn" onclick="table4('year')">					
          					<span class="glyphicon glyphicon-search"></span>
						</button>
						&nbsp;&nbsp;&nbsp;&nbsp;月份:
						<select id="month4">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
							<option>6</option>
							<option>7</option>
							<option>8</option>
							<option>9</option>
							<option>10</option>
							<option>11</option>
							<option>12</option>
						</select>
						<button class="btn" onclick="table4('month')">					
          					<span class="glyphicon glyphicon-search"></span>
						</button>	
					</div>
					
						
					
				</div>	
					<div style="overflow:auto;">
						<table class="table table-hover table-bordered" id="mytable_2">
							<caption style="text-align: center; font-size: 18px;"></caption>
							<thead id="mytable_4h">
								
							</thead>
							<tbody id="mytable_4b">
								
							</tbody>
						</table>
					</div>
				</div>
            	<hr>
            	
        	</div>
    	</div>
	</div>
</body>




<script type="text/javascript">

	
	$(document).ready(function display(){
		var myDate = new Date();
		$("#start").val(myDate.getFullYear()+"-"+(myDate.getMonth()+1));
		$("#end").val(myDate.getFullYear()+"-"+(myDate.getMonth()+1));
		table1('department');
		$("#year2").val(myDate.getFullYear());
		$("#month2").val(myDate.getMonth()+1);
		table2('month');
		$("#year3").val(myDate.getFullYear());
		table3('year');
		$("#id4").val(1001);
		$("#year4").val(myDate.getFullYear());
		$("#month4").val(myDate.getMonth()+1);
		table4('month');
	})
	





	function table1(s){
		$.ajax({
			type:"GET",
			url:"ReportManage",
			data:"method=table1&way="+s+"&start="+document.getElementById("start").value+"&end="
					+document.getElementById("end").value+"&"+s+"="+document.getElementById(s+"1").value,
			dataType: "text",
			success : function(data) {
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				if(data=="日期输入有误")	alert(data);
				else if(data=="查询不存在")	alert(data);
				else if(data=="未发放工资")	alert(data);
				else displaytable1(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});    
	}
	function displaytable1(data){
		var key = new Array();
        $.each($.parseJSON(data), function(i, g) {    
        	var map = g.map;
        	var list = Array();
        	if(i==0){
        		list = g.list;
        		$('#mytable_1h').empty();
        		$('#mytable_1b').empty();
        		$('#mytable_1h').append('<tr id="1h">');
        		$('#1h').append(
        			'<th>部门</th>'+
        			'<th>编号</th>'+
        			'<th>员工</th>'+
        			'<th>实发工资</th>'
        		);
        		key.push("department");
        		key.push("id");
        		key.push("name");
        		key.push("sum");
        		for(var j=0;j<list.length;j++){
        			$('#1h').append('<th>'+list[j]+'</th>');
        			key.push(list[j]);
        		}
        		$('#1h').append(
            			'<th>迟到扣款</th>'+
            			'<th>早退扣款</th>'+
            			'<th>病假扣款</th>'+
            			'<th>事假扣款</th>'+
            			'<th>旷工扣款</th>'
            		);
        		key.push("迟到扣款");
        		key.push("早退扣款");
        		key.push("病假扣款");
        		key.push("事假扣款");
        		key.push("旷工扣款");
        		
        		for(var prop in map){
            	    if(map.hasOwnProperty(prop)){
            	        if(!(prop=="迟到扣款"||prop=="早退扣款"||prop=="病假扣款"||prop=="事假扣款"||prop=="旷工扣款"||prop=="sum"||prop=="department"||prop=="id"||prop=="name")){
            	        	var flag = 1;
            	        	for(var j=0;j<list.length;j++){
            	        		if(list[j]==prop){
            	        			flag = 0;
            	        			break;
            	        		}
            	        	}
            	        	if(flag==1){
            	        		$('#1h').append('<th>'+prop+'</th>');
            	        		key.push(prop);
            	        	}
            	        	
            	        }
            	    }
            	}
        	}
        	
        	$('#mytable_1b').append('<tr id=1b'+i+'>');
        	for(var j=0;j<key.length;j++){
        		if(g.map[key[j]]=="undefined")	g.map[key[j]]=0;
        		$('#1b'+i).append('<td>'+g.map[key[j]]+'</td>');
        	}
        	
        })
	}
	
	function table2(s){
		$.ajax({
			type:"GET",
			url:"ReportManage",
			data:"method=table2&way="+s+"&year="+document.getElementById("year2").value+"&month="
			+document.getElementById("month2").value,
			dataType: "text",
			success : function(data) {		
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				if(data=="日期输入有误")	alert(data);
				else if(data=="未发放工资")	alert(data);
				else displaytable2(data);
				//else alert(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});    
	}
	
	function displaytable2(data){
		$('#mytable_2b').empty();
		var s;
		var key=new Array();
		$.each($.parseJSON(data), function(i, g){
			if(i==0){
				for(var prop in g.map){
		    	    if(g.map.hasOwnProperty(prop)){
		    	        if(prop=="年份")		s="年份";
		    	        if(prop=="月份")		s="月份";
		    	    }
		    	}
				key=['部门',s,'总基本工资','平均基本工资','最低基本工资','最高基本工资'];
			}
			$('#mytable_2b').append('<tr id=2b'+i+'>');
			for(var j=0;j<key.length;j++){
				$('#2b'+i).append('<td>'+g.map[key[j]]+'</td>');
			}
		})
	}
	
	function table3(s){
		$.ajax({
			type:"GET",
			url:"ReportManage",
			data:"method=table3&way="+s+"&year="+document.getElementById("year3").value+"&month=",
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				if(data=="日期输入有误")	alert(data);
				else if(data=="未发放工资")	alert(data);
				else displaytable3(data);
	            //alert(data);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});    
	}
	
	function displaytable3(data){
		$('#mytable_3b').empty();
		var key=new Array();
		
		key=['月份','总工资','平均工资','最低工资','最高工资'];
		
		$.each($.parseJSON(data), function(i, g){
			
			$('#mytable_3b').append('<tr id=3b'+i+'>');
			for(var j=0;j<key.length;j++){
				$('#3b'+i).append('<td>'+g.map[key[j]]+'</td>');
			}
		})
		
	}
	
	function table4(s){
		$.ajax({
			type:"GET",
			url:"ReportManage",
			data:"method=table4&way="+s+"&year="+document.getElementById("year4").value+"&month="
			+document.getElementById("month4").value,
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				if(data=="日期输入有误")	alert(data);
				else if(data=="未发放工资")	alert(data);
				else displaytable4(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});    
	}
	
	function displaytable4(data){
		var key = new Array();
        $.each($.parseJSON(data), function(i, g) {    
        	var map = g.map;
        	var list = Array();
        	if(i==0){
        		var s;
        		list = g.list;
        		for(var prop in map){
            	    if(map.hasOwnProperty(prop)){
            	        if(prop=="年份")		s="年份";
            	        if(prop=="月份")		s="月份";
            	    }
            	}
        		$('#mytable_4h').empty();
        		$('#mytable_4b').empty();
        		$('#mytable_4h').append('<tr id="4h">');
        		$('#4h').append(
        			'<th>部门</th>'+
        			'<th>编号</th>'+
        			'<th>员工</th>'+
        			'<th>'+s+'</th>'+
        			'<th>实发工资</th>'
        		);
        		key.push("department");
        		key.push("id");
        		key.push("name");
        		key.push(s);
        		key.push("sum");
        		for(var j=0;j<list.length;j++){
        			$('#4h').append('<th>'+list[j]+'</th>');
        			key.push(list[j]);
        		}
        		$('#4h').append(
            			'<th>迟到扣款</th>'+
            			'<th>早退扣款</th>'+
            			'<th>病假扣款</th>'+
            			'<th>事假扣款</th>'+
            			'<th>旷工扣款</th>'
            		);
        		key.push("迟到扣款");
        		key.push("早退扣款");
        		key.push("病假扣款");
        		key.push("事假扣款");
        		key.push("旷工扣款");
        		
        		for(var prop in map){
            	    if(map.hasOwnProperty(prop)){
            	        if(!(prop=="迟到扣款"||prop=="早退扣款"||prop=="病假扣款"||prop=="事假扣款"||prop=="旷工扣款"||prop=="sum"||prop=="department"||prop=="id"||prop=="name"||prop==s)){
            	        	var flag = 1;
            	        	for(var j=0;j<list.length;j++){
            	        		if(list[j]==prop){
            	        			flag = 0;
            	        			break;
            	        		}
            	        	}
            	        	if(flag==1){
            	        		$('#4h').append('<th>'+prop+'</th>');
            	        		key.push(prop);
            	        	}
            	        	
            	        }
            	    }
            	}
        	}
        	
        	$('#mytable_4b').append('<tr id=4b'+i+'>');
        	for(var j=0;j<key.length;j++){
        		$('#4b'+i).append('<td>'+g.map[key[j]]+'</td>');
        	}
        	
        })
	}
	
</script>
</html>