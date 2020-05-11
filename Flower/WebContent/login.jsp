<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  <%@ page import="java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
	<title>登录和注册</title>
	<link rel="stylesheet" href="css/style1.css">
	<!-- 
	<link href="css/popup-box.css" rel="stylesheet" type="text/css" media="all" />
	 -->
<link href="https://cdn.bootcss.com/magnific-popup.js/1.1.0/magnific-popup.min.css" rel="stylesheet">
	<link href="css/popup-box.css" rel="stylesheet" type="text/css" media="all" />
	<!--<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300italic,300,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
	<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
-->
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="Sign In And Sign Up Forms  Widget Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
		<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

</script><script src="js/jquery-3.4.1.min.js"></script>
<!-- 
<script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
 -->
<script src="https://cdn.bootcss.com/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script> 
 <script>
		$(document).ready(function() {
		$('.popup-with-zoom-anim').magnificPopup({
			type: 'inline',
			fixedContentPos: false,
			fixedBgPos: true,
			overflowY: 'auto',
			closeBtnInside: true,
			preloader: false,
			midClick: true,
			removalDelay: 300,
			mainClass: 'my-mfp-zoom-in'
		});
																		
		});
</script>	
		<style>
			.mfp-container{
				text-align: center;
			}
			.mfp-content{
			    display: inline-block;
   				width: 50% !important;
				text-align: center;
			}
			.select{
				width: 97.5%;
			    padding: 15px;
			    border: 1px solid #7d7d7d;
			    outline: none;
			    font-size: 14px;
			    margin-bottom: 20px;
			    border-radius: 25px;
    		}
    		input[type="number"]{
			    width: 93.5%;
			    padding: 15px;
			    border: 1px solid #7d7d7d;
			    outline: none;
			    font-size: 14px;
			    margin-bottom: 20px;
			    border-radius: 25px;
			}
		</style>
</head>
<body>
	<h1>花卉种植 用户登陆</h1>
	<div class="w3layouts">
		<div class="signin-agile">
			<h2>登录</h2>
			<form   method="post" name="login">
				<input type="text" name="name" class="name" placeholder="用户名" >
				<input type="password" name="password" class="password" placeholder="密码" >
				<input type="hidden" name="type" value="1"> 
				<div class="clear"></div>
				<input type="submit" value="登录">
			</form>
		</div>
		<div class="signup-agileinfo">
			<h3>介绍</h3>
			<p>花字在商代甲骨文中作（即华），表现了盛开的花形和枝叶葱茂之状。卉，汉代许慎《说文解字》称:“卉,草之总名也。” 花、卉两字联用,则出现较晚。南北朝时《梁书·何点传》载：“园中有卞忠贞冡，点植花卉于冡侧。” 这是花、卉二字联用的较早记录</p>
			<div class="more">
				<a class="book popup-with-zoom-anim button-isi zoomIn animated" data-wow-delay=".5s" href="#small-dialog">点击注册</a>				
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="footer-w3l">
		
 </p>
	</div>
	<div class="pop-up"> 
	<div id="small-dialog" class="mfp-hide book-form">
		<h3>欢迎注册 </h3>
			<form  method="post" name="register">
				<input type="text" name="name" placeholder="用户名" />
				<input type="password" name="password" class="password" placeholder="密码" />
				<!--  
				<input type="text" name="sex" class="Name" placeholder="性别" required=""/>
				--> 
				<select name="sex" class="select">
					<option  value="0">女</option>
				
					<option value="1">男</option>
					
					<option  value="2">保密</option>
				</select>
				<input type="number" name="age" class="Name" placeholder="年龄" />
				<input type="text" name="address" class="Name" placeholder="省份" />
				<input type="hidden" name="type" value="2"> 
				<input style="width:50%" type="submit" value="点击注册">
			</form>
	</div>
