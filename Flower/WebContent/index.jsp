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
  <title>首页</title>

  <!-- slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="css/owl.carousel.min.css" />

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Dosis:400,600,700|Poppins:400,600,700&display=swap" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />
</head>

<body>
  <div class="hero_area">
    <!-- header section strats -->
    <div class="brand_box">
      <a class="navbar-brand" href="index.html">
        <span>
          欢迎
        </span>
      </a>
        <div>
    		<%
    		  String name  =user.getName();
    	 		if(name == null){
    	 			//没有登陆
    	 			out.println("<a class=\"navbar-brand\" href=\"login.jsp\">嘿！ 您还没有登陆，快登录加入我们吧！</a>");
    	 			
    	 		}else{
    	 			//已经登陆
    	 			out.println("欢迎回来："+name);
    	 		}
    	 	%>
    	</div>
    </div>
  
    <!-- end header section -->
    <!-- slider section -->
    <section class=" slider_section position-relative">
      <div id="carouselExampleControls" class="carousel slide " data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="img-box">
              <img src="images/2.jpg" alt="">
            </div>
          </div>
          <div class="carousel-item">
            <div class="img-box">
              <img src="images/3.jpg" alt="">
            </div>
          </div>
          <div class="carousel-item">
            <div class="img-box">
              <img src="images/4.jpg" alt="">
            </div>
          </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
          <span class="sr-only">Next</span>
        </a>
      </div>
    </section>
    <!-- end slider section -->
  </div>
  
  
  <!-- 引入 导航栏  -->
 <jsp:include page="nav.jsp" /> 
 
 
  <%-- <!-- nav section -->
  <section class="nav_section">
    <div class="container">
      <div class="custom_nav2">
        <nav class="navbar navbar-expand custom_nav-container ">
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <div class="d-flex  flex-column flex-lg-row align-items-center">
              <ul class="navbar-nav  ">
                <li class="nav-item active">
                  <a class="nav-link" href="index.jsp">首页 <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="colletc.jsp">我的收藏 </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="list.jsp">个性化推荐</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="testimonial.jsp">用户信息管理</a>
                </li>
               
                  
                
                
                <%
	    	 		//如果已经登陆 就隐藏 登陆
                	if(name == null){
	    	 			out.println(" <li class=\"nav-item\" id=\"login\"><a class=\"nav-link\" href=\"login.jsp\">登录</a></li>");
	    	 		}
    	 		%>
               
              </ul>
              
            </div>
          </div>
        </nav>
      </div>
    </div>
  </section>
 --%>

  <section class="fruit_section layout_padding">
    <div class="container">
      <div class="heading_container">
        <hr>
        <h2>
        
          希望喜欢
        </h2>
      </div>
    </div>
    <div class=second_c_border1 id="recommend">

    <div class="container-fluid">

      <div class="fruit_container">
        
        
        
        <%
        	//使用 mysql连接类 
        	Mysqluse mysqluse = new Mysqluse();
        	if(mysqluse.getCode() == 0){
        		try{
        			//连接成功
        			//判断是否能获取 用户地址 能则根据花适宜地址匹配 不能则推荐 评分最高的
        			//能则 根据 地址 推荐展示 ，如果相同地址不够则以评分最高的填
        			String sql ="";
        			PreparedStatement statement;
        			if(user.getAddress() == null){
        				 sql="SELECT flowers.* FROM flowers LEFT JOIN grade on flowers.id = grade.flowerId GROUP BY flowers.id,flowers.address ORDER BY sum(grade.value) DESC LIMIT 6";
                  		 statement = mysqluse.initperpare(sql);
        			}else{
        				//	
        				 sql = "SELECT flowers.* FROM flowers LEFT JOIN grade on flowers.id = grade.flowerId  GROUP BY flowers.id,flowers.address ORDER BY FIND_IN_SET(?,address) DESC,sum(grade.value) DESC LIMIT 6";
        				 statement= mysqluse.initperpare(sql);
     				  	 statement.setString(1, user.getAddress());
        			}
     				ResultSet res = statement.executeQuery();
     				while(res.next()){
    					out.println("<div class=\"box\"><img src=\""+res.getString("pic")+"\"><div class=\"link_box\"><h5>"+res.getString("name")+"</h5><a href=\"detail.jsp?id="+res.getInt("id")+"\">详情</a></div></div>");
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
        %>
<!--         <div class="box">
          <img src="images/long.jpeg" alt="">
          <div class="link_box">
            <h5>
             龙沙宝石
            </h5>
            <a href="">
              详情
            </a>
          </div>
        </div>
        
        
        <div class="box">
          <img src="images/zu.jpg" alt="">
          <div class="link_box">
            <h5>
              朱顶红
            </h5>
            <a href="">
              详情
            </a>
          </div>
        </div>
        <div class="box">
          <img src="images/lvluo.jpeg" alt="">
          <div class="link_box">
            <h5>
             绿萝
            </h5>
            <a href="">
            详情
            </a>
          </div>
        </div>
        <div class="box">
          <img src="images/dayx.jpg" alt="">
          <div class="link_box">
            <h5>
              大游行
            </h5>
            <a href="">
              详情
            </a>
          </div>
        </div>
        <div class="box">
          <img src="images/lanxh.jpeg" alt="">
          <div class="link_box">
            <h5>
              蓝雪花<br>
             
            </h5>
            <a href="">
              详情
            </a>
          </div>
        </div> -->
        
        
      </div>
    </div>
    </div>
  </section>

  

  <!-- end info section -->


  <!-- footer section -->
  
  <!-- footer section -->

  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script type="text/javascript" src="js/custom.js"></script>

</body>

</html>