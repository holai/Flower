<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  <%@ page import="java.util.*,java.sql.*"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>后台管理系统•登陆</title>
	<base href="<%=basePath%>">
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="后台" />
	</script><script src="js/jquery-3.4.1.min.js"></script>
	<style type="text/css">
			button{z-index:2;height:26px;width:100px;box-shadow:0 0 0 1px #2868c8;color:#fff;font-size:15px;letter-spacing:1px;background:#3385ff;border-bottom:1px solid #2d78f4;outline:medium;border:1px solid #2868c8}
			.el-input__inner {
			    -webkit-appearance: none;
			    background-color: #fff;
			    background-image: none;
			    border-radius: 4px;
			    border: 1px solid #dcdfe6;
			    box-sizing: border-box;
			    color: #606266;
			    display: inline-block;
			    font-size: inherit;
			    height: 40px;
			    line-height: 40px;
			    outline: none;
			    padding: 0 15px;
			    transition: border-color .2s cubic-bezier(.645,.045,.355,1);
			    width: 100%;
			}
			
			input {
			    cursor: pointer;
			}
			.el-input {
			    position: relative;
			    font-size: 13px;
			    display: inline-block;
			    width: 100%;
			        width: 180px;
			}

			.btn {
			    display: inline-block;
			    font-weight: 400;
			    color: #212529;
			    text-align: center;
			    vertical-align: middle;
			    -webkit-user-select: none;
			    -moz-user-select: none;
			    -ms-user-select: none;
			    user-select: none;
			    background-color: transparent;
			    border: 1px solid transparent;
			    padding: .375rem .75rem;
			    font-size: 1rem;
			    line-height: 1.5;
			    border-radius: .25rem;
			    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
			}
			[type=button], [type=reset], [type=submit], button {
			    -webkit-appearance: button;
			}
			button, select {
			    text-transform: none;
			}
			button, input {
			    overflow: visible;
			}
			[type=button]:not(:disabled), [type=reset]:not(:disabled), [type=submit]:not(:disabled), button:not(:disabled) {
			    cursor: pointer;
			}
			.btn-info {
			    color: #fff;
			    background-color: #17a2b8;
			    border-color: #17a2b8;
			}
			#canvas{
				position: absolute;
				height: 100%;
				width: 100%;
				top: 0;
				left: 0;
			}
			*{
				padding: 0;
				margin: 0;
			}
			body, html {
			    margin: 0;
			    padding: 0;
			    height: 100%;
			    font-family: Helvetica Neue,Helvetica,PingFang SC,Hiragino Sans GB,Microsoft YaHei,SimSun,sans-serif;
			    font-weight: 400;
			    -webkit-font-smoothing: antialiased;
			    -webkit-tap-highlight-color: transparent;
			    width:100%;
			    overflow:hidden;
			    font-family:rubik mono one,sans-serif;
			    background:#22292c;
			}
			.box{
				width: 100%;
				height: 100%;
				display: flex;
				align-items: center;
				justify-content: center;
				flex-direction: column;
			}
			.box .title{
				color: #FFF;
				padding-bottom: 20px;
				font-weight: 600;
				font-size: 16px;
				border: none ;
				cursor: none;
				outline: none;
			}
			.zh{
				width: 250px;
			}
			.mm{
				margin-top: 15px;
				width: 250px;
			}
			.btn{
				box-sizing: content-box;
				width: 100px;
				margin-top: 20px;
			}
		</style>
	</head>
	<body>
		<div class="box">
			<p class="title">花卉 后台管理系统</p>
			<div class="el-input zh">
				<input id="zh" type="text" placeholder="输入管理员账号: " class="el-input__inner" />
			</div>
			<div class="el-input mm">
				<input id="mm" type="password" placeholder="输入管理员密码: " class="el-input__inner" />
			</div>
			<button id="login" type="button" class="btn btn-info">登陆</button>
		</div>
		<script src="https://cdn.bootcss.com/jquery/3.3.0/jquery.min.js"></script>
		
		<script type="text/javascript">
			var BaseUrl = "<%=basePath %>";     //开发
			//绑定 Enter键 使密码框获得焦点
			$('#zh').bind('keypress', function(event) {
			    if (event.keyCode == "13") {
			    	$("#mm").focus();
			    }
			});
			//绑定 快捷键 登陆
			$('#mm').bind('keypress', function(event) {
			    if (event.keyCode == "13") {
			    	ajaxLogin();
			    }
			});
			
			//登陆 userName=admin&passWord=admin
			$("#login").click(function(){
				ajaxLogin();
			});
			
			//发送ajax 请求servlet 
			function ajaxLogin(){
				$.ajax({
				     url:BaseUrl+'/admin',  //请求地址
				     type:'post',
				     data:"name="+$("#zh").val()+"&password="+$("#mm").val(), //参数为账号和密码
				     success:function(data){
				     	if(data+"" == true+""){	//判断是否成功   成功则跳转到管理页
				     		location.href="admin/index.jsp";  
				     	}else{
				     		alert(data);
				     	}
				     },
				     error:function(error){
				     	alert("登陆出现错误");
				        console.log("登陆出现错误")
				     }
				});
				
			}
</script> 
		

	
<body>
</html>