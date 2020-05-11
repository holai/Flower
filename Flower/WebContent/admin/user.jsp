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
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <base href="<%=basePath%>">
  <title>后台管理•用户管理</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<style type="text/css">
	
	.content{
		/* height: 500px; */
		max-width: 1240px;
		margin: 10px auto;
		background-color: rgba(255,255,255,0.4);
		padding: 20px 40px;
	    min-height: calc(100vh - 133px);
	}
	
	.item{
		display:flex;
    margin-top: 20px;
    border: 1px solid #ddd;
    padding: 10px;
	}
	.name{
		flex: 1;
    line-height: 30px;
	}
  </style>
</head>

<body>
	 <jsp:include page="nav.jsp" />

		<div class="content">
		  			<!-- <div class="item">
		  				<div class="name">后来的路</div>
		  				<button type="button" class="delete btn btn-danger">删除</button>
		  			</div> -->
			  		 <%
			  		   
			  		 	Object isAdmin = request.getSession().getAttribute("adminUser");
			  		 	if(isAdmin == null){
			  		 		response.sendRedirect("login.jsp");
			  		 	}else{
			  		 	//使用 mysql连接类 
				        	Mysqluse mysqluse = new Mysqluse();
				        	if(mysqluse.getCode() == 0){
				        		try{

				        			String sql="SELECT * FROM user";
			        				PreparedStatement statement = mysqluse.initperpare(sql);
				     				ResultSet res = statement.executeQuery();
				     				while(res.next()){
				    					out.println("<div class=\"item\" ><div class=\"name\">"+res.getString("name")+"</div><button type=\"button\" class=\"delete btn btn-danger\" userId=\""+res.getString("id")+"\">删除</button></div>");
				     				}
				     				res.close();
				     				statement.close();
				     				mysqluse.close();
				        		}catch(Exception e){
				        			e.printStackTrace();
				        		}
			        		}else{
				        		out.println("<script>alert(\"服务器出现错误\")</script>");
				        	}
				        	
			  		 		
			  		 	}
			        	
			        %>

	  </div>


  

  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script>
  var basePath = "<%=basePath %>";
	$(".delete").click(function(){
		
		  if(window.confirm('你确定要删除此用户吗？')){
			  var _this = $(this);
			  var id= _this.attr("userId");
				$.ajax({
					url:basePath+"/admin?id="+id,
					type:'delete',
					success:function(result){
						if(result=="true"){
							//请求成功
							_this.parent().remove();
						}else{ 
							//请求失败
							alert(result);
						}
		   			}
				});
			  event.stopPropagation();
	          return true;
	       }
	});
  </script>
</body>

</html>