</div>	
<!-- 使用JavaBean报错用户数据 -->
<jsp:useBean id="user" scope="session" class="flower.userBean"/>
<!--  使用 数据库连接 工具类 -->
<%@ page import="flower.Mysqluse" %>
<% 
	if(user.getName() != null){
		//已经登陆
		response.sendRedirect("index.jsp");
	}
	 Mysqluse mysqluse;
	if(request.getParameter("type") != null){  //如果类型参数不为null则开始连接 
	    try{
	        mysqluse = new Mysqluse();
	        if(mysqluse.getCode() == 0){
	        	int type =Integer.parseInt(request.getParameter("type"));
	        	if(type==1){	//登陆
		        	String nameV = request.getParameter("name");
		        	String passwdV = request.getParameter("password");
		        	//System.out.println(name+"  "+passwd);
	        		//sql语句
	 				if(nameV == null ||  passwdV ==null  ){
	 					//为 null 
	 				}else{
	 					//获取用户名 和 密码 参数  并且转化编码为 utf-8 防止出现乱码
 				    	String name =new String(nameV.getBytes("iso8859-1"),"UTF-8");
						String passwd =new String(passwdV.getBytes("iso8859-1"),"UTF-8");
						//判断 参数 是否为空   如果为空则使用js提示
	 					if(name.equals("")  || passwd.equals("") ){
	 						out.println("<script>alert('请输入正确的账号或者密码！')</script>");
	 					}else{
	 						//查询语句   查找用户数据库中是否有此用户名和密码的用户
	 						String sql="select * from user where name =? and password=?"; 
		 				   //创建PreparedStatement类对象，用来执行SQL语句
		            		PreparedStatement statement = mysqluse.initperpare(sql);
		    				statement.setString(1,name); //写入编译模板参数
		    				statement.setString(2,passwd);
		    				ResultSet res = statement.executeQuery(); // 执行
							if(res.next()) //判断是否 有值   有值则表明 登陆用户名和密码正确
							{ 
								user.setName(name);   //保存数据到JavaBean中
								user.setID(res.getInt("id"));
								user.setSex( (res.getInt("sex")==1) ? "男" : "女" );
								user.setAddress(res.getString("address"));
								request.getSession().setAttribute("name",name); //用Session保存用户名
								request.getSession().setAttribute("id",res.getInt("id")); //保存密码源
								response.sendRedirect("index.jsp"); // 跳转网页 
							}else{
								out.println("<div style=\"position: fixed;top: 100px;    padding: .75rem 1.25rem;margin-bottom: 1rem;border: 1px solid transparent;border-radius: .25rem;color: #721c24;background-color: #f8d7da;border-color: #f5c6cb; width: 500px;text-align: center;\" class=\"alert alert-warning\"><strong>失败!</strong> 账号或者密码错误。</div>");
							}
							res.close(); //关闭 ResultSet
							statement.close(); // 关闭 Staement
		 					}
	        			
	 				}
	        	}else if(type==2){  // 注册
	        		String nameV = request.getParameter("name");
		        	String passwdV = request.getParameter("password");
		        	String sexV = request.getParameter("sex");
		        	String ageV = request.getParameter("age");
		        	String addressV = request.getParameter("address");
		        	if(nameV == null || passwdV ==null || sexV == null || ageV == null || addressV == null){
		        		//值为null
		        	}else{
		        		//防止乱码
		        		String name =new String(nameV.getBytes("iso8859-1"),"UTF-8");
						String passwd =new String(passwdV.getBytes("iso8859-1"),"UTF-8");
						String address =new String(addressV.getBytes("iso8859-1"),"UTF-8");
						int sex =Integer.parseInt(sexV);
						int age =Integer.parseInt(ageV);
						if(name.equals("")  || passwd.equals("") || (0>age && age>110) || (0<sex && sex>2 ) || address.equals("")){
							//值为空 或者异常
						}else{
							String sql="INSERT INTO  user VALUES(null,?,?,?,?,?);";
		 				   //创建statement类对象，用来执行SQL语句！！
		            		PreparedStatement statement = mysqluse.initperpare(sql);
		    				statement.setString(1,name);
		    				statement.setString(2,passwd);
		    				statement.setString(3,address);
		    				statement.setInt(4,sex);
		    				statement.setInt(5,age);
		    				int res = statement.executeUpdate();
		    				out.println(res);
							if(res == 1)
							{ 	
								//注册成功
								out.println("<div style=\"position: fixed;top: 100px;    padding: .75rem 1.25rem;margin-bottom: 1rem;border: 1px solid transparent;border-radius: .25rem;color: #155724;background-color: #d4edda;border-color: #c3e6cb; width: 500px;text-align: center;\" class=\"alert alert-warning\"><strong>注册成功</strong> 可以登陆了。</div>");
							
							}else{
								//注册失败
								out.println("<div style=\"position: fixed;top: 100px;    padding: .75rem 1.25rem;margin-bottom: 1rem;border: 1px solid transparent;border-radius: .25rem;color: #721c24;background-color: #f8d7da;border-color: #f5c6cb; width: 500px;text-align: center;\" class=\"alert alert-warning\"><strong>注册失败!</strong> 用户名重复请重写注册 。</div>");
							}
							statement.close(); // 关闭 Staement
						}
		        	}
	        	}else{
	        		
	        	}
	        	mysqluse.close();	//关闭数据库连接
	        }else{
	           out.println("<script>alert('数据库出现错误！')</script>");
	        }
	        
	        
	    }catch(SQLIntegrityConstraintViolationException e){
	    	//重复报错
			out.println("<div style=\"position: fixed;top: 100px;    padding: .75rem 1.25rem;margin-bottom: 1rem;border: 1px solid transparent;border-radius: .25rem;color: #721c24;background-color: #f8d7da;border-color: #f5c6cb; width: 500px;text-align: center;\" class=\"alert alert-warning\"><strong>注册失败!</strong> 用户名重复请重写注册 。</div>");				
	    }
	    catch(Exception e){
	    	out.println("<script>alert('服务器出现错误！')</script>");
	        e.printStackTrace();
	    }finally{
    		
	    }
    }
%>
<body>
</html>