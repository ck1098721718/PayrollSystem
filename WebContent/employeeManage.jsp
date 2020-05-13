<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.util.List,mybean.Login,mybean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工管理</title>


<link rel="stylesheet" href="myCSS/myhead.css" />
<link rel="stylesheet" href="myCSS/mystuff.css" />
<link rel="stylesheet" href="myCSS/mymodal.css" />
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-3.4.1.min.js" ></script>
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
    				<button type="button" class="btn" style="background: linear-gradient(#255625, #5CB85C);color: white;">员工管理</button>
    				<button type="button" class="btn" onclick="window.location.href='attendanceManage.jsp'">考勤管理</button>
    				<div class="btn-group">
      					<button type="button" class="btn dropdown-toggle" data-toggle="dropdown" style="background-color: #A94442;">
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
		
		<div style="width:100%;padding-left: 0;padding-right: 10%;">
    		<div class="row">
        		<div class="col-xs-2" id="myScrollspy" >
            		<ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125">
                		<li class="active"><a href="#section-1">*&nbsp;人力资源部</a></li>
                		<li><a href="#section-2">*&nbsp;财务部 </a></li>
               			<li><a href="#section-3">*&nbsp;生产技术部 </a></li>
               			<li><a href="#section-4">*&nbsp;计划营销部</a></li>
               			<li><a href="#section-5">*&nbsp;安全监察部</a></li>
               			<li><a href="#section-6">*&nbsp;宣传部</a></li>
               			<li><a href="#section-7">*&nbsp;后勤部</a></li>
               			<div>
            			<button class="btn-primary btn-lg" id="my_add_stuff" data-toggle="modal" data-target="#myModal_add"">
               				<span class="glyphicon glyphicon-plus">添加员工</span>
               			</button>
            		</div>
            		</ul>
            		
            		
        		</div>
        	
        		<div class="col-xs-10" style="background-color: white;border: double; border-radius: 20px;border-width: 8px;border-color: #B2DBA1;">
        			<div style="border-bottom-style: double;border-width: 5px;border-color: #B2DBA1;">
	            		<h2 id="section-1">人力资源部</h2>
	            		<div id="div人力资源部">
	            		
	            		</div>
	            		
	            	</div>
	            	<hr>
					<div style="border-bottom-style: double;border-width: 5px;border-color: #B2DBA1;">
	            		<h2 id="section-2">财务部</h2>
	            		<div id="div财务部"></div>
	            	</div>
	            	<hr>
	            	<div style="border-bottom-style: double;border-width: 5px;border-color: #B2DBA1;">
	            		<h2 id="section-3">生产技术部</h2>
	            		<div id="div生产技术部"></div>
	            	</div>
	            	<hr>
	            	<div style="border-bottom-style: double;border-width: 5px;border-color: #B2DBA1;">
	            		<h2 id="section-4">计划营销部</h2>
	            		<div id="div计划营销部"></div>
	            	</div>
	            	<hr>
	            	<div style="border-bottom-style: double;border-width: 5px;border-color: #B2DBA1;">
	            		<h2 id="section-5">安全监察部</h2>
	            		<div id="div安全监察部"></div>
	            	</div>
	            	<hr>
	            	<div style="border-bottom-style: double;border-width: 5px;border-color: #B2DBA1;">
	            		<h2 id="section-6">宣传部</h2>
	            		<div id="div宣传部"></div>
	            	</div>
	            	<hr>
	            	<div style="border-bottom-style: double;border-width: 5px;border-color: #B2DBA1;">
	            		<h2 id="section-7">后勤部</h2>
	            		<div id="div后勤部"></div>
	            	</div>
	            	<hr>
	            
	            </div>
    		</div>
		</div>
		
		
		<!--
          	作者：offline
           	时间：2019-06-25
           	描述：模态框--添加员工
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
							添加员工
						</h4>
					</div>
					<div class="modal-body" style="padding: 10px 120px ;  ">
						<div style="border: double #C1E2B3 5px; background-color: #EAF2D3;">
							<form action="AddEmployee" id="page_add_stuff" method="get">
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
											<input type="text" placeholder="请输入编号" name="id">
											</input>
										</div>																				
									</li>
									<li  class="myLi_modal">
										<div>
											<span>姓名:&nbsp;</span>										
											<input type="text" placeholder="请输入姓名" name="name">
											</input>
										</div>																				
									</li>
									<li  class="myLi_modal">
										<div>
											<span>号码:&nbsp;</span>										
											<input type="text" placeholder="请输入电话号码" name="phone">
											</input>
										</div>																				
									</li>
									<li class="myLi_modal">
										<div>
											<span>性别:&nbsp;</span>										
											<select class="form-control" name="sex" style="width: 70px; display: inline;">
												<option>男</option>
												<option>女</option>
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
           	描述：模态框--修改员工资料
        -->
		<div class="modal fade" id="myModal_edit" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
						&times;
						</button>
						<h4 class="modal-title" id="myModal_headTitle">
							修改员工资料
						</h4>
					</div>
					<div class="modal-body" style="padding: 10px 120px ;  ">
						<div style="border: double #C1E2B3 5px; background-color: #EAF2D3;">
							<form action="UpdateEmployee" method = "post" id="page_edit_stuff">
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
											<input type="text" placeholder="请输入编号" id="model_input_id" name="id"/>
											
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
											<span>号码:&nbsp;</span>										
											<input type="text" placeholder="请输入电话号码" name="phone"/>
											
										</div>																				
									</li>
									<li class="myLi_modal">
										<div>
											<span>性别:&nbsp;</span>										
											<select class="form-control" name="sex" style="width: 70px; display: inline;">
												<option>男</option>
												<option>女</option>
											</select>
										</div>
										
									</li>
									<li  class="myLi_modal">
										<div>
											<span>入职时间:&nbsp;</span>										
											<input type="text"  name="time" disabled="disabled"/>
											
										</div>																				
									</li>
								</ul>
								<input type="hidden" name="oldId" value="">
							</form>
						</div>
						
					</div>
					<div class="modal-footer">
						
						<button type="button" id="modal_button_edit" class="btn btn-primary btn-lg" onclick="changeToEditable()">
							编辑
						</button>
						<button type="button" id="modal_button_delete" class="btn btn-danger btn-lg" data-dismiss="modal" onclick="del()">
							删除
						</button>
						<button type="button" id="modal_button_ensure" class="btn btn-primary btn-lg" data-dismiss="modal" onclick="update()" style="display: none;">
							确认修改
						</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
			
			
	
	</body>
	
	<script type="text/javascript">
		
    	var tbl = new Array();
    	
		$(document).ready(function display(){			
			$.ajax({
				type:"GET",
				url:"Query",
				data:"method=employee&way=all",
				dataType: "text",
				success : function(data) {	
					if(data=="未登录"){
						window.location.href="login.jsp";
					}
					//alert(data);
                    $.each($.parseJSON(data), function(i, list) {        
                    	//len=len+1;
                    	var t = new Array();
                    	t.push(list.department);
                    	t.push(list.id);
                    	t.push(list.name);
                    	t.push(list.phone);
                    	t.push(list.sex);
                    	t.push(list.time);
                    	tbl.push(t);                   	
                    })
                    
                    //alert("jintian");
                    displayPage();
                },
		        error: function(){
		        	window.alert("失败");
		        }
			});
			 
        });
        
        function displayPage(){
        	getObject("div人力资源部").innerHTML='';
            getObject("div财务部").innerHTML='';
            getObject("div生产技术部").innerHTML='';
            getObject("div计划营销部").innerHTML='';
            getObject("div安全监察部").innerHTML='';
            getObject("div宣传部").innerHTML='';
            getObject("div后勤部").innerHTML='';
        	
            generateTable();
            
            getObject("div人力资源部").innerHTML+='<div class="clearfix"></div>';
            getObject("div财务部").innerHTML+='<div class="clearfix"></div>';
            getObject("div生产技术部").innerHTML+='<div class="clearfix"></div>';
            getObject("div计划营销部").innerHTML+='<div class="clearfix"></div>';
            getObject("div安全监察部").innerHTML+='<div class="clearfix"></div>';
            getObject("div宣传部").innerHTML+='<div class="clearfix"></div>';
            getObject("div后勤部").innerHTML+='<div class="clearfix"></div>';
           
        }          
        
        function generateTable(){
        	
			for(var i=0;i<tbl.length;i++){
				
				getObject("div"+tbl[i][0]).innerHTML+=
					'<div class="responsive" onclick="edit_stuff(this)" data-toggle="modal" data-target="#myModal_edit">'+
					'<div class="my_img"><a target="_blank" ><img src="img/'+tbl[i][4]+'.jpg" alt="'+tbl[i][4]+'"></a>'+
			    	'<div class="desc"><span>'+tbl[i][1]+'</span>&nbsp;'+tbl[i][2]+'</div></div>'+
					'<div hidden="hidden">'+
					'<input value="'+tbl[i][0]+'" />'+
					'<input value="'+tbl[i][1]+'" />'+
					'<input value="'+tbl[i][2]+'" />'+
					'<input value="'+tbl[i][3]+'" />'+
					'<input value="'+tbl[i][4]+'" />'+
					'<input value="'+tbl[i][5]+'" /></div></div>';
				
			}
        }
        
      
        
        function update(){
        	
        	$.ajax({
    			type:"GET",
    			url:"UpdateEmployee",
    			data:$("#page_edit_stuff").serializeArray(),
    			dataType: "text",
    	        success: function(data){
    	        	if(data=="未登录"){
    					window.location.href="login.jsp";
    				}
    	        	window.alert($.parseJSON(data).backNews);
    	        	if($.parseJSON(data).backNews=="修改员工数据成功"){
    	        		for(var i=0;i<tbl.length;i++){
    	        			//判断是否相等
    	        			if($.parseJSON($.parseJSON(data).oldId==tbl[i][1])){
    	        				tbl[i][0] = $.parseJSON(data).department;
    	                    	tbl[i][1] = $.parseJSON(data).id;
    	                    	tbl[i][2] = $.parseJSON(data).name;
    	                    	tbl[i][3] = $.parseJSON(data).phone;
    	                    	tbl[i][4] = $.parseJSON(data).sex;
    	        			}
    	        		}
    	        		//去掉弹窗
    	        		//刷新页面
    	        		
   	        			$("#modal_button_ensure").css("display","none");
   	        			$("#modal_button_edit").show();
   	        			$("#modal_button_delete").show();
   	        			$("#myModal_headTitle").text("员工信息");
   	        		
    	        		displayPage();
    	        		
    	        	}
    	        },
    	        error: function(){
    	        	window.alert("查询失败");
    	        }
    		});
        }
        
        function add(){
        	
        	$.ajax({
    			type:"GET",
    			url:"AddEmployee",
    			data:$("#page_add_stuff").serializeArray(),
    			dataType: "text",
    	        success: function(data){
    	        	if(data=="未登录"){
    					window.location.href="login.jsp";
    				}
    	        	window.alert($.parseJSON(data).backNews);
    	        	if($.parseJSON(data).backNews=="添加成功"){
    	        		
    	        		var t = new Array();
                    	t.push($.parseJSON(data).department);
                    	t.push($.parseJSON(data).id);
                    	t.push($.parseJSON(data).name);
                    	t.push($.parseJSON(data).phone);
                    	t.push($.parseJSON(data).sex);
                    	t.push($.parseJSON(data).time);
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
        
        
        function del(){
        	id = document.getElementById("model_input_id").value;
        	
        	$.ajax({
    			type:"GET",
    			url:"DeleteEmployee",
    			data:"id="+id,
    			dataType: "text",
    	        success: function(data){
    	        	if(data=="未登录"){
    					window.location.href="login.jsp";
    				}
    	        	//刷新页面
    	        	tbl = tbl.filter(function(item) {
					     return item[1] != id
					});
    	        	
    	        	displayPage();
    	        	
    	        },
    	        error: function(){
    	            
    	        }
    		});
        }
        
	
		
		function getObject(str){
			return document.getElementById(str);
		}
		

		function edit_stuff(obj){
	
			var inp = obj.getElementsByTagName("input");
			var inp_target_input=document.getElementById("myModal_edit").getElementsByTagName("input");
			var inp_target_selector=document.getElementById("myModal_edit").getElementsByTagName("select");
	    	
	    	/*input:编号赋值*/
	    	inp_target_input[0].value=inp[1].value;
	    	/*input:姓名赋值*/
	    	inp_target_input[1].value=inp[2].value;
	    	/*input:号码赋值*/
	    	inp_target_input[2].value=inp[3].value;
	    	/*input:入职时间赋值*/
	    	inp_target_input[3].value=inp[5].value;
	    	/*old id赋值*/
	    	inp_target_input[4].value=inp[1].value;
	    	      	
	    	/*select:部门赋值*/
	    	var selector_options_depart0=inp_target_selector[0].options;
			for(var i=0;i<selector_options_depart0.length;i++){
				if(selector_options_depart0[i].innerHTML==inp[0].value){
					selector_options_depart0[i].selected=true;
					break;
				}
			}
			
			/*select:性别赋值*/
	    	var selector_options_depart1=inp_target_selector[1].options;
			for(var i=0;i<selector_options_depart1.length;i++){
				if(selector_options_depart1[i].innerHTML==inp[4].value){
					selector_options_depart1[i].selected=true;
					break;
				}
			}
		}
		
		function changeToEditable(){
			$("#modal_button_edit").css("display","none");
			$("#modal_button_delete").css("display","none");
			$("#modal_button_ensure").show();
			$("#myModal_headTitle").text("请编辑员工信息");
		}
		
		

	</script>
		
	



</html>