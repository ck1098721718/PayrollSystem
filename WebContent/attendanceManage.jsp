<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.util.List,mybean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>考勤管理</title>

<link rel="stylesheet" href="myCSS/myhead.css" />
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="myCSS/mytable.css" />
<link rel="stylesheet" href="myCSS/mymodal.css" />
<script type="text/javascript" src="js/jquery-3.4.1.min.js" ></script>
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
    			<button type="button" class="btn" style="background: linear-gradient(#255625, #5CB85C);color: white;">考勤管理</button>
    			<div class="btn-group">
      				<button type="button" class="btn dropdown-toggle" data-toggle="dropdown" >
      				<a href="#" style="color:white;">工资管理</a><span class="caret"></span></button>
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
		
	<div>
		<div class="table_head">
			<div id="table_head_title" >考勤信息表</div>		
		</div>
		
		<div>
			<div style="padding: 0px 8%;" >
				<table class="table table-striped table-bordered" id="mytable" >
				</table>
			</div>
			
			<!--
               	作者：offline
               	时间：2019-06-25
               	描述：分页选择栏
            -->
			<div >
				<ul class="pagination" id="table_page_divide" >
					<li><a id="lengthoflist">总数</a></li>
					<li><a id="btn0">当前</a></li>
					
					<li><a id="btn1">首页</a></li>						
					<li><a id="btn2">&laquo;</a></li>						
					<li><a id="btn3">&raquo;</a></li>
					<li><a id="btn4">尾页</a></li>
					
					<li><a>转到<input id="changePage" type="text"/>页</a>
					<a id="btn5">跳转</a></li>
				</ul>
					
				<div>
					<button class="btn btn-info btn-lg" onclick="addStaff()" data-toggle="modal" data-target="#myModal_add" style="display:inline;float: right; margin-right: 8%; ">					
          				<span class="glyphicon glyphicon-plus"></span> 添加考勤
					</button>				
				</div>				
			</div>
				
		</div>
		
		<!--
          	作者：offline
           	时间：2019-06-25
           	描述：模态框--添加考勤
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
							添加考勤
						</h4>
					</div>
					<div class="modal-body" style="padding: 10px 120px ;  ">
						<div style="border: double #C1E2B3 5px; background-color: #EAF2D3;">
							<form action="AddAttendance" id="page_add_attendance" method="get">
								<ul class="center-block myUl_model">
									<li class="myLi_modal">										
										<div>
										<span>部门:&nbsp;</span>
											<select class="form-control" name="department" style=" width: 150px; display: inline;">
  												<option value="人力资源部">人力资源部</option>
  												<option value="财务部">财务部</option>
  												<option value="生产技术部">生产技术部</option>
  												<option value="计划营销部">计划营销部</option>
  												<option value="安全监察部">安全监察部</option>
  												<option value="宣传部">宣传部</option>
  												<option value="后勤部">后勤部</option>
											</select>
										</div>
									</li>
									
									<li  class="myLi_modal">
										<div>
											<span>编号:&nbsp;</span>										
											<input type="text" placeholder="请输入编号" name="id" />
											
										</div>																				
									</li>
									<li  class="myLi_modal">
										<div>
											<span>姓名:&nbsp;</span>										
											<input type="text" placeholder="请输入姓名" name="name"/>
											
										</div>																				
									</li>
									<li  class="myLi_modal">
										<div>
											<span>日期:&nbsp;</span>										
											<input type="text" placeholder="请输入日期xxxx-xx-xx" name="date"/>
										</div>																				
									</li>
									<li class="myLi_modal">
										<div>
											<span>事件:&nbsp;</span>										
											<select class="form-control" name="event" style="width: 80px; display: inline;">
												<option value="病假">病假</option>
  												<option value="事假">事假</option>
  												<option value="迟到">迟到</option>
  												<option value="早退">早退</option>
  												<option value="旷工">旷工</option>
											</select>
										</div>
										
									</li>
									
								</ul>
							</form>
						</div>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" onclick="add()" data-dismiss="modal">
							确认添加
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
		
		<!--
           	作者：offline
           	时间：2019-06-25
           	描述：模态框--修改考勤
        -->
		<div class="modal fade" id="myModal_edit" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
						&times;
						</button>
						<h4 class="modal-title" id="myModal_headTitle">
							修改考勤信息
						</h4>
					</div>
					<div class="modal-body" style="padding: 10px 120px ;  ">
						<div style="border: double #C1E2B3 5px; background-color: #EAF2D3;">
							<form action="UpdateAttendance" method = "post" id="page_edit_attendance">
								<ul class="center-block myUl_model">
									<li class="myLi_modal">										
										<div>
										<span>部门:&nbsp;</span>
											<select class="form-control" name="department" style=" width: 150px; display: inline;" onfocus="this.defaultIndex=this.selectedIndex;" onchange="this.selectedIndex=this.defaultIndex;">
  												<option value="人力资源部">人力资源部</option>
  												<option value="财务部">财务部</option>
  												<option value="生产技术部">生产技术部</option>
  												<option value="计划营销部">计划营销部</option>
  												<option value="安全监察部">安全监察部</option>
  												<option value="宣传部">宣传部</option>
  												<option value="后勤部">后勤部</option>
											</select>
										</div>
									</li>
									
									<li  class="myLi_modal">
										<div>
											<span>编号:&nbsp;</span>										
											<input type="text" placeholder="请输入编号" name="id" readonly unselectable="on"/>
											
										</div>																				
									</li>
									<li  class="myLi_modal">
										<div>
											<span>姓名:&nbsp;</span>										
											<input type="text" placeholder="请输入姓名" name="name" readonly unselectable="on"/>
											
										</div>																				
									</li>
									<li  class="myLi_modal">
										<div>
											<span>日期:&nbsp;</span>										
											<input type="text" placeholder="请输入日期xxxx-xx-xx" name="date"/>
											
										</div>																				
									</li>
									<li class="myLi_modal">
										<div>
											<span>事件:&nbsp;</span>										
											<select class="form-control" name="event" style="width: 80px; display: inline;">
												<option value="病假">病假</option>
  												<option value="事假">事假</option>
  												<option value="迟到">迟到</option>
  												<option value="早退">早退</option>
  												<option value="旷工">旷工</option>
											</select>
										</div>
										
									</li>
								</ul>
								
								<input type="hidden" name="oldDate" value="">
  								<input type="hidden" name="oldEvent" value="">
							</form>
						</div>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" onclick="update()" class="btn btn-primary" data-dismiss="modal">
							确认修改
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
	</div>
