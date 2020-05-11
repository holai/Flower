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
  <title>后台管理</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link rel="stylesheet" href="css/upload.css">
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
	    min-height: calc(100vh - 133px);
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
/* 	.box:hover img{
		transform: scale(1.1,1.1);
	} */
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
	
	.flowerItem{
		cursor: pointer;
	}
	.handle{
		max-width: 1240px;
	    margin: 10px auto;
	    text-align: right;
	}
	.cd input{
		margin:10px
	}
	.delete{
	     position: absolute;
    right: 0;
    top: 0;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background: #000;
    text-align: center;
    cursor: pointer;
    color: red !important;
    vertical-align: middle;
    float: right;
    font-size: 1.5rem;
    font-weight: 700;
    line-height: 1;
    color: #000;
    text-shadow: 0 1px 0 #fff;
    opacity: .5;
    
	}
/* 	
	.imgFileUploade .header span.imgClick {
    width: 50px;
    height: 50px;
    margin-left: 10px;
    cursor: pointer;
    background: url(images/addUpload.png) no-repeat center center;
    background-size: cover;
        display: inline-block;
    vertical-align: middle;
}

.imgFileUploade .imgAll li {
    width: 100px;
    height: 100px;
    border: solid 1px #ccc;
    margin: 8px 5px;
    float: left;
    position: relative;
    box-shadow: 0 0 10px #eee;
}
li {
    list-style: none;
}
.imgFileUploade .imgAll li img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: block;
}
img {
    border: none;
    display: block;
}
.delImg{
	    position: absolute;
    right: 0;
    top: 0;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: #000;
    text-align: center;
    cursor: pointer;
        color: #fff;
    vertical-align: middle;
    line-height: 20px;
    font-size: 20px;
} */
  </style>
</head>

