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
  <title>推荐列表</title>
  <!-- bootstrap core css --> 
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Dosis:400,600,700|Poppins:400,600,700&display=swap" rel="stylesheet" />
   <!-- Custom styles for this template -->
   <link href="css/style.css" rel="stylesheet" />
  <style type="text/css">

	body{
	
	min-width: 890px;
	}
	.content{
		/* height: 500px; */
		max-width: 1190px;
		
		margin: 10px auto;
		/* background-color: rgba(0,0,0,0.4); */
		padding: 20px 40px;
	    min-height: calc(100vh - 86px);
	    display:flex;
	    
	}
	.left{
		width:210px;
		margin:20px;
	}
	.left .title{
	    position: relative;
	    line-height: 50px;
	    font-size: 12px;
	    color: #666;
	    font-weight: 400;
	    text-align: center;
	}
	.left .title h3{
		position: relative;
	    z-index: 2;
	    display: inline-block;
	    *display: inline;
	    *zoom: 1;
	    background: #fff;
	    padding: 0 25px;
	    font-size:11px
	}
	.left .title span {
	    position: absolute;
	    z-index: 1;
	    left: 0;
	    right: 0;
	    top: 25px;
	    height: 1px;
	    background: #f2f2f2;
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
		line-height: 1.2em;
		font-size: 12px;
		text-align: left;
	}
	.box .text{
		font-size: 11px;
		width: 100%;
	    word-wrap: break-word;
	    /* height: 3em; */
	    overflow: hidden;
	    word-break: break-all;
	    text-overflow: ellipsis;
	    /* width: 20em; */
	    line-height: 1.1em;
	    overflow: hidden;
	    white-space:nowrap;
	    display: -webkit-box;
	    -webkit-line-clamp: 1;
	    -webkit-box-orient: vertical;
	    
	}
	.right{
		flex:1;
		padding:10px;
	}
	.xq{
		display:flex;
	}
	.xq .img{
		width:380px;
	}
	.xq .txt{
		font-size: 16px;
		padding:10px;
		padding-left:40px;
		flex:1;
		line-height:2.5em;
	    display: flex;
    	flex-direction: column;
	}
	.xq .title{
		padding-bottom: .2em;
	    line-height: 3em;
	    font-size: 20px;
	    font-weight: 700;
	    color: #000;		
	}
	.xq .txt .text{
		flex:1;
	}
	.handel{
		margin-top:20px; 
		display:flex;
		flex-direction: row  !important;
		/* height:150px; */
	}
	.handel .intro{
		flex:1;
		/* padding:10px;
		font-size:15px; */
	}
	.handel .colletceBox{
		width:200px;
		border-left:1px solid #ddd;
	    display: flex;
	    justify-content: center;
	    align-content: center;
	    padding:20px;
        text-align: center;
        flex-direction: column;
	}
	.colletceBox button{
		width:100%; 
	}
	.imgBox img{
		width:33%;
		height:200px;
	}
	
	.comment{
		margin-top:20px;
		border:1px solid #ddd;
		padding:10px;
	}
	
	.comment .item{
		padding:5px;
    	list-style: none;
    	border-bottom:1px solid #ddd;
	}
	
	.comment .item .cont{
		text-indent: 3em; 
	}
	.comment .item .xi{
		line-height:1.8em;
		display:flex;
	}
	.comment .item .xi div{
		text-align: right;
	}
	.comment .xi div.date{ 
		flex:1; 
		font-size:13px;
		color:#bbb; 
		text-align: left; 
	}
  </style>


</head>

