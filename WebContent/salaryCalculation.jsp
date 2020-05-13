<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="myCSS/myhead.css" />
		<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
		<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="myCSS/mytable.css" />
		<link rel="stylesheet" href="myCSS/mymodal.css" />
		
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
 				<div class="btn-group btn-group-justified" id="myButtonGroup" style="bottom: 3px;">
   				<button type="button" class="btn" onclick="window.location.href='main.jsp'">&nbsp;首页&nbsp;</button>
    			<button type="button" class="btn" onclick="window.location.href='employeeManage.jsp'">员工管理</button>
   				<button type="button" class="btn " onclick="window.location.href='attendanceManage.jsp'">考勤管理</button>
   				<div class="btn-group">
     					<button type="button" class="btn dropdown-toggle" data-toggle="dropdown" style="background: linear-gradient(#255625, #5CB85C);color: white;" >
     					工资管理 <span class="caret"></span></button>
     					<ul class="dropdown-menu" role="menu">
       					<li><a href="salaryProject.jsp">工资项目</a></li>
        				<li><a href="fixedSalary.jsp">固定工资</a></li>
       					<li><a href="#" style="background-color:#DDDDDD;">工资结算</a></li>
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
			<div id="table_head_title" >工资结算表</div>
			<div>
			<button class="btn btn-primary btn-lg" onclick="save()" style="float: right; margin-right: 20px; margin-top: 10px;" >					
         					<span >$</span> 发放
				</button>	
				<button class="btn btn-lg" data-toggle="modal" data-target="#myModal" style="float: right; margin-right: 20px; margin-top: 10px;background-color: #B2DBA1; color: #2B542C;" >					
         					<span class="glyphicon glyphicon-search"></span> 查询
				</button>				
			</div>
		
		</div>
		
		<!--
           	作者：offline
           	时间：2019-06-25
           	描述：表格
           -->
		<div>
			<div style="padding: 0px 50px;" >
				
				<table class="table table-striped table-bordered" id="mytable" >
				<!--<caption>条纹表格布局</caption>-->
					<thead>
						
					</thead>
					<tbody>
						
					</tbody>
				</table>
				
			</div>
			
			<!--
               	作者：offline
               	时间：2019-06-25
               	描述：分页选择栏
               -->
			<div>
				<ul class="pagination" id="table_page_divide">
					<li><a id="lengthoflist">总数</a></li>
					<li><a id="btn0">当前</a></li>
					<li><a id="btn1">首页</a></li>						
					<li><a id="btn2">&laquo;</a></li>						
					<li><a id="btn3">&raquo;</a></li>
					<li><a id="btn4">尾页</a></li>
					<li><a>转到<input id="changePage" type="text" style="width: 30px;height: 20px;"/>页</a>
					<a id="btn5">跳转</a></li>
				</ul>
				
			</div>
		</div>
		
		<!--
           	作者：offline
           	时间：2019-06-25
           	描述：模态框--选择部门日期
           -->
		<div class="modal fade" id="myModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
						&times;
						</button>
						<h4 class="modal-title">
							<span class="glyphicon glyphicon-search"></span>
							查询
						</h4>
					</div>
					<div class="modal-body" style="padding: 10px 120px ;  ">
						<div style="border: double #C1E2B3 5px; background-color: #EAF2D3;">
							<form action="" method="get" id="form1">
							<input type="hidden" name="method" value="query">
							<ul class="center-block myUl_model">
								<li class="myLi_modal">										
									<div>
									<span>项目类型:</span>
										<select class="form-control" id="department" name="department" style=" width: 150px; display: inline;">
											<option>人力资源部</option>
											<option>财务部</option>
											<option>生产技术部</option>
											<option>计划营销部</option>
											<option>安全监察部</option>
											<option>宣传部</option>
											<option>后勤部</option>
										</select>
									</div>
									
								</li>
								<li  class="myLi_modal">
									<div>										
										<span>查询年份:</span><input type="text" placeholder="请输入结算年份xxxx" name="year" id="year">
										</input>
									</div>																				
								</li>
								<li  class="myLi_modal">
									<div>										
										<span>查询月份:</span><input type="text" placeholder="请输入结算月份xx" name="month" id="month">
										</input>
									</div>																				
								</li>
								
							</ul>
							</form>
						</div>
					
					</div>
					<div class="modal-footer">
						
						<button type="button" class="btn btn-primary" onclick="query()" style="width: 100px;">
							查询
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
		
		
</body>



