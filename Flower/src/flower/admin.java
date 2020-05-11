package flower;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin")
public class admin extends HttpServlet {
	//后台登陆验证
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPost(req, resp); */
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String name = req.getParameter("name");	//获取 账号 
		String password = req.getParameter("password");	//密码
		String code = "未初始化";	
		if(name==null || password==null) {
			code= "数据格式不正确";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
					String sqld="SELECT * FROM admin WHERE name=?;"; //查询 管理员 名字
					PreparedStatement statement = mysqluse.initperpare(sqld);
					statement.setString(1,name);	//写入预编译语句
					ResultSet res = statement.executeQuery(); // 执行
					code = "请检查 用户名 是否正确";
					while(res.next()) {
						if(res.getString("password").equals(password)) {
							code = "true";
							req.getSession().setAttribute("adminUser", res.getInt("id")); // 写入 session 保存登陆状态
						}else {
							code = "密码错误！";
						}
					}
					res.close();
					statement.close();
					mysqluse.close();
				} catch (SQLException e) {
					code = "数据库语句出现错误！";
					e.printStackTrace();
				}
			}else {
				code = "服务器连接数据库错误";
			}
			
		}
		resp.getWriter().print(code);
	}

	// 修改 管理员密码
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPut(req, resp); */
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String password = req.getParameter("oldPassWord");	//密码
		String passwordNew = req.getParameter("newPassWord");	//密码
		Object idObject = req.getSession().getAttribute("adminUser");
		String code = "未初始化";	
		if(idObject==null || password==null || passwordNew == null) {
			code= "参数错误";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
					String sqld="UPDATE admin set `password`=? WHERE id=? AND `password`=?"; //查询 管理员 名字
					PreparedStatement statement = mysqluse.initperpare(sqld);
					statement.setString(1,passwordNew);	
					statement.setInt(2,(int)idObject);	
					statement.setString(3,password);	
					int res = statement.executeUpdate();// 执行
					if(res == 1) {
						code = "修改成功";
						req.getSession().removeAttribute("adminUser"); //清除管理员登陆状态
					}else {
						code = "密码错误";
					}
					statement.close();
					mysqluse.close();
				} catch (SQLException e) {
					code = "数据库语句出现错误！";
					e.printStackTrace();
				}
			}else {
				code = "服务器连接数据库错误";
			}
			
		}
		resp.getWriter().print(code);
	}

	
	//删除 用户
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doDelete(req, resp); */
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String id = req.getParameter("id");	//用户id
		Object idObject = req.getSession().getAttribute("adminUser");
		String code = "未初始化";	
		if(idObject==null || id == null) {
			code= "参数错误";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
					String sqld="DELETE FROM `user` WHERE id=?;"; //删除 用户
					PreparedStatement statement = mysqluse.initperpare(sqld);
					statement.setInt(1,Integer.parseInt(id));
					int res = statement.executeUpdate();// 执行
					if(res == 1) {
						code = "true";
					}else {
						code = "找不到此用户";
					}
					statement.close();
					mysqluse.close();
				} catch (SQLException e) {
					code = "数据库语句出现错误！";
					e.printStackTrace();
				}
			}else {
				code = "服务器连接数据库错误";
			}
			
		}
		resp.getWriter().print(code);
		
	}
	
	
	
	
	
	
	
}