<body>
	 <jsp:include page="nav.jsp" />
	  <div class="bg">
	 	 <div class="handle">
	  		<button id="add" type="button" data-toggle="modal" data-target="#flowerModal" class="btn btn-primary btn-lg">新增</button>
	  	</div>
		<div class="content">
			  <div class="row">
		  			
			  		 <%
			  		 	Object isAdmin = request.getSession().getAttribute("adminUser");
			  		 	if(isAdmin == null){
			  		 		response.sendRedirect("login.jsp");
			  		 	}
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
			    					out.println("<div data-toggle=\"modal\" data-target=\"#flowerModal\" address=\""+res.getString("address")+"\" href=\""+res.getString("href")+"\" color=\""+res.getString("color")+"\" period=\""+res.getString("period")+"\" attribute=\""+res.getString("attribute")+"\" from=\""+res.getString("from")+"\" src=\""+res.getString("src")+"\"  flowerId=\""+res.getString("id")+"\"  class=\"flowerItem col-6 col-sm-4 col-md-3\"><div class=\"box\"> <span class=\"delete\">x</span><span class=\"type badge badge-info\" >"+res.getString("type")+"</span><div class=\"img-box\"><img src=\""+res.getString("pic")+"\" ></div><div class=\"txt\"><div class=\"title\">"+res.getString("name")+"</div><div class=\"text\">"+res.getString("intro")+"</div></div></div></div>");
			     					
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
			      <li class="page-item <%= pageVal==1 ? "disabled" :  "" %> "><a class="page-link" href="<%= pageVal==1 ? "#" :  "admin/index.jsp?page="+(pageVal-1) %>">上一页</a></li>
			      
			      <% 
			      	for(int i =1;i<=pageCount;i++){
			      		if(i==pageVal){
			      			out.println("<li class=\"page-item active\"><a class=\"page-link\" href=\"admin/index.jsp?page="+i+"\">"+i+"</a></li>");
			      		}else{
			      			out.println("<li class=\"page-item \"><a class=\"page-link\" href=\"admin/index.jsp?page="+i+"\">"+i+"</a></li>");
			      		}
			      	}	
			      
		      	   %>
			      <li class="page-item <%= pageVal==pageCount ? "disabled" :  "" %>"><a class="page-link" href="<%= pageVal==count ? "#" :  "admin/index.jsp?page="+(pageVal+1) %>">下一页</a></li>
			    </ul>
		</div>
	  </div>


 <!-- 模态框 -->
  <div class="modal fade" id="flowerModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">新增 花卉 信息</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <!-- 模态框主体 -->
        <div class="modal-body">
     		<div class="form-group">
		      <label for="name">名字:</label>
		      <input type="text" class="form-control" id="name" placeholder="花名：">
		    </div>
		    <div class="form-group">
		      <label for="intro">介绍:</label>
		      <textarea class="form-control" rows="2" id="intro"></textarea>
		    </div>
		    <div class="form-inline cd">
		      <input type="text" class="form-control" id="type" placeholder="植物类型：">
		       <input type="text" class="form-control" id="from" placeholder="原产地：">
		        <input type="text" class="form-control" id="period" placeholder="开花周期：">
		        <input type="text" class="form-control" id="color" placeholder="颜色：">
		         <input type="text" class="form-control" id="attribute" placeholder="生长属性：">
		         <input type="text" class="form-control" id="href"  placeholder="商店链接：" />
		    </div>
		   <!--  <div class="form-group">
		      <label for="href">商店链接：</label>
		     
		    </div> -->
		    <div class="form-group">
		      <label for="address">适宜生长地：</label>
		     <input type="text" class="form-control" id="address" placeholder="多个用 ,分割">
		    </div>
		    <div class="form-group" id="srca">
		      <label for="address">主要图片：</label>
		      
		    </div>
		    <div class="form-group" id="srcb">
		      <label for="address">主要图片：</label>
		     	
		    </div>
		    
		    
		     </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
        <button id="updateFlower" style="display:none" type="button" class="btn btn-info">修改</button>
    	  <button id="addFlower" type="button" class="btn btn-info">添加</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
  

  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script src="js/jQuery.upload.min.js"></script>
  <script>
  var basePath = "<%=basePath %>";
  
  //使用了 js 上传图片   jQuery.upload
  var $pic = $("<div class=\"upload\" data-value action=\"upload\" data-size=\"99999\" id=\"pic\" data-num=\"1\" ></div>");
  var $src = $("<div class=\"upload\" data-value action=\"upload\" data-size=\"99999\" id=\"case\" data-num=\"3\" ></div>");
  $("#srca").append($pic);
  $("#srcb").append($src);
  $pic.upload();   //初始化上传控件
  $src.upload();
   var namef = $("#name");
   var intro = $("#intro");
   var type = $("#type");
   var from = $("#from");
   var period = $("#period");
   var color = $("#color");
   var attribute = $("#attribute");	
   var href = $("#href");	
   var address = $("#address");	
   var picUpload = $("#pic input[name='upload']");
   var srcUpload = $("#case input[name='upload']");

   //新增按钮
   $("#add").click(function(){
	   $("#addFlower").attr("style","display:inline-block");
		  $("#updateFlower").attr("style","display:none");
		  
		  namef.val("");
		  intro.val("");
		  type.val("");
		  from.val("");
		  period.val("");
		  color.val("");
		  attribute.val("");	
		  href.val("");	
		  address.val("");	
		  
		  $("#pic").empty();
		  $("#case").empty();
		  $("#pic").remove();
		  $("#case").remove();
		  $("#srca").append($pic);
		  $("#srcb").append($src);
		  $("#pic").attr("data-value",""); 
		  $("#case").attr("data-value","");
		  $("#pic").upload();
		  $("#case").upload(); 
   });
   
  // 新增 模态框确认按钮
  $("#addFlower").click(function(){
	  ajaxFlower(true);
	  
  });
  var flowerId = 0;
  //修改确认
  $("#updateFlower").click(function(){
	  ajaxFlower(false,0);
  });
  //点击 花
  $(".flowerItem").click(function(event){
	  var _this = $(this);
	  flowerId =_this.attr("flowerId");
	  namef.val(_this.find(".title").text());
	  intro.val(_this.find(".text").text());
	  type.val(_this.find(".type").text());
	  from.val(_this.attr("from"));
	  period.val(_this.attr("period"));
	  color.val(_this.attr("color"));
	  attribute.val(_this.attr("attribute"));	
	  href.val(_this.attr("href"));	
	  address.val(_this.attr("address"));	
	  
	  $("#pic").empty();
	  $("#case").empty();
	  $("#pic").remove();
	  $("#case").remove();
	  $("#srca").append($pic);
	  $("#srcb").append($src);
	  $("#pic").attr("data-value",_this.find("img").attr("src")); 
	  $("#case").attr("data-value",_this.attr("src"));
	  console.log(_this.attr("src"));
	  
	   $("#pic").upload();
	  $("#case").upload(); 
	  
	  console.log($("#case input[name='upload']").val());
	  
	  $("#addFlower").attr("style","display:none");
	  $("#updateFlower").attr("style","display:inline-block");
	 
  });
  
  //删除
  $(".delete").click(function(event){
	  
	  if(window.confirm('你确定要删除此花卉信息吗？')){
		  var _this = $(this);
		  var flower= _this.parents(".flowerItem");
			$.ajax({
				url:basePath+"/admin/addFlower?id="+flower.attr("flowerid"),
				type:'delete',
				success:function(result){
					if(result=="true"){
						//请求成功
						location.href = location.href; //刷新
					}else{ 
						//请求失败
						alert("请求失败！");
					}
	   			}
			});
		  event.stopPropagation();
          return true;
       }
	  event.stopPropagation();
  })
 
  // 添加 花卉
  function ajaxFlower(is){
	   var nameVal = namef.val();
	   var introVal = intro.val();
	   var typeVal = type.val();
	   var fromVal = from.val();
	   var periodVal = period.val();
	   var colorVal = color.val();
	   var attributeVal = attribute.val();	
	   var hrefVal =href.val();	
	   var addressVal = address.val();	
	   var picUploadVal =  $("#pic input[name='upload']").val();
	   var srcUploadVal = $("#case input[name='upload']").val();
	   	
	   $.ajax({
			url:basePath+"/admin/addFlower",
			data:"name="+nameVal+"&intro="+introVal+"&type="+typeVal+"&from="+fromVal+"&period="+periodVal+"&color="+colorVal+"&attribute="+attributeVal+"&href="+hrefVal+"&address="+addressVal+"&href="+hrefVal+"&src="+srcUploadVal+"&pic="+picUploadVal+"&postType="+is+"&flowerId="+flowerId,     
			type:'post',
			success:function(result){
				if(result=="true"){
					//请求成功
						location.href = location.href; //刷新
				}else{
					//请求失败
					alert("请求失败！");
				}
   		}
		});
  }
  </script>
</body>

</html>