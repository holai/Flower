<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <%@ page import="java.util.*,java.sql.*"%>
<!--  使用 数据库连接 工具类 -->
<%@ page import="flower.Mysqluse" %>
<jsp:useBean id="user" scope="session" class="flower.userBean"/>
<!DOCTYPE html>
<html>
<head>
  <!-- Basic -->

  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <base href="<%=basePath%>">
  <title>我的收藏</title>
  <!-- bootstrap core css --> 
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Dosis:400,600,700|Poppins:400,600,700&display=swap" rel="stylesheet" />
   <!-- Custom styles for this template -->
   <link href="css/style.css" rel="stylesheet" />
  <style type="text/css">
	
	.content{
		/* height: 500px; */
		max-width: 1240px;
		margin: 10px auto;
		background-color: rgba(255,255,255,0.4);
		padding: 20px 40px;
	    min-height: calc(100vh - 86px);
	}
	
	.box{
		display:flex;
	}
	.box img{
		width: 200px;
    	height: 170px;
	}
	.box .txt{
		flex:1;
		padding:10px 20px;
	}
	.box .btn{
	display: flex;
	align-items: center;
	}
	.btn .btn-group{
	}

  </style>
</head>

<body>


	  <jsp:include page="nav.jsp" />
	  <div class="content">
	 	 <div class="container">
	 	 		<%
	 	 			if(user.getName() == null){
	 	 				/*out.println("<script>alert('您还没有登陆！ 不能使用此功能')</script>");  */
	 	 				response.sendRedirect("login.jsp"); // 跳转到登陆界面
	 	 			}else{
			 	 			//使用 mysql连接类 
 	 		       		Mysqluse mysqluse = new Mysqluse();
	 	 		       	if(mysqluse.getCode() == 0){
	 	 		       		try{
	 	 		       			//连接成功
				 	 				String sql="SELECT * FROM colletc WHERE userId=?;";  //获取查询用户 收藏列表
					  				PreparedStatement statement = mysqluse.initperpare(sql); 
					  				statement.setInt(1,user.getID());//传入参数
									ResultSet res = statement.executeQuery();
					  				while(res.next()){
					  					//拿到 花的id 获取 花的信息 展示
					  					String sqlFlower="SELECT * FROM flowers WHERE id = ?;";  //获取查询花卉信息
						  				PreparedStatement statementFlower = mysqluse.initperpare(sqlFlower); 
						  				statementFlower.setInt(1,res.getInt("flowerId"));//传入参数
										ResultSet resFlower = statementFlower.executeQuery();
										while(resFlower.next()){
											
											out.println("<div class=\"card\"><div class=\"card-body box\"><img src=\""+resFlower.getString("pic") +"\"> <div class=\"txt\"><h3>"+resFlower.getString("name") +"</h3><div>简介："+resFlower.getString("intro") +"</div></div> <div class=\"btn\"><div class=\"btn-group\"><a target=\"view_window\" href=\""+resFlower.getString("href")+"\"> <button type=\"button\" class=\"btn btn-info\">购买</button></a><button type=\"button\" class=\"btn btn-danger delete\" flowerid=\""+res.getInt("flowerId")+"\" >删除</button></div></div></div> </div>");
						  					
										}
										resFlower.close();
										statementFlower.close();
					  				}
					  				res.close();
				    				statement.close();
						  				
				    				mysqluse.close();
			       			}catch(Exception e){
				 		       			
	       					}
			       		}	
				 	 		
		 			}
	 	 					
	 	 		%>
	 	 		
<!-- 			  	  <div class="card">
				    <div class="card-body box">
				      <img src="images/long.jpeg">
				      <div class="txt">
				      	<h3>紫罗兰</h3>
				      	<div>简介：xxxxxxxxxxxxxx</div>
				      </div>
				      <div class="btn">
				      		 <div class="btn-group">
							   <a href="#"> <button type="button" class="btn btn-info">购买</button></a>
							    <button type="button" class="btn btn-danger">删除</button>
							  </div>
				      </div>
				    </div>
				  </div> -->
		 </div>
	  </div>
	  
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
	
	<script type="text/javascript">
	var basePath = "<%=basePath %>";
	//绑定 删除 事件
	$(".delete").on("click",function(){ 
		var _this = $(this);
		$.ajax({
			url:basePath+"/cooletc?id="+_this.attr("flowerid"),
			type:'delete',
			success:function(result){
				if(result){
					//请求成功
					_this.parents(".card").remove();
				}else{ 
					//请求失败
					alert("请求失败！");
				}
   			}
		})
	}); 
		
	</script>
</body>

</html>