</body>
	
	<script type="text/javascript">
		
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
				url:"Query",
				data:"method=attendance&way=all",
				dataType: "text",
				success : function(data) {	
					if(data=="未登录"){
						window.location.href="login.jsp";
					}
                    $.each($.parseJSON(data), function(i, list) {        
                    	len=len+1;
                    	var t = new Array();
                    	t.push(list.department);
                    	t.push(list.id);
                    	t.push(list.name);
                    	t.push(list.date);
                    	t.push(list.event);
                    	t.push(list.remark);
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
        
        function displayPage(){
        	
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
            $("#lengthoflist").empty();
            $("#lengthoflist").append("总数:"+len);
        }          
        
        function generateTable(){
        	document.getElementById("mytable").innerHTML="";
        	$("#mytable").append('<thead ><tr><th><form id="dform" action="Query" method="get">'+
			'<select id ="qdepartment" name="department" class="form-control input-sm" style="width: 110px;display: inline;">'+
			'<option value="全部">全部</option>'+
			'<option value="人力资源部">人力资源部</option>'+
			'<option value="财务部">财务部</option>'+
			'<option value="生产技术部">生产技术部</option>'+
			'<option value="计划营销部">计划营销部</option>'+
			'<option value="安全监察部">安全监察部</option>'+
			'<option value="宣传部">宣传部</option>'+
			'<option value="后勤部">后勤部</option></select>'+
			'<input type="hidden" name="way" value="department">'+
			'<input type="hidden" name="method" value="attendance">'+
			'<input type="button" value="查询"  onclick="querydepartment()" class="btn btn-default btn-xs" style="background-color: #255625;color:white;display: inline;"/>'+
			'</form></th><th>'+
			'<form action="Query" id="iform" method="get">	编号'+
			'<input type="text" class="form-control input-sm" id="qid" name="id" value=""  style="width: 50px;display: inline;"/>'+
			'<input type="hidden" name="way" value="id">'+
			'<input type="hidden" name="method" value="attendance">'+
			'<input type="button" value="查询"  onclick="queryid()" style="background-color: #255625; border: none; border-radius: 5px;"/>'+
			'</form></th><th>姓名</th><th>日期</th><th>事件</th><th>操作人员</th><th>修改</th><th>删除</th></tr></thead>');
        	
     
        	$tbody=$("<tbody></tbody");
        	
        	
			
			for(var i=(curPage-1)*pageSize;(i<curPage*pageSize)&&(i<len);i++){
				
    			$tbody.append('<tr>'+
    			'<td >'+tbl[i][0]+'</td>'+
    			'<td >'+tbl[i][1]+'</td>'+
    			'<td >'+tbl[i][2]+'</td>'+
    			'<td >'+tbl[i][3]+'</td>'+
    			'<td >'+tbl[i][4]+'</td>'+
    			'<td >'+tbl[i][5]+'</td>'+
    			'<td style="width: 40px;"><a class="btn btn-info btn-xs" data-toggle="modal" data-target="#myModal_edit" onclick="editAttendance(this.parentNode.parentNode)">'+
    			'<span class="glyphicon glyphicon-refresh"></span></a></td>'+
    			'<td style="width: 40px;"><a class="btn btn-info btn-xs" onclick="del('+tbl[i][1]+',\''+tbl[i][3]+'\',\''+tbl[i][4]+'\')">'+
    			'<span class="glyphicon glyphicon-remove"></span></a></td>'+
    			'</tr>');
    			
			}
			
			$tbody.appendTo("#mytable");
        }
        
        function querydepartment(){
        	qid = "";
        	qdepartment = document.getElementById("qdepartment").value;
        	$.ajax({
				type:"GET",
				url:"Query",
				data:$("#dform").serializeArray(),
				dataType: "text",
				success : function(data) {	
					if(data=="未登录"){
						window.location.href="login.jsp";
					}
					tbl.length=0;
					len=0;
                    $.each($.parseJSON(data), function(i, list) {        
                    	len=len+1;
                    	var t = new Array();
                    	t.push(list.department);
                    	t.push(list.id);
                    	t.push(list.name);
                    	t.push(list.date);
                    	t.push(list.event);
                    	t.push(list.remark);
                    	tbl.push(t);                   	
                    })
                    displayPage();
                    
                },
		        error: function(){
		        	window.alert("失败");
		        }
			});
        }
        
        function queryid(){
        	qid = document.getElementById("qid").value;
        	qdepartment = "全部";
        	$.ajax({
				type:"GET",
				url:"Query",
				data:$("#iform").serializeArray(),
				dataType: "text",
				success : function(data) {	
					if(data=="未登录"){
						window.location.href="login.jsp";
					}
					tbl.length=0;
					len=0;
                    $.each($.parseJSON(data), function(i, list) {        
                    	len=len+1;
                    	var t = new Array();
                    	t.push(list.department);
                    	t.push(list.id);
                    	t.push(list.name);
                    	t.push(list.date);
                    	t.push(list.event);
                    	t.push(list.remark);
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
        	
        	qid = document.getElementById("qid").value;
        	qdepartment = document.getElementById("qdepartment").value;
        	$.ajax({
    			type:"GET",
    			url:"UpdateAttendance",
    			data:$("#page_edit_attendance").serializeArray(),
    			dataType: "text",
    	        success: function(data){
    	        	if(data=="未登录"){
						window.location.href="login.jsp";
					}
    	        	window.alert($.parseJSON(data).backNews);
    	        	if($.parseJSON(data).backNews=="修改考勤数据成功"){
    	        		for(var i=0;i<tbl.length;i++){
    	        			//判断是否相等
    	        			if($.parseJSON(data).id==tbl[i][1]&&$.parseJSON(data).oldDate==tbl[i][3]&&$.parseJSON(data).oldEvent==tbl[i][4]){
    	                    	tbl[i][3] = $.parseJSON(data).date;
    	                    	tbl[i][4] = $.parseJSON(data).event;
    	                    	tbl[i][5] = $.parseJSON(data).remark;
    	        			}
    	        		}
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
        
        function add(){
        	qid = document.getElementById("qid").value;
        	qdepartment = document.getElementById("qdepartment").value;
        	$.ajax({
    			type:"GET",
    			url:"AddAttendance",
    			data:$("#page_add_attendance").serializeArray(),
    			dataType: "text",
    	        success: function(data){
    	        	if(data=="未登录"){
						window.location.href="login.jsp";
					}
    	        	window.alert($.parseJSON(data).backNews);
    	        	if($.parseJSON(data).backNews=="添加成功"){
    	        		len=len+1;
    	        		var t = new Array();
                    	t.push($.parseJSON(data).department);
                    	t.push($.parseJSON(data).id);
                    	t.push($.parseJSON(data).name);
                    	t.push($.parseJSON(data).date);
                    	t.push($.parseJSON(data).event);
                    	t.push($.parseJSON(data).remark);
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
        
        function del(id,date,event){
        	qid = document.getElementById("qid").value;
        	qdepartment = document.getElementById("qdepartment").value;
        	$.ajax({
    			type:"GET",
    			url:"DeleteAttendance",
    			data:"id="+id+"&event="+event+"&date="+date,
    			dataType: "text",
    	        success: function(data){
    	        	if(data=="未登录"){
						window.location.href="login.jsp";
					}
    	        	//刷新页面
    	        	tbl = tbl.filter(function(item) {
					     return ((item[1]!= id)||(item[3]!=date)||(item[4]!=event))
					});
    	        	len=len-1;
    	        	displayPage();
    	        	
    	        },
    	        error: function(){
    	            
    	        }
    		});
        }
        
        /*function del(id){
        	
        	document.getElementById("head").innerHTML="111111111";
        	console.log(id);
        	window.location.href = "deleteAttendance?id="+id;
        }*/
		
		
		function editAttendance(obj) {
        	var inp = obj.getElementsByTagName("td");
        	
			var inp_target_input=document.getElementById("myModal_edit").getElementsByTagName("input");
			var inp_target_selector=document.getElementById("myModal_edit").getElementsByTagName("select");
			
        	for (var i=0;i<3;i++)
        	{
            	inp_target_input[i].value=inp[i+1].innerHTML;
        	}
        	
        	inp_target_input[3].value=inp[3].innerHTML;
        	inp_target_input[4].value=inp[4].innerHTML;
        	
        	var selector_options_depart=inp_target_selector[0].options;
			for(var i=0;i<selector_options_depart.length;i++){
				if(selector_options_depart[i].innerHTML==inp[0].innerHTML){
					selector_options_depart[i].selected=true;
					break;
				}
			}
			
			//document.getElementById("head").innerHTML=inp[4].value;
			var selector_options_sex=inp_target_selector[1].options;
			for(var i=0;i<selector_options_sex.length;i++){
				if(selector_options_sex[i].innerHTML==inp[4].innerHTML){
					selector_options_sex[i].selected=true;
					break;
				}
			}
		 
    	}
		
		
		function getObject(str){
			return document.getElementById(str);
		}
		
	</script>
</html>