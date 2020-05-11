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
		String is = req.getParameter("is");  //����
		String password = req.getParameter("password");  //����
		String loadpassword = req.getParameter("loadpassword");  //������
		
		String address = req.getParameter("address"); //��ַ
		int id =  (int) req.getSession().getAttribute("id"); //�û�id
		String code = "false";
		if(is == null || address == null ) {
			//�������� 
			code = "false";
		}else {
			
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
						PreparedStatement statement;
						if(is.equals("true")) {
							String sqld="UPDATE user set `password`=? WHERE id=? and password=?;"; //�޸��û�����
							 statement = mysqluse.initperpare(sqld);	
							statement.setString(1,password);
							statement.setInt(2,id);
							statement.setString(3,loadpassword);
						}else {
							String sqld="UPDATE user set address=? WHERE id=?;"; //�޸��û���ַ
							statement = mysqluse.initperpare(sqld);
							statement.setString(1,address);
							statement.setInt(2,id);
						}
						
						int res = statement.executeUpdate(); // ִ��
						if(res == 1) {	//Ϊ1 ����ӳɹ�
							code = "true";
							 req.getSession().removeAttribute("user"); //���JavaBean ��½״̬
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
