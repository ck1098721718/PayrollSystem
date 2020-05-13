<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,mybean.Formula"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="myCSS/myformula.css" />
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script type="text/javascript" src="js/jquery-3.4.1.min.js" ></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
	<div class="formula_head">
		<button class="btn btn-info" onclick="window.location.href='salaryProject.jsp'">					
         		<span class="glyphicon glyphicon-circle-arrow-left" ></span>
		</button>	
	</div>
	<div>
		<button class="btn btn-primary btn-lg" onclick="save()" style="float: right; margin-right: 5%; margin-top: 30px;">					
         		<span class="glyphicon glyphicon-saved"></span> 保存
		</button>	
				
	</div>
	
	<div style="margin: 10px 15%;">
		
		<div class="main_content">
			<form>
			<input type="hidden" name="method" value="set2">
			<input type="hidden" id="size" name="size" value="">
			<table class="table table-hover" id="my_formula_table">
 					<tbody>
   					
 					</tbody>
			</table>
			</form>
		</div>
					
	</div>	
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog">
       		<div class="modal-content">
           		<div class="modal-header">
               		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
               		<h6 class="modal-title" id="myModalLabel">计算工资设置</h4>
           		</div>
           	<div class="modal-body" style="text-align: center;">
           		<h2 style="color: #245269;">修改成功！</h3>
           	</div>
           		<div class="modal-footer">
               		<button type="button" class="btn btn-default" data-dismiss="modal">继续修改</button>
               		<button type="button" class="btn btn-primary"><a href="salaryProject.jsp" style="text-decoration: none;color: white;">返回</a></button>
           		</div>
       		</div><!-- /.modal-content -->
   		</div><!-- /.modal -->
	</div>
		
</body>

<script>
	
	$(document).ready(function display(){
		$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:"method=set1",
			dataType: "text",
			success : function(data) {
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				var fixed;
				var len = 0;
				$('tbody').empty();
                $.each($.parseJSON(data), function(i, list) {   
					  len++;
                	  if(i==0){
                		  fixed= list.fixed;
                	  }  
                	  $('tbody').append('<tr id='+i+'>');
                	  if(i<5){
                		  $('#'+i).append('<td><input name="name'+i+'" class="formula_input1" readonly="readonly" value="'+list.name+'"/></td>');
                		  $('#'+i).append('<td><input class="formula_equality" readonly="readonly" value="="/></td>');
                		  $('#'+i).append('<td><input name="firstData'+i+'" class="formula_input1" readonly="readonly" value="'+list.firstData+'"/></td>');
                		  $('#'+i).append('<td><select id="symbol'+i+'" name="symbol'+i+'" class="s2"><option>+</option><option>-</option><option>*</option><option>/</option></select></td>');
                		  $('#'+i).append('<td><input name="secondData'+i+'" class="formula_input2" value="'+list.secondData+'"/></td>');
                		  $("#symbol"+i).val(list.symbol);
                	  }
                	  else{
                		  $('#'+i).append('<td><input name="name'+i+'" class="formula_input1" readonly="readonly" value="'+list.name+'"/></td>');
                		  $('#'+i).append('<td><input class="formula_equality" readonly="readonly" value="="/></td>');
                		  $('#'+i).append('<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id="firstData'+i+'" name="firstData'+i+'" class="s1"></select></td>');
                		  $('#'+i).append('<td><select id="symbol'+i+'" name="symbol'+i+'" class="s2"><option>+</option><option>-</option><option>*</option><option>/</option></select></td>');
                		  $('#'+i).append('<td><input name="secondData'+i+'" class="formula_input2" value="'+list.secondData+'"/></td>');
                		  for(var j=0;j<fixed.length;j++){
                			  $("#firstData"+i).append('<option>'+fixed[j]+'</option>');
                		  }
                		  $("#firstData"+i).val(list.firstData);
                		  $("#symbol"+i).val(list.symbol);
                	  }
                })
                $("#size").val(len);
            },
	        error: function(){
	        	window.alert("失败");
	        }
		});
	});
	
	
	
	function save(){
		
		$.ajax({
			type:"GET",
			url:"SalaryProjectManage",
			data:$('form').serializeArray(),
			dataType: "text",
			success : function(data) {	
				if(data=="未登录"){
					window.location.href="login.jsp";
				}
				//window.alert("成功");
	            //displayPage(data);
	            //alert(key);
	            if(data=="保存成功")	$('#myModal').modal('show');
	            else	alert(data);
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		}); 
		
		
		
	}
	
</script>

</html>