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
  <style type="text/css">
		
	.update{
		    display: block;
    /* width: 100%; */
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    /* border: 1px solid #ced4da; */
    border-radius: 0.25rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    display:flex;
        align-items: center;
	}
	.update input{
		margin-left: 10px;
		
	}
	label{
		color: #999;
		
	}
	.update a{
    	flex: 1;
	    text-align: right;
	    color: #007bff !important;
	    cursor: pointer;
        min-width: 90px;
	}
	#psH,#adrH{
		display:none;
	}
  </style>
  
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script>
	//动态加载css
	
	
	var href =location.href.split("/");
	var fileN = href[href.length-1].split(".")[0];
	//动态加载css
	if(fileN!="index"){
		$("<link>")
		.attr({ rel: "stylesheet",
		type: "text/css",
		href: "css/nav.css"
		})
		.appendTo("head");
	}
  </script>
</head>

<body>
	  <section class="nav_section">
	    <div class="container">
	      <div class="custom_nav2">
	        <nav class="navbar navbar-expand custom_nav-container " style="z-index: 0;">
	          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	            <span class="navbar-toggler-icon"></span>
	          </button>
	
	          <div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <div class="d-flex  flex-column flex-lg-row align-items-center">
	              <ul class="navbar-nav  ">
	                <li class="nav-item ">
	                  <a class="nav-link" href="index.jsp">首页 <span class="sr-only">(current)</span></a>
	                </li>
	                <li class="nav-item" id="colletc">
	                  <a class="nav-link" href="colletc.jsp">我的收藏 </a>
	                </li>
	                <li class="nav-item active" id="list">
	                  <a class="nav-link" href="list.jsp">热门推荐</a>
	                </li>
	                
              		 <%
	    	 			//如果已经登陆就显示用户管理   没登陆显示 登陆入口
	                	if(user.getName() == null){
		    	 			out.println(" <li class=\"nav-item\" id=\"login\"><a class=\"nav-link\" href=\"login.jsp\">登录</a></li>");
		    	 		}else{
		    	 			out.println("<li class=\"nav-item\" data-toggle=\"modal\" data-target=\"#myModal\" ><a class=\"nav-link\">用户信息管理</a></li>");
		    	 			
		    	 		}
	    	 		%> 
	               
	              </ul>
	              
	            </div>
	          </div>
	        </nav>
	      </div>
	    </div>
	  </section>
	  
	  
	    <!-- 模态框 -->
  <div class="modal fade" id="myModal">
    <div style="margin-top: 100px;" class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">修改用户信息</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
   
        <!-- 模态框主体 -->
        <div class="modal-body">
		      <label >用户名:</label>
		      <div class="update"> 
	      		<%= user.getName() %>
      		 </div>
		      <label>密码:</label>
		      <div id="ps" class="update">
		      	<span id="password" class="">********</span>
		      	<a id="passwordUpdate">修改密码</a>
		      </div>
		      <div id="psH" class="update">
		      	<input type="password" class="form-control ps" id="lod" placeholder="旧密码：">
		      	<input type="password" class="form-control ps" id="new" placeholder="新密码：">
		      	<input type="password" class="form-control ps" id="newRepeat" placeholder="重复输入密码：">
		      	<a id="passwordYes">确认修改</a>
		      </div>
		       <label>所在地:</label>
		      <div id="adr" class="update">
		      	<span id="address" class=""><%=user.getAddress() %> </span>
		      	
	      		<a id="addressUpdate">修改所在地</a>
	      	 </div>
	      	 <div id="adrH" class="update">
		      	<input type="text" class="form-control ps" id="addressNew" placeholder="地址：">
	      		<a id="addressYes">修改所在地</a>
	      	 </div>
        </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
  
  
<!-- <div class="container">
  <h3>修改密码</h3> <br><br><br><br><br><br>
  <div>
	<div class="form-group">
      <label for="lod">输入旧密码:</label>
      <input type="password" class="form-control" id="lod" placeholder="you lod password">
    </div>
    <div class="form-group">
      <label for="new">Password:</label>
      <input type="password" class="form-control" id="new" placeholder="you new password">
    </div>
    <div class="form-group">
      <label for="newRepeat">Repeat Password:</label>
      <input type="password" class="form-control" id="newRepeat" placeholder=" Repeat your password">
    </div>
    
   
  </div>
</div> -->

  
	<script type="text/javascript">

	
	
		//获取当前地址   根据当前地址 改变 nav的active状态
		var href =location.href.split("/");
		var fileN = href[href.length-1].split(".")[0];
		$(".nav-item").removeClass("active");
		$("#"+fileN).addClass("active");

		
		
		// 修改密码点击事件
		$("#passwordUpdate").click(function(){
			$("#ps").hide();
			$("#psH").css("display","flex");
		});
		
		
		//确认 修改密码 
		var lod = $("#lod");
		var newp = $("#new");
		var newRepeat =$("#newRepeat");
		$("#passwordYes").click(function(){
			var lodVal = lod.val();
			var newpVal = newp.val();
			var newRepeatVal = newRepeat.val();
			if(lodVal=="" || newpVal=="" || newRepeatVal==""){
				alert("请输入完整！");
			}else{
				if(newpVal != newRepeatVal){
					alert("两次输入的不正确！");
				}else{
					ajaxUser(true);
				}
			}
		});
		
		// 修改地址点击事件
		$("#addressUpdate").click(function(){
			$("#adr").hide();
			$("#adrH").css("display","flex");
		});
		
		
		//确认 修改地址 
		var addressNew =$("#addressNew");
		$("#addressYes").click(function(){
			var addressNewVal = addressNew.val();
			if(addressNewVal==""){
				alert("请输入数据！");
			}else{
				ajaxUser(false);
			}
		})
		
		
		var basePath = "<%=basePath %>";
		//ajax 请求修改 
		function ajaxUser(is){
			$.ajax({
				url:basePath+"/user",
				data:"is="+is+"&password="+newp.val()+"&address="+addressNew.val()+"&loadpassword="+lod.val(),
				type:'post',
				success:function(result){
					if(result){
						//请求成功
						if(is){
							alert("修改密码成功！");
						}else{
							$("#address").val(addressNew.val());
							alert("修改地址成功！");
						}
						$("#psH").hide();
						$("#ps").css("display","flex");
						$("#adrH").hide();
						$("#adr").css("display","flex");
						location.href="login.jsp";//重新登陆
					}else{ 
						//请求失败
						alert("修改失败！");
					}
	   			},
	   			error:function(){
	   			}
			})
			
		}
		
	</script>
</body>

</html>