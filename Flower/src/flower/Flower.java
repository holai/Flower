package flower;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/addFlower")
public class Flower extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPost(req, resp); */
		req.setCharacterEncoding("UTF-8");
	 	String nameVal = req.getParameter("name");
	 	String introVal = req.getParameter("intro");
	 	String typeVal = req.getParameter("type");
	 	String fromVal = req.getParameter("from");
	 	String periodVal = req.getParameter("period");
	 	String colorVal = req.getParameter("color");
	 	String attributeVal = req.getParameter("attribute");
	 	String hrefVal =req.getParameter("href");
	 	String addressVal = req.getParameter("address");
	 	String srcUploadVal = req.getParameter("src");
	 	String picUploadVal = req.getParameter("pic");
	 	String postType = req.getParameter("postType");
	 	String flowerId = req.getParameter("flowerId");
	 	String code = "false";
	 	
	 	try {
	 		Object id = req.getSession().getAttribute("adminUser"); //管理员id  如果没有就不能提交
			if(id == null || nameVal == null || introVal == null || typeVal == null || fromVal == null  || periodVal == null || colorVal == null || attributeVal == null || hrefVal == null || addressVal == null || postType == null) {
				//参数不完整 或者未登陆
				code = "false";
			}else {
				Mysqluse mysqluse = new Mysqluse();
				if(mysqluse.getCode() == 0) {
					try {
							String sqld;
							if(postType.equals("true")) {
								sqld = "INSERT INTO flowers() VALUES(null,?,?,?,?,?,?,?,?,?,?,?);"; //添加花信息;
							}else {
								sqld = "UPDATE flowers SET `name`=?,type=?,address=?,intro=?,href=?,pic=?,color=?,period=?,attribute=?,`from`=?,src=? WHERE id="+flowerId; //修改花信息;
							}
							PreparedStatement statement = mysqluse.initperpare(sqld);
							statement.setString(1,nameVal);
							statement.setString(2,typeVal);
							statement.setString(3,addressVal);
							statement.setString(4,introVal);
							statement.setString(5,hrefVal);
							statement.setString(6,picUploadVal);
							statement.setString(7,colorVal);
							statement.setString(8,periodVal);
							statement.setString(9,attributeVal);
							statement.setString(10,fromVal);
							statement.setString(11,srcUploadVal);
							int res = statement.executeUpdate(); // 执行
							if(res == 1) {	//为1 则添加成功
								code = "true";
							}else {
								code = "false";
							}
							statement.close();
							mysqluse.close();
					} catch (SQLException e) {
						code = "false";
						e.printStackTrace();
					}
				}else {
					code = "false";
				}
				
			}
		}catch(Exception e) {
			code = "false";
			e.printStackTrace();
		}
	 	resp.getWriter().print(code);


		/*
		 * userBean user =(userBean)req.getAttribute("user");
		 * System.out.println(user.getID());
		 */
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// TODO Auto-generated method stub
		/* super.doDelete(req, resp); */
		//
		String code="false";
		try {
			req.setCharacterEncoding("UTF-8");
			String flowerId = req.getParameter("id");
			Object id =  req.getSession().getAttribute("adminUser");
			if(flowerId ==null || id == null) {
				code = "false";
			}else {
				
				Mysqluse mysqluse = new Mysqluse();
				if(mysqluse.getCode() == 0) {
					try {
							String sqld="DELETE FROM flowers WHERE id = ?;";
							PreparedStatement statement = mysqluse.initperpare(sqld);
							statement.setInt(1,Integer.parseInt(flowerId));
							int res = statement.executeUpdate();
							if(res > 0) {
								code = "true";
							}
							statement.close();
							mysqluse.close();
					} catch (SQLException e) {
						code = "false";
						e.printStackTrace();
					}
				}else {
					code = "false";
				}
				
			}
		}catch(Exception e) {
			code = "false";
		}
		
		resp.getWriter().print(code);
		
	}
	
}
