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
 				<div class="btn-group btn-group-justified" id="myButtonGroup" style="bottom: 3px;">
   				<button type="button" class="btn" onclick="window.location.href='main.jsp'">&nbsp;首页&nbsp;</button>
    			<button type="button" class="btn" onclick="window.location.href='employeeManage.jsp'">员工管理</button>
   				<button type="button" class="btn" onclick="window.location.href='attendanceManage.jsp'">考勤管理</button>
   				<div class="btn-group">
     					<button type="button" class="btn dropdown-toggle" data-toggle="dropdown" style="background: linear-gradient(#255625, #5CB85C);color: white;" >
     					工资管理 <span class="caret"></span></button>
     					<ul class="dropdown-menu" role="menu">
       					<li><a href="#" style="background-color: #DDDDDD;">工资项目</a></li>
       					<li><a href="fixedSalary.jsp">固定工资</a></li>
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
			<div id="table_head_title" >工资项目管理表</div>
			<div>
				<button class="btn btn-lg" data-toggle="modal" data-target="#myModal_setFormule" onclick="setformula()" style="float: right; margin-right: 20px; margin-top: 10px;background-color: #B2DBA1; color: #2B542C;" >					
         					<span class="glyphicon glyphicon-cog"></span> 计算公式设置
				</button>				
			</div>		
		</div>
		
		<!--
           	作者：offline
           	时间：2019-06-25
           	描述：表格
           -->
		<div>
			<div style="padding: 0px 5%;" >
				<table class="table table-striped table-bordered" id="mytable" >
				<!--<caption>条纹表格布局</caption>-->
					<thead>
						<tr>
							<th style="width: 40px; text-align: center;">序号</th>
							<th style="text-align: center;">项目类型
								<select id="qtype" class="form-control input-sm" style="width: 100px;display: inline;">
									<option>全部</option>
									<option>固定项目</option>
									<option>计算项目</option>
								</select>
								<button type="submit" class="btn btn-default btn-xs" onclick="querytype()" style="display: inline; ">
									查询
								</button>
							</th>
							<th style="text-align: center;">名称
								<input id="qname" type="text" class="form-control input-sm" placeholder="请输入名称" style="width: 120px;display: inline; ">
								<button type="submit" onclick="queryname()" class="btn btn-default btn-xs" style="display: inline; ">
									查询
								</button>
							</th>
							<th style="text-align: center;">增减项</th>
							<th style="text-align: center;">是否显示</th>
							<th style="text-align: center;">修改</th>
							<th style="text-align: center;">删除</th>
						</tr>
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
					<li><a>&nbsp</a></li>
					<li><a id="btn1">首页</a></li>						
					<li><a id="btn2">&laquo;</a></li>						
					<li><a id="btn3">&raquo;</a></li>
					<li><a id="btn4">尾页</a></li>
					<li><a>&nbsp;</a></li>
					<li><a>转到<input id="changePage" type="text" style="width: 30px;height: 20px;"/>页</a>
					<a id="btn5">跳转</a></li>
				</ul>
				
				<div>
					<button class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal_add" style="float: right; margin-right: 5%; margin-top: 10px;">					
         					<span class="glyphicon glyphicon-plus"></span> 添加项目
					</button>				
				</div>				
			</div>
		</div>
		
		<!--
           	作者：offline
           	时间：2019-06-25
           	描述：模态框--添加项目
           -->
		<div class="modal fade" id="myModal_add" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
						&times;
						</button>
						<h4 class="modal-title">
							<span class="glyphicon glyphicon-plus"></span>
							添加工资项目
						</h4>
					</div>
					<div class="modal-body" style="padding: 10px 120px ;  ">
						<div style="border: double #C1E2B3 5px; background-color: #EAF2D3;">
							<form action="" method="get" id="addform">
							<ul class="center-block myUl_model">
								<li class="myLi_modal">										
									<div>
									<span>项目类型:</span>
										<select class="form-control" name="type" style=" width: 150px; display: inline;">
											<option>固定项目</option>
											<option>计算项目</option>
										</select>
									</div>
									
								</li>
								<li  class="myLi_modal">
									<div>
										<span>项目名称:</span>										
										<input type="text" placeholder="请输入项目名称" name="name">
										</input>
									</div>																				
								</li>
								<li class="myLi_modal">
									<div>
										<span>增减项:&nbsp</span>										
										<select class="form-control" name="affect" style="width: 70px; display: inline;">
											<option>增</option>
											<option>减</option>
											<option>无影响</option>
										</select>
									</div>
									
								</li>
								<li class="myLi_modal">
									<div>
										<span>是否显示:</span>									
										<select class="form-control" name="exhibition" style="width: 70px; display: inline;">
											<option>是</option>
											<option>否</option>
										</select>
									</div>
									
								</li>
								
							</ul>
							<input type="hidden" name="method" value="add">
							</form>
						</div>
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="add()">
							确认添加
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
		
		<!--
           	作者：offline
           	时间：2019-06-25
           	描述：模态框--修改项目
           -->
		<div class="modal fade" id="myModal_edit" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
						&times;
						</button>
						<h4 class="modal-title" id="myModal_headTitle">
							修改工资项目
						</h4>
					</div>
					<div class="modal-body" style="padding: 10px 120px ;  ">
						<div style="border: double #C1E2B3 5px; background-color: #EAF2D3;">
							<form action="" method="get" id="updateform">
							<ul class="center-block myUl_model">
								<li class="myLi_modal">										
									<div>
									<span>项目类型:</span>
										<select class="form-control" name="type" style="width: 150px; display: inline;">
											<option>固定项目</option>
											<option>计算项目</option>
										</select>
									</div>
									
								</li>
								<li  class="myLi_modal">
									<div>
										<span>项目名称:</span>										
										<input type="text" name="name" placeholder="请输入项目名称" >
										</input>
									</div>																				
								</li>
								<li class="myLi_modal">
									<div>
										<span>增减项:&nbsp;</span>										
										<select class="form-control" name="affect" style="width: 70px; display: inline;">
											<option>增</option>
											<option>减</option>
											<option>无影响</option>
										</select>
									</div>
									
								</li>
								<li class="myLi_modal">
									<div>
										<span>是否显示:</span>									
										<select class="form-control" name="exhibition" style="width: 70px; display: inline;">
											<option>是</option>
											<option>否</option>
										</select>
									</div>
									
								</li>									
							</ul>
							<input type="hidden" name="oldType" id=""/>
							<input type="hidden" name="oldName" id=""/>
							<input type="hidden" name="method" value="update">
							</form>
						</div>
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick ="update()">
							确认修改
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
	
