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
		String txt = req.getParameter("txt");  //����
		String scode = req.getParameter("scode"); //����
		String flowerId = req.getParameter("id"); // ����id
		int id =  (int) req.getSession().getAttribute("id"); //�û�id
		String code = "false";
		if(txt == null || scode == null || flowerId == null) {
			//�������� 
			code = "false";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
						String sqld="INSERT INTO `comment`(id,userId,text) VALUES(?,?,?);"; //������� ���
						PreparedStatement statement = mysqluse.initperpare(sqld);	
						statement.setInt(1,Integer.parseInt(flowerId));
						statement.setInt(2,id);
						statement.setString(3,txt);
						int res = statement.executeUpdate(); // ִ��
						if(res == 1) {	//Ϊ1 ����ӳɹ�
							code = "true";
						}
						statement.close();
						
						//������ֱ� ���������ж����ֱ��Ƿ��Ѿ���ӹ������
						String sqlScode = "INSERT INTO grade() SELECT ?,?,? FROM DUAL WHERE NOT EXISTS(SELECT * FROM  grade WHERE  flowerId=? AND  userId=?);";
						PreparedStatement statementScode = mysqluse.initperpare(sqlScode);	
						statementScode.setInt(1,Integer.parseInt(flowerId));
						statementScode.setInt(2,id);
						statementScode.setString(3,scode);
						statementScode.setInt(4,Integer.parseInt(flowerId));
						statementScode.setInt(5,id);
						int resScode = statementScode.executeUpdate(); // ִ��
						statementScode.close();
						if(resScode==0) {
							//û������ϱ�ʶ �Ѿ�����    ��Ϊ�޸�
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
