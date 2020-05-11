package flower;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/user")
public class User extends HttpServlet{
	

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPost(req, resp); */
		req.setCharacterEncoding("UTF-8");
		String is = req.getParameter("is");  //类型
		String password = req.getParameter("password");  //密码
		String loadpassword = req.getParameter("loadpassword");  //老密码
		
		String address = req.getParameter("address"); //地址
		int id =  (int) req.getSession().getAttribute("id"); //用户id
		String code = "false";
		if(is == null || address == null ) {
			//参数错误 
			code = "false";
		}else {
			
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
						PreparedStatement statement;
						if(is.equals("true")) {
							String sqld="UPDATE user set `password`=? WHERE id=? and password=?;"; //修改用户密码
							 statement = mysqluse.initperpare(sqld);	
							statement.setString(1,password);
							statement.setInt(2,id);
							statement.setString(3,loadpassword);
						}else {
							String sqld="UPDATE user set address=? WHERE id=?;"; //修改用户地址
							statement = mysqluse.initperpare(sqld);
							statement.setString(1,address);
							statement.setInt(2,id);
						}
						
						int res = statement.executeUpdate(); // 执行
						if(res == 1) {	//为1 则添加成功
							code = "true";
							 req.getSession().removeAttribute("user"); //清除JavaBean 登陆状态
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
		resp.getWriter().println(code);


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
	
}
