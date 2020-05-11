<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <%@ page import="java.util.*,java.sql.*"%>
<!--  使用 数据库连接 工具类 -->
<%@ page import="flower.Mysqluse" %>
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
  <title>推荐列表</title>
  <!-- bootstrap core css --> 
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Dosis:400,600,700|Poppins:400,600,700&display=swap" rel="stylesheet" />
   <!-- Custom styles for this template -->
   <link href="css/style.css" rel="stylesheet" />
  <style type="text/css">
	  .bg{
		    background: url(images/flowbg.jpg) no-repeat;
		    background-size: cover;
		    background-position: bottom center;
		    background-attachment: fixed;
		    overflow: hidden;
		    /* min-height: 400px; */
		    /* position: fixed; */
			height: 100%;
			width: 100%;
	  }
	
	
	.content{
		/* height: 500px; */
		max-width: 1240px;
		margin: 10px auto;
		background-color: rgba(255,255,255,0.4);
		padding: 20px 40px;
	    min-height: calc(100vh - 86px);
        display: flex;
    	flex-direction: column;
	}
	.box{
		margin-top: 20px;
		position: relative;
		border-radius: 5px;
		overflow: hidden;
	}
	.box .type{
		position: absolute;
		top: 5px;
		left: 5px;
	}
	.img-box{
		/* border-radius: 5px;
		border-r */
		overflow: hidden;
	}
	.box img{
		width: 100%;
		height: 200px;
	}
	.box:hover img{
		transform: scale(1.1,1.1);
	}
	.box:hover .txt{
		color:#232;
	}
	.box .txt{
		color:#000;
		background-color: rgba(255,255,255,0.6);
		padding: 5px;
		border-radius: 5px;
		border-top-left-radius: 0px;
		border-top-right-radius: 0px;
		 /* border-radius: 5px; */
	}
	.box .title{
		font-size: 20px;
		padding-left: 5px;
	}
	.box .text{
		width: 100%;
	    word-wrap: break-word;
	    /* height: 3em; */
	    overflow: hidden;
	    word-break: break-all;
	    text-overflow: ellipsis;
	    /* width: 20em; */
	    line-height: 1.5em;
	    overflow: hidden;
	    white-space:nowrap;
	    display: -webkit-box;
	    -webkit-line-clamp: 1;
	    -webkit-box-orient: vertical;
	    
	}
	.page{
		align-content: center;
		    justify-content: center;
		    margin-top: 20px;
	}
  </style>
</head>

<body>
	<jsp:include page="nav.jsp" />
	 
	  <div class="bg">
		<div class="content">
			  <div style="flex: 1;" class="row">
			  		 <%
			  		 	double size = 12; //每页加载数量
			  		 	int pageVal=1;  //当前页
			  		 	int count=0;    //总数量
			        	//使用 mysql连接类 
			        	Mysqluse mysqluse = new Mysqluse();
			        	if(mysqluse.getCode() == 0){
			        		try{
			        			
			        			
			        			//连接成功
			        			if(request.getParameter("page")==null){
			        				pageVal = 1;
			        			}else{
			        				pageVal =Integer.parseInt(request.getParameter("page"));
			        			}
			        			String sql="SELECT flowers.* FROM flowers LEFT JOIN grade on flowers.id = grade.flowerId GROUP BY flowers.id,flowers.address ORDER BY sum(grade.value) DESC LIMIT ?,?";
		        				PreparedStatement statement = mysqluse.initperpare(sql);
		        				statement.setInt(1, (pageVal-1)*12);
		        				statement.setInt(2, pageVal*12);
			     				ResultSet res = statement.executeQuery();
			     				while(res.next()){
			    					out.println("<div class=\"col-6 col-sm-4 col-md-3\"><a href=\"detail.jsp?id="+res.getString("id")+"\"><div class=\"box\"><span class=\"type badge badge-info\" >"+res.getString("type")+"</span><div class=\"img-box\"><img src=\""+res.getString("pic")+"\" ></div><div class=\"txt\"><div class=\"title\">"+res.getString("name")+"</div><div class=\"text\">"+res.getString("intro")+"</div></div></div></a></div>");
			     					
			     				}
			     				res.close();
			     				statement.close();
			     				
			     				//获取总数量
			     				String sqlA="SELECT COUNT(*) as count FROM flowers";
		        				PreparedStatement statementA = mysqluse.initperpare(sqlA);
			     				ResultSet resA = statementA.executeQuery();
			     				resA.next();
			    				count = resA.getInt("count");
			     				resA.close();
			     				statementA.close();
			     				
			     				
			     				mysqluse.close();
			        		}catch(Exception e){
			        			e.printStackTrace();
			        		}
		        		}else{
			        		out.println("<script>alert(\"服务器出现错误\")</script>");
			        	}
			        %>
					
					<!-- <div class="col-6 col-sm-4 col-md-3">
						<div class="box">
							<span class="type badge badge-info" >某某科目</span>
							<div class="img-box">
								<img src="http://localhost/Flower/images/long.jpeg" alt="">
							</div>
							<div class="txt">
								<div class="title">牡丹花</div>
								<div class="text">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</div>
							</div>
						</div>
					</div> -->

			  </div>
			  
				<!-- 分页 -->			  
			  	<% int pageCount = (int)Math.ceil(count/size); //计算总页数   %>
			   <ul class="pagination page"  style="display:<%= pageCount==1 ? "none" : "flex"  %>">
			      <li class="page-item <%= pageVal==1 ? "disabled" :  "" %> "><a class="page-link" href="<%= pageVal==1 ? "#" :  "list.jsp?page="+(pageVal-1) %>">上一页</a></li>
			      
			      <% 
			      	for(int i =1;i<=pageCount;i++){
			      		if(i==pageVal){
			      			out.println("<li class=\"page-item active\"><a class=\"page-link\" href=\"list.jsp?page="+i+"\">"+i+"</a></li>");
			      		}else{
			      			out.println("<li class=\"page-item \"><a class=\"page-link\" href=\"list.jsp?page="+i+"\">"+i+"</a></li>");
			      		}
			      	}	
			      
		      	   %>
			<%--       <li class="page-item active"><a class="page-link" href="#"><%= pageVal %></a></li>
			      <li class="page-item "><a class="page-link" href="#">2</a></li>
			      <li class="page-item"><a class="page-link" href="#">3</a></li>
			       --%>
			      
			      <li class="page-item <%= pageVal==pageCount ? "disabled" :  "" %>"><a class="page-link" href="<%= pageVal==count ? "#" :  "list.jsp?page="+(pageVal+1) %>">下一页</a></li>
			    </ul>
		</div>
	  </div>
	  
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>

</body>

</html>