<body>

	  <jsp:include page="nav.jsp" />
	  
	   <%
 		 	int id=1; // 查看 花卉 的id
 		 	boolean isCooletc = false; //是否已经收藏
 		 	int star=0;   //花的评分
 		 	String name="",type="",from="",intro="",href="",pic="",color="",period="",attribute="",src="";
	       	//使用 mysql连接类 
	       	Mysqluse mysqluse = new Mysqluse();
	       	if(mysqluse.getCode() == 0){
	       		try{
	       			
/* 	       			if(request.getParameter("type") != null){   //如果 type 不为空 则执行 操作
	       				int Formtype = Integer.parseInt(request.getParameter("type"));
	       				int 
	       			} */
	       			
	       			//连接成功
	       			if(request.getParameter("id")!=null){  //判断是否 有id参数
	       				id =Integer.parseInt(request.getParameter("id"));
	       			}
	       				String sql="SELECT * FROM flowers where id=?";  //获取选定id的数据
	      				PreparedStatement statement = mysqluse.initperpare(sql); 
	      				statement.setInt(1,id);//传入参数
	    				ResultSet res = statement.executeQuery();
	    				while(res.next()){
		   					name = res.getString("name"); //名字
		   					type = res.getString("type");//类型
		   					from = res.getString("from");//原产地
		   					intro = res.getString("intro");//简介
		   					href = res.getString("href");//链接
		   					pic = res.getString("pic");//主图片地址
		   					color = res.getString("color");//颜色
		   					period = res.getString("period");//周期
		   					attribute = res.getString("attribute");//属性
		   					src = res.getString("src");//副图片 地址
	    				}
	    				res.close();
	    				statement.close();
	    				
	    			  	if(user.getName() != null){  //已经登陆
	    			  		//获取是否 已经收藏
	    			  		String sqlCool="SELECT COUNT(*) as count from colletc where userId=? AND flowerId=?;";  //获取选定id的数据
		      				PreparedStatement statementCool = mysqluse.initperpare(sqlCool); 
		      				statementCool.setInt(1,user.getID());//传入 用户 id
		      				statementCool.setInt(2,id);//传入 花 的id
		    				ResultSet resCool = statementCool.executeQuery();
		      				resCool.next();
		      				int count = resCool.getInt("count"); 
		      				if(count>0){       //如果有数据则表明 已经收藏
		      					isCooletc = true;
		      				}
		      				resCool.close();
		      				statementCool.close();
	    			  	}
	    			  	 
	    			  	//获取 平均评分
	    			  	String sqlGrade="select avg(`value`) as star from grade where flowerId=?";  //获取选定id的数据
	      				PreparedStatement statementGrade = mysqluse.initperpare(sqlGrade);
	      				statementGrade.setInt(1,id);//传入 花 的id
	    				ResultSet resGrade = statementGrade.executeQuery();
	      				resGrade.next();
	      				star= resGrade.getInt("star"); 
	      				resGrade.close();
	      				statementGrade.close();
	      				
/* 	    				//获取总数量
	    				String sqlA="SELECT COUNT(*) as count FROM flowers";
	      				PreparedStatement statementA = mysqluse.initperpare(sqlA);
	    				ResultSet resA = statementA.executeQuery();
	    				resA.next();
	   					count = resA.getInt("count");
	    				resA.close();
	    				statementA.close(); */
	    				
	    				
	    				/* mysqluse.close(); */
	       		}catch(Exception e){
	       			e.printStackTrace();
	       		}
	      		}else{
	       		out.println("<script>alert(\"服务器出现错误\")</script>");
	       	}
  		 %>
	  	
	  <div class="content">
	  		
	  		<div class="right">
	  			<div class="xq">
	  					<img class="img img-responsive"  src="<%=pic %>">
	  					<div class="txt">
	  						<div class="title"><%=name %> </div>
	  						<div class="text">植物类型：<span><%=type %></span> </div>
	  						<div class="text">原产地区：<span><%=from %></span> </div>
	  						<div class="text">开花周期：<span><%=period %></span> </div>
	  						<div class="text">花朵颜色：<span><%=color %></span> </div>
	  						<div class="text">生长属性：<span><%=attribute %></span> </div>
	  						<div class="star" data-score="<%=star %> " ></div> 
	  					</div>
	  			</div>
	  			
			 	 <div class="card handel" style="margin-top:20px">
			 	 	  
				    <div class="card-body intro">
				    	<h4 class="card-title">花卉详情介绍：</h4>
				      <p class="card-text"><%=intro %></p>
				    </div>
				    
				    <div class="colletceBox">
				    		<button id="colle"  <%= user.getName()==null ? "disabled" : ""  %>  class="btn btn-info"><%= isCooletc ? "取消收藏" : "收藏" %> </button>
				    		<%= user.getName()==null ? "<a href=\"login.jsp\" style=\"color:red;font-size:12px\">登陆后才能操作 点击登陆</a>" : ""  %>
			    
	  				</div>
			    </div>
	  			
				  <div class="card" style="margin-top:10px">
					    
					    <div class="card-header">
					     	<h5>图片欣赏：</h5>
						</div>
					    <div class="card-body imgBox">
					    	<%
					    	  String[] arr =	src.split(",");
					    	  for(String item : arr){
					    		  out.println("<img src=\""+item+"\" />");
					    	  }
					    	%>
					    	<!-- <img src="images/lanxh.jpeg"  />
					    	<img src="images/lanxh.jpeg" />
					    	<img src="images/lanxh.jpeg"  /> -->
					    </div> 
				  </div>
				  
				  
	  			 <div class="card">
					    <div class="card-body">
					    	<div class="form-group">
						      <label for="comment">我有话说:</label>
						      <textarea id="txt" class="form-control" rows="5" id="comment"></textarea>
						    </div>
					    </div> 
					     <div class="card-footer" style="display:flex;">
					     	<div id="star" style="flex:1"></div>
							<button id="post" type="button" <%= user.getName()==null ? "disabled" : ""  %>  class="btn btn-primary">提交</button>
						</div>
				  </div>
				  
				  <ul class="comment" id="comment">
				  	
				  	<%
						  	String sqlComment="SELECT * FROM comment where id=?";
		      				PreparedStatement statementComment = mysqluse.initperpare(sqlComment);
		      				statementComment.setInt(1, id);
		    				ResultSet resComment = statementComment.executeQuery();
		    				while(resComment.next()){
		    					String sqlUser="SELECT user.name,grade.`value` FROM user LEFT JOIN grade on grade.userId=user.id where  userId=? AND flowerId=?";
			      				PreparedStatement statementUser= mysqluse.initperpare(sqlUser);
			      				statementUser.setInt(1, resComment.getInt("userId"));
			      				statementUser.setInt(2, id);
			    				ResultSet resUser = statementUser.executeQuery();
			    				while(resUser.next()){
				    				String userName = resUser.getString("name");
				    				String userValue = resUser.getString("value");
				    				out.println("<li class=\"item\"><div class=\"txt\">"+userName+"：</div><div class=\"cont\">"+resComment.getString("text")+"</div><div class=\"xi\"> <div class=\"date\">"+resComment.getString("time")+"</div><div class=\"star\" data-score=\""+userValue+"\" style=\"flex:1\"></div></div></li>");
			    				
			    				}
			    				
		    				}
		    				resComment.close();
		    				statementComment.close();
		    				
				  	%>
				  	
				  	
				  	
				  	<!-- <li class="item">
				  		<div class="txt">
				  			后来：
				  		</div>
				  		<div class="cont">
				  			很好看哦 ！还不容易养活。
				  		</div>
				  		<div class="xi"> 
				  			<div class="date">2019-4-15</div>
			  				<div  style="flex: 1 1 0%; cursor: pointer; width: 100px;"><img src="js/lib/img/star-on.png" alt="1" title="bad">&nbsp;<img src="js/lib/img/star-on.png" alt="2" title="poor">&nbsp;<img src="js/lib/img/star-on.png" alt="3" title="regular">&nbsp;<img src="js/lib/img/star-off.png" alt="4" title="good">&nbsp;<img src="js/lib/img/star-off.png" alt="5" title="gorgeous"><input type="hidden" name="score" value="3"></div>
				  		</div>
				  	</li> -->

				  	

				  </ul>
				  
	  		</div>
	  		
	  		<div class="left">
	  			<div class="title">
  				    <h3>看了又看</h3>
                	<span></span>
	  			</div>
	  			<div class="dd">
	  			
				  	<%
							String sqlRef="SELECT flowers.* FROM flowers LEFT JOIN grade on flowers.id = grade.flowerId WHERE id != ? GROUP BY flowers.id,flowers.address ORDER BY sum(grade.value) DESC LIMIT 5 ";
		    				PreparedStatement statementRef = mysqluse.initperpare(sqlRef);
		    				statementRef.setInt(1, id);
		     				ResultSet resRef = statementRef.executeQuery();
		     				while(resRef.next()){
		    					out.println("<div class=\"col-12\"><a href=\"detail.jsp?id="+resRef.getString("id")+"\"><div class=\"box\"><span class=\"type badge badge-info\" >"+resRef.getString("type")+"</span><div class=\"img-box\"><img src=\""+resRef.getString("pic")+"\" ></div><div class=\"txt\"><div class=\"title\">"+resRef.getString("name")+"</div><div class=\"text\">"+resRef.getString("intro")+"</div></div></div></a></div>");
		     				}
		     				resRef.close();
		     				statementRef.close();
		    				
		    				 mysqluse.close();
				  	%>
