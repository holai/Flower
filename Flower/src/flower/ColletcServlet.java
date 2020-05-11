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

@WebServlet("/cooletc")
public class ColletcServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPost(req, resp); */
		req.setCharacterEncoding("UTF-8");
		String code="false";
		String isCooletc = req.getParameter("isCooletc");
		String flowerId = req.getParameter("id");
		int id =  (int) req.getSession().getAttribute("id");
		if(isCooletc == null ||  flowerId ==null) {
			code = "false";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
						String sqld = "";
						if(isCooletc.equals("true")) {
							sqld="DELETE from colletc where userId=? AND flowerId=?;";
						}else {
							sqld="INSERT into colletc() VALUES(?,?);";
						}
						PreparedStatement statement = mysqluse.initperpare(sqld);
						statement.setInt(1,id);
						statement.setInt(2,Integer.parseInt(flowerId));
						int res = statement.executeUpdate();
						if(res == 1) {
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
		
		resp.getWriter().println(code);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doGet(req, resp); */
		doPost(req, resp);
	}

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doDelete(req, resp); */
		//
		req.setCharacterEncoding("UTF-8");
		String code="false";
		String flowerId = req.getParameter("id");
		int id =  (int) req.getSession().getAttribute("id");
		if(flowerId ==null) {
			code = "false";
		}else {
			
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
						String sqld="DELETE FROM colletc where  userId=? AND flowerId=?";
						PreparedStatement statement = mysqluse.initperpare(sqld);
						statement.setInt(1,id);
						statement.setInt(2,Integer.parseInt(flowerId));
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
		
		resp.getWriter().println(code);
		
	}
	
	
	
	
	
}
