<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="myCSS/mytable.css" />
	<link rel="stylesheet" href="myCSS/myhead.css" />
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-3.4.1.min.js" ></script>

</head>

<body style="background-color:#D6E9C6;">
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
   				<button type="button" class="btn" onclick="window.location.href='attendanceManage.jsp'">考勤管理</button>
   				<div class="btn-group">
     					<button type="button" class="btn dropdown-toggle" data-toggle="dropdown" style="background: linear-gradient(#255625, #5CB85C);color: white;">
     					工资管理 <span class="caret"></span></button>
     					<ul class="dropdown-menu" role="menu">
       					<li><a href="salaryProject.jsp">工资项目</a></li>
       					<li><a href="#" style="background-color: #DDDDDD;">固定工资</a></li>
       					<li><a href="salaryCalculation.jsp">工资结算</a></li>
     					</ul>
   				</div>
   				<button type="button" class="btn " onclick="window.location.href='report.jsp'">报表查询</button>
 				</div>
		</div>
	</div>
	
	<!--
       	作者：offline
       	时间：2019-06-25
       	描述：主体内容
       -->
	<div>
		<div class="table_head">
			<div id="table_head_title" >固定工资项目表</div>
			<div>
				
				<button class="btn btn-primary btn-lg" onclick="changeToUneditable()" style="float: right; margin-right: 8%; margin-top: 10px;">					
         					<span class="glyphicon glyphicon-saved"></span> 保存所有
				</button>	
				<button class="btn btn-default" onclick="changeToEditable()" style="float: right; margin-right: 2%; margin-top: 15px;">					
         					<span class="glyphicon glyphicon-refresh"></span> 编辑
				</button>
			</div>
		
		</div>
		
		<!--
           	作者：offline
           	时间：2019-06-25
           	描述：表格
           -->
		<div>
		
			<div style="height:400px;overflow:auto; padding-left:5%;padding-right: 5%;" >
				<form>
				<input type="hidden" name="method" value="save">
				<table class="table table-striped " id="mytable" style=" text-align: center;border: none;" >
					<thead>
					
					</thead>
					<tbody>	
								
					</tbody>
					
				</table>
				</form>
			</div>
			
			<div class="myQuery">
				<div style="display: inline">
					部门：
					<select id="qdepartment">
						<option>全部</option>
						<option>人力资源部</option>
						<option>财务部</option>
						<option>生产技术部</option>
						<option>计划营销部</option>
						<option>安全监察部</option>
						<option>宣传部</option>
						<option>后勤部</option>
					</select>
					<button class="btn btn-primary " onclick="querydepartment()">					
         					<span class="glyphicon glyphicon-search"></span>
					</button>	
				</div>
				<div style="display: inline">
					编号：
					<input class="s1" id="qid"/>
					<button class="btn btn-primary " onclick="queryid()">					
         					<span class="glyphicon glyphicon-search"></span>
					</button>	
				</div>
				<div style="display: inline">
					工资范围/元：
					<input placeholder="low" id="min"/>
					~
					<input placeholder="high" id="max"/>
					<button class="btn btn-primary " onclick="querysalary()">					
         					<span class="glyphicon glyphicon-search"></span>
					</button>	
				</div>
				
					
				
			</div>	
		</div>
	</div>
</body>

<script>

	$(document).ready(function display(){
	
		$.ajax({
			type:"GET",
			url:"FixedSalaryManage",
			data:"method=query&way=all",
			dataType: "text",
			success : function(data) {		
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
	            displayPage(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});    
	});
	
	function querydepartment(){
		$.ajax({
			type:"GET",
			url:"FixedSalaryManage",
			data:"method=query&way=department&department="+document.getElementById("qdepartment").value,
			dataType: "text",
			success : function(data) {		
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
	            displayPage(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});   
	}
	
	function queryid(){
		$.ajax({
			type:"GET",
			url:"FixedSalaryManage",
			data:"method=query&way=id&id="+document.getElementById("qid").value,
			dataType: "text",
			success : function(data) {		
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
	            displayPage(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});   
	}
	
	function querysalary(){
		
		$.ajax({
			type:"GET",
			url:"FixedSalaryManage",
			data:"method=query&way=salary&min="+document.getElementById("min").value+"&max="+document.getElementById("max").value,
			dataType: "text",
			success : function(data) {		
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
	            displayPage(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		}); 
		
	}
	
	
	function displayPage(data){
		var key = new Array();
		key.push("department");
		key.push("id");
		key.push("name");
		$('form').empty();
		$('form').append('<input type="hidden" name="method" value="save">'+
		'<table class="table table-striped " id="mytable" style=" text-align: center;border: none;" >'+
		'<thead></thead><tbody></tbody></table>');
		$('thead').append('<tr id=h>');
		$('#h').append('<th>部门</th><th>编号</th><th>员工姓名</th>');
        $.each($.parseJSON(data), function(i, list) {  
        	map = list.map;
        	if(i==0){
        		for(var prop in map){
            	    if(map.hasOwnProperty(prop)){
            	        if(!(prop=="department"||prop=="id"||prop=="name")){
            	        	key.push(prop);
            	        	$('#h').append('<th>'+prop+'</th>');
            	        }
            	    }
            	}
        	}
        	
        	$('tbody').append('<tr id='+i+'>');
        	for(var j =0;j<=2;j++){
        		//$('#'+i).append('<td>'+map[key[j]]+'</td>');
        		$('form').append('<input type="hidden" name="'+key[j]+i+'" value="'+map[key[j]]+'" readonly="true" style="border-width: 0px;"/>');
        		$('#'+i).append('<td>'+map[key[j]]+'</td>');
        	}
        	for(var j=3;j<key.length;j++){
        		$('#'+i).append('<td><input name="'+key[j]+i+'" value="'+map[key[j]]+'" readonly="true" style="border-width: 0px;"/></td>');
        	}
        })
	}
	
	
	
	
	function changeToEditable(){
		var table_inputs=document.getElementById("mytable").getElementsByTagName("input");
		for(var i=0;i<table_inputs.length;i++){
			table_inputs[i].removeAttribute("readonly");
			$(table_inputs[i]).css("border-width","2px");
			$(table_inputs[i]).css("background-color","white");
		}
		
	}
	
	function changeToUneditable(){
		var table_inputs=document.getElementById("mytable").getElementsByTagName("input");
		for(var i=0;i<table_inputs.length;i++){				
			$(table_inputs[i]).attr("readonly","readonly");
			$(table_inputs[i]).css("border-width","0px");
			$(table_inputs[i]).css("background-color","transparent");
		}
		$.ajax({
			type:"GET",
			url:"FixedSalaryManage",
			data:$('form').serializeArray(),
			dataType: "text",
			success : function(data) {		
				window.alert("成功");
	            //displayPage(data);
	            //alert(key);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		}); 
		
	}
	
</script>

</html>