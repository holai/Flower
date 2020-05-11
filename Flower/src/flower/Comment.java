package flower;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/comment")
public class Comment extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPost(req, resp); */
		req.setCharacterEncoding("UTF-8");
		String txt = req.getParameter("txt");  //内容
		String scode = req.getParameter("scode"); //评分
		String flowerId = req.getParameter("id"); // 花卉id
		int id =  (int) req.getSession().getAttribute("id"); //用户id
		String code = "false";
		if(txt == null || scode == null || flowerId == null) {
			//参数错误 
			code = "false";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
						String sqld="INSERT INTO `comment`(id,userId,text) VALUES(?,?,?);"; //添加评论 语句
						PreparedStatement statement = mysqluse.initperpare(sqld);	
						statement.setInt(1,Integer.parseInt(flowerId));
						statement.setInt(2,id);
						statement.setString(3,txt);
						int res = statement.executeUpdate(); // 执行
						if(res == 1) {	//为1 则添加成功
							code = "true";
						}
						statement.close();
						
						//添加评分表 此语句会先判断评分表是否已经添加过再添加
						String sqlScode = "INSERT INTO grade() SELECT ?,?,? FROM DUAL WHERE NOT EXISTS(SELECT * FROM  grade WHERE  flowerId=? AND  userId=?);";
						PreparedStatement statementScode = mysqluse.initperpare(sqlScode);	
						statementScode.setInt(1,Integer.parseInt(flowerId));
						statementScode.setInt(2,id);
						statementScode.setString(3,scode);
						statementScode.setInt(4,Integer.parseInt(flowerId));
						statementScode.setInt(5,id);
						int resScode = statementScode.executeUpdate(); // 执行
						statementScode.close();
						if(resScode==0) {
							//没有添加上标识 已经存在    变为修改
							String sqlScodeU = "update grade set `value`=? WHERE  flowerId=? AND  userId=?";
							PreparedStatement statementScodeU = mysqluse.initperpare(sqlScodeU);	
							statementScodeU.setString(1,scode);
							statementScodeU.setInt(2,Integer.parseInt(flowerId));
							statementScodeU.setInt(3,id);
							statementScodeU.executeUpdate();
							statementScodeU.close();
						}
						
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
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	
}