</body>

<script>
	
	var pageSize = 8;    //每页显示的记录条数
	var curPage=0;        //当前页
	var lastPage;        //最后页
	var direct=0;        //方向
	var len=0;            //总行数
	var page=1;            //总页数
	var qdepartment="全部";
	var qid="";
	var tbl = new Array();
	
	$(document).ready(function display(){
		
		
		$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:"way=all&method=query",
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
                $.each($.parseJSON(data), function(i, list) {        
                	len=len+1;
                	var t = new Array();
                	t.push(list.map.type);
                	t.push(list.map.name);
                	t.push(list.map.exhibition);
                	t.push(list.map.affect);
                	t.push(list.map.orderNum);
                	tbl.push(t);                   	
                })
                displayPage();
            },
	        error: function(){
	        	window.alert("失败");
	        }
		});
		
		
						
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
	
	function querytype(){
		$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:"way=type&method=query&type="+document.getElementById("qtype").value,
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				tbl.length = 0;
				len = 0;
                $.each($.parseJSON(data), function(i, list) {        
                	len=len+1;
                	var t = new Array();
                	t.push(list.map.type);
                	t.push(list.map.name);
                	t.push(list.map.exhibition);
                	t.push(list.map.affect);
                	t.push(list.map.orderNum);
                	tbl.push(t);                   	
                })
                displayPage();
            },
	        error: function(){
	        	window.alert("失败");
	        }
		});
	}
	
	function queryname(){
		$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:"way=name&method=query&name="+document.getElementById("qname").value,
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				tbl.length = 0;
				len = 0;
                $.each($.parseJSON(data), function(i, list) {        
                	len=len+1;
                	var t = new Array();
                	t.push(list.map.type);
                	t.push(list.map.name);
                	t.push(list.map.exhibition);
                	t.push(list.map.affect);
                	t.push(list.map.orderNum);
                	tbl.push(t);                   	
                })
                displayPage();
            },
	        error: function(){
	        	window.alert("失败");
	        }
		});
	}
	
	function update(){
    	//qid = document.getElementById("qid").value;
    	//qdepartment = document.getElementById("qdepartment").value;
    	$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:$("#updateform").serializeArray(),
			dataType: "text",
	        success: function(data){
	        	if(data=="未登录"){
					window.location.href="login.jsp";
				}
	        	window.alert($.parseJSON(data).backNews);
	        	if($.parseJSON(data).backNews=="修改成功"){
	        		for(var i=0;i<tbl.length;i++){
	        			//判断是否相等
	        			if($.parseJSON($.parseJSON(data).map.oldName==tbl[i][1])){
	        				tbl[i][0] = $.parseJSON(data).map.type;
	                    	tbl[i][1] = $.parseJSON(data).map.name;
	                    	tbl[i][2] = $.parseJSON(data).map.exhibition;
	                    	tbl[i][3] = $.parseJSON(data).map.affect;
	        			}
	        		}
	        		//去掉弹窗
	        		//刷新页面
	        		displayPage();
	        		
	        	}
	        },
	        error: function(){
	        	window.alert("修改失败");
	        }
		});
    }
	
	function add(){
    	//qid = document.getElementById("qid").value;
    	//qdepartment = document.getElementById("qdepartment").value;
    	$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:$("#addform").serializeArray(),
			dataType: "text",
	        success: function(data){
	        	if(data=="未登录"){
					window.location.href="login.jsp";
				}
	        	window.alert($.parseJSON(data).backNews);
	        	if($.parseJSON(data).backNews=="添加成功"){
	        		len=len+1;
	        		var t = new Array();
                	t.push($.parseJSON(data).map.type);
                	t.push($.parseJSON(data).map.name);
                	t.push($.parseJSON(data).map.exhibition);
                	t.push($.parseJSON(data).map.affect);
                	t.push($.parseJSON(data).map.orderNum);
                	tbl.push(t);        
	        		//去掉弹窗
	        		//刷新页面
	        		displayPage();
	        		
	        	}
	        },
	        error: function(){
	        	window.alert("查询失败");
	        }
		});
    }
	
	function del(name){
    	//qid = document.getElementById("qid").value;
    	//qdepartment = document.getElementById("qdepartment").value;
    	$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:"method=delete&name="+name,
			dataType: "text",
	        success: function(data){
	        	if(data=="未登录"){
					window.location.href="login.jsp";
				}
	        	//刷新页面
	        	tbl = tbl.filter(function(item) {
				     return item[1] != name
				});
	        	len=len-1;
	        	displayPage();
	        	
	        },
	        error: function(){
	            
	        }
		});
    }
	
	function setformula(){
		location.href='setFormula.jsp';
	}
	
	function displayPage(){
		document.getElementById("lengthoflist").innerHTML="总数 " + len ;    // 显示当前多少页
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
        generateTable();
        document.getElementById("btn0").innerHTML="当前 " + curPage + "/" + page ;    // 显示当前多少页
        direct = 0;          
        $("#qid").val(qid)
        $("#qdepartment").val(qdepartment)
    }        
	function generateTable(){
		$('tbody').empty();
		for(var i=(curPage-1)*pageSize;(i<curPage*pageSize)&&(i<len);i++){
			$('tbody').append(
					'<tr>'+
					'<td>'+tbl[i][4]+'</td>'+
					'<td>'+tbl[i][0]+'</td>'+
					'<td>'+tbl[i][1]+'</td>'+
					'<td>'+tbl[i][3]+'</td>'+
					'<td>'+tbl[i][2]+'</td>'+
					'<td style="width: 40px;">'+
						'<a class="btn btn-info btn-xs" data-toggle="modal" data-target="#myModal_edit" onclick="mymodal_edit(this.parentNode.parentNode)">'+
 								'<span class="glyphicon glyphicon-refresh"></span>'+
							'</a>'+
					'</td>'+
					'<td  style="width: 40px;">'+
						'<a href="#" class="btn btn-info btn-xs" onclick="del('+'tbl['+i+'][1]'+')">'+
 								'<span class="glyphicon glyphicon-remove"></span>'+
							'</a>'+
					'</td>'+
				'</tr>'	
			);
		}
		
	}
	
	function mymodal_edit(obj) {
		
		//$("#myModal_headTitle").html("今天周六");
		var inp = obj.getElementsByTagName("td");
		var inp_target_input=document.getElementById("myModal_edit").getElementsByTagName("input");
		var inp_target_selector=document.getElementById("myModal_edit").getElementsByTagName("select");
       	
       	/*input:项目名称赋值*/
       	inp_target_input[0].value=inp[2].innerHTML;
       	
       	/*old type and name 赋值*/
       	inp_target_input[1].value=inp[1].innerHTML;
       	inp_target_input[2].value=inp[2].innerHTML;
       	        	
       	/*select:项目类型赋值*/
       	var selector_options_depart0=inp_target_selector[0].options;
		for(var i=0;i<selector_options_depart0.length;i++){
			if(selector_options_depart0[i].innerHTML==inp[1].innerHTML){
				selector_options_depart0[i].selected=true;
				break;
			}
		}
		
		/*select:增减项赋值*/
       	var selector_options_depart1=inp_target_selector[1].options;
		for(var i=0;i<selector_options_depart1.length;i++){
			if(selector_options_depart1[i].innerHTML==inp[3].innerHTML){
				selector_options_depart1[i].selected=true;
				break;
			}
		}
		
		/*select:是否显示赋值*/
       	var selector_options_depart2=inp_target_selector[2].options;
		for(var i=0;i<selector_options_depart2.length;i++){
			if(selector_options_depart2[i].innerHTML==inp[4].innerHTML){
				selector_options_depart2[i].selected=true;
				break;
			}
		}
					
   	}
	
	
</script>

</html>