<script type="text/javascript">
	
	var tbl = new Array();
	var department;
	var yaer;
	var month;
	var pageSize = 8;    //每页显示的记录条数
	var curPage=0;        //当前页
	var lastPage;        //最后页
	var direct=0;        //方向
	var len=0;            //总行数
	var page=1;            //总页数
	var d;
	/*一进界面便打开模态框*/
	$(document).ready(function display(){ 
		$('#myModal').modal('show');
		curPage=1;    // 设置当前为第一页
        $("#btn1").click(function firstPage(){    // 首页
            curPage=1;
            direct = 0;
            displayPage();
        });
        $("#btn2").click(function frontPage(){    // 上一页
            direct=-1;
            displayPage();
        });
        $("#btn3").click(function nextPage(){    // 下一页
            direct=1;
            displayPage();
        });
        $("#btn4").click(function lastPage(){    // 尾页
            curPage=page;
            direct = 0;
            displayPage();
        });
        $("#btn5").click(function changePage(){    // 转页
            curPage=document.getElementById("changePage").value * 1;
            if (!/^[1-9]\d*$/.test(curPage)) {
                alert("请输入正整数");
                eturn ;
            }
            if (curPage > page) {
                alert("超出数据页面");
                return ;
            }
            direct = 0;
            displayPage();
        });
	});
	
	function distribute(obj){
		obj.value="已发放";
		$(obj).css("opacity","0.6");
	}
	
	
	function query(){
		$('#myModal').modal('hide');
		department = document.getElementById("department").value;
		year = document.getElementById("year").value;
		month = document.getElementById("month").value;
		$.ajax({
			type:"GET",
			url:"SalaryCalculation",
			data:$("#form1").serializeArray(),
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				else if(data=="已经发放过工资了"){
					alert(data);
				}
				else if(data=="输入的日期格式不正确"){
					alert(data);
				}
				else if(data=="未查询到相关员工"){
					alert(data);
				}
				else{
					d = data;
					len = 0;
					$.each($.parseJSON(d), function(i, g){
						len = len+1;
					})
					displayPage();
				}            
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});	    
	}
	
	function displayPage(){
		
		document.getElementById("lengthoflist").innerHTML="总数 " + len ;    // 显示当前多少页
    	//$("#lengthoflist").val(len)
    	if(len%pageSize==0){
        	page=len/pageSize;
        }
        else{
        	page=Math.floor(len/pageSize)+1;
        }
        if(curPage <=1 && direct==-1){
            direct=0;
            alert("已经是第一页了");
            return;
        } 
        else if (curPage >= page && direct==1) {
            direct=0;
            alert("已经是最后一页了");
            return ;
        }
         
        lastPage = curPage;
           
        // 修复当len=1时，curPage计算得0的bug
        if (len > pageSize) {
            curPage = ((curPage + direct + len) % len);
        } 
        else {
            curPage = 1;
        }      
        document.getElementById("btn0").innerHTML="当前 " + curPage + "/" + page ;    // 显示当前多少页
        direct = 0;
		
		var key = new Array();
        $.each($.parseJSON(d), function(i, g) {    
        	var map = g.map;
        	var list = Array();
        	if(i==0){
        		list = g.list;
        		$('thead').empty();
        		$('tbody').empty();
        		$('thead').append('<tr id="h">');
        		$('#h').append(
        			'<th style="text-align: center;">部门</th>'+
        			'<th style="text-align: center;">编号</th>'+
        			'<th style="text-align: center;">员工</th>'+
        			'<th style="text-align: center;">实发工资</th>'
        		);
        		key.push("department");
        		key.push("id");
        		key.push("name");
        		key.push("sum");
        		for(var j=0;j<list.length;j++){
        			$('#h').append('<th style="text-align: center;">'+list[j]+'</th>');
        			key.push(list[j]);
        		}
        		$('#h').append(
            			'<th style="text-align: center;">迟到扣款</th>'+
            			'<th style="text-align: center;">早退扣款</th>'+
            			'<th style="text-align: center;">病假扣款</th>'+
            			'<th style="text-align: center;">事假扣款</th>'+
            			'<th style="text-align: center;">旷工扣款</th>'
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
            	        		$('#h').append('<th style="text-align: center;">'+prop+'</th>');
            	        		key.push(prop);
            	        	}
            	        	
            	        }
            	        
            	    }
            	}
        		
        		//alert(key);
        	}
        	if((i<curPage*pageSize)&&(i<len)){
        		$('tbody').append('<tr id='+i+'>');
            	for(var j=0;j<key.length;j++){
            		$('#'+i).append('<td>'+g.map[key[j]]+'</td>');
            	}
        	}
        	
        	
        })
	}
	
	
	function save(){	
		$.ajax({
			type:"GET",
			url:"SalaryCalculation",
			data:"method=save&department="+department+"&year="+year+"&month="+month,
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
	            alert(data);
	            
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});	    
	}
	
</script>

</html>