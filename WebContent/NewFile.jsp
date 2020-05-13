<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.InputStream"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-3.4.1.min.js" ></script>
</head>
<body>

<form id="form1" action="FileServlet" enctype="multipart/form-data" method="post">

选择文件<input type="file" name="file1" id="file1"><br>
<input type="text" name="name" id="name" value="45"><br>
<input type="button" onclick="update()" name="upload" value="上传">
<br>
<img src="" id="img">
</form>
</body>

<script type="text/javascript">
	function update(){
		var formdata = new FormData($("#form1")[0]);
		$.ajax({
			type:"post",
			url:"FileServlet",
			data:formdata,
			dataType: "text",
			contentType: false,
			processData: false,
			success : function(data) {	
				alert($.parseJSON(data).test);
				alert('data:image/png;base64,'+$.parseJSON(data).image);
				document.getElementById('img').src='data:image/png;base64,'+$.parseJSON(data).image;
	        },
	        error: function(){
	        	window.alert("失败");
	        }
		});
		
	}

</script>
</html>