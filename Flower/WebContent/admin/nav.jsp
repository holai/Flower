<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:useBean id="user" scope="session" class="flower.userBean"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>导航</title>
  <!-- bootstrap core css --> 
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
</head>
<body>
		<nav class="navbar navbar-expand-sm bg-secondary navbar-dark">
		<!--   <a class="navbar-brand" href="#">花卉后台管理</a> -->
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse" style="justify-content: center;" id="collapsibleNavbar">
		    <ul class="navbar-nav">
		      <li class="nav-item active" id="index">
		        <a class="nav-link" href="admin/index.jsp" >花卉管理</a>
		      </li> 
		       <li class="nav-item" id="user">
		        <a class="nav-link"  href="admin/user.jsp"  >用户管理</a>
		      </li> 
		      <li class="nav-item">
		        <a class="nav-link"  target="content" data-toggle="modal" data-target="#myModal">管理密码</a>
		      </li> 
		    </ul>
		  </div>  
		</nav>
		
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
 
      <!-- 模态框头部 -->
      <div class="modal-header">
        <h4 class="modal-title">修改密码</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
 
      <!-- 模态框主体 -->
      <div class="modal-body">
       		  <form>
			    <div class="form-group">
			      <label for="usr">原密码:</label>
			      <input type="text" class="form-control" id="usr">
			    </div>
			    <div class="form-group">
			      <label for="pwd">新密码:</label>
			      <input type="password" class="form-control" id="pwd">
			    </div>
			    <div class="form-group">
			      <label for="cpwd">重复密码:</label>
			      <input type="password" class="form-control" id="cpwd">
			    </div>
			  </form>
      </div>
 
      <!-- 模态框底部 -->
      <div class="modal-footer">
        <button type="button" id="updateAdmin" class="btn btn-info" data-dismiss="modal">修改</button>
      </div>
 
    </div>
  </div>
  </div>
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript">
    	var basePath = "<%=basePath %>";
    	
    	
		//获取当前地址   根据当前地址 改变 nav的active状态
		var href =location.href.split("/");
		var fileN = href[href.length-1].split(".")[0];
		$(".nav-item").removeClass("active");
		$("#"+fileN).addClass("active");

		
    	
    	$("#updateAdmin").click(function(){
    		var lod= $("#usr").val();
    		var newPassWord = $("#pwd").val();
    		var cnewPassWord = $("#cpwd").val();
    		if(newPassWord == cnewPassWord){
				$.ajax({
			     url:basePath+"/admin?oldPassWord="+lod+"&newPassWord="+newPassWord,
			     type:'PUT',
			     xhrFields: {withCredentials: true},
			     success:function(data){
					alert(data);
					location.href = location.href; //刷新
			     },
			     error:function(error){
			     	alert("更新密码失败");
			        console.log("更新密码失败")
			     }
				});
    		}else{
    			alert("两次输入的密码不一样");
    		}
    	});
    </script>
</body>
</html>