<!-- 	  				<div class="col-12">
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
	  		</div>
	  </div>
	      <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/lib/jquery.raty.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
	<script type="text/javascript"> 
	scodeVal =3; //分值
	
	$(function(){
		
		
		//评分插件 初始化
		$("#star").raty({ path: 'js/lib/img',click:function(score, evt) {
			scodeVal=score;
		  }});
		
		$(".star").raty({score:function() {
			
		    return $(this).attr('data-score');
		
		  },path: 'js/lib/img',readOnly: true});
			
				
		
	});
	var isCooletc = <%=isCooletc %> ;
	var id = <%=id %> ;
	var basePath = "<%=basePath %>";
	
	$("#colle").click(function(){     //点击收藏 或 取消收藏
		$.ajax({
			url:basePath+"/cooletc",
			data:"id="+id+"&isCooletc="+isCooletc,
			type:'post',
			success:function(result){
				if(result){
					//请求成功
					if(isCooletc){
						$("#colle").text("收藏");
					}else{
						$("#colle").text("取消收藏");
					}
					isCooletc = !isCooletc;
				}else{
					//请求失败
					alert("请求失败！");
				}
    		}
		});
		
	})
	
	var userName = "<%=user.getName() %>";
	var item = $("<li class=\"item\"><div class=\"txt\">后来：</div><div class=\"cont\">。</div><div class=\"xi\"><div class=\"date\">2019-4-15</div><div class=\"star\" data-score=\"2\" style=\"flex:1\"></div></div></li>");
	var itemObj={};
	itemObj.txt=item.find(".txt");
	itemObj.cont=item.find(".cont");
	itemObj.date=item.find(".date");
	itemObj.star=item.find(".star");
	$("#post").click(function(){  //提交评论
		$.ajax({
			url:basePath+"/comment",
			data:"id="+id+"&txt="+($("#txt").val())+"&scode="+scodeVal,
			type:'post',
			success:function(result){
				if(result){
					//请求成功
					itemObj.txt.text(userName);
					itemObj.cont.text($("#txt").val());
					itemObj.star.attr("data-score",scodeVal);
					itemObj.date.text("刚刚");
					$("#comment").append(item.clone()); // 复制到页面中 
					//初始化 新添加的 星级
					$(".star").raty({score:function() {
					    return $(this).attr('data-score');
					  },path: 'js/lib/img',readOnly: true});
					
					$("#txt").val(""); //清空
				}else{ 
					//请求失败
					alert("请求失败！");
				}
   			}
		})
	}) 


	
		
	</script>
</body>

</html>