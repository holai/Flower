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
	//��̨��½��֤
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPost(req, resp); */
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String name = req.getParameter("name");	//��ȡ �˺� 
		String password = req.getParameter("password");	//����
		String code = "δ��ʼ��";	
		if(name==null || password==null) {
			code= "���ݸ�ʽ����ȷ";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
					String sqld="SELECT * FROM admin WHERE name=?;"; //��ѯ ����Ա ����
					PreparedStatement statement = mysqluse.initperpare(sqld);
					statement.setString(1,name);	//д��Ԥ�������
					ResultSet res = statement.executeQuery(); // ִ��
					code = "���� �û��� �Ƿ���ȷ";
					while(res.next()) {
						if(res.getString("password").equals(password)) {
							code = "true";
							req.getSession().setAttribute("adminUser", res.getInt("id")); // д�� session �����½״̬
						}else {
							code = "�������";
						}
					}
					res.close();
					statement.close();
					mysqluse.close();
				} catch (SQLException e) {
					code = "���ݿ������ִ���";
					e.printStackTrace();
				}
			}else {
				code = "�������������ݿ����";
			}
			
		}
		resp.getWriter().print(code);
	}

	// �޸� ����Ա����
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doPut(req, resp); */
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String password = req.getParameter("oldPassWord");	//����
		String passwordNew = req.getParameter("newPassWord");	//����
		Object idObject = req.getSession().getAttribute("adminUser");
		String code = "δ��ʼ��";	
		if(idObject==null || password==null || passwordNew == null) {
			code= "��������";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
					String sqld="UPDATE admin set `password`=? WHERE id=? AND `password`=?"; //��ѯ ����Ա ����
					PreparedStatement statement = mysqluse.initperpare(sqld);
					statement.setString(1,passwordNew);	
					statement.setInt(2,(int)idObject);	
					statement.setString(3,password);	
					int res = statement.executeUpdate();// ִ��
					if(res == 1) {
						code = "�޸ĳɹ�";
						req.getSession().removeAttribute("adminUser"); //�������Ա��½״̬
					}else {
						code = "�������";
					}
					statement.close();
					mysqluse.close();
				} catch (SQLException e) {
					code = "���ݿ������ִ���";
					e.printStackTrace();
				}
			}else {
				code = "�������������ݿ����";
			}
			
		}
		resp.getWriter().print(code);
	}

	
	//ɾ�� �û�
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* super.doDelete(req, resp); */
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String id = req.getParameter("id");	//�û�id
		Object idObject = req.getSession().getAttribute("adminUser");
		String code = "δ��ʼ��";	
		if(idObject==null || id == null) {
			code= "��������";
		}else {
			Mysqluse mysqluse = new Mysqluse();
			if(mysqluse.getCode() == 0) {
				try {
					String sqld="DELETE FROM `user` WHERE id=?;"; //ɾ�� �û�
					PreparedStatement statement = mysqluse.initperpare(sqld);
					statement.setInt(1,Integer.parseInt(id));
					int res = statement.executeUpdate();// ִ��
					if(res == 1) {
						code = "true";
					}else {
						code = "�Ҳ������û�";
					}
					statement.close();
					mysqluse.close();
				} catch (SQLException e) {
					code = "���ݿ������ִ���";
					e.printStackTrace();
				}
			}else {
				code = "�������������ݿ����";
			}
			
		}
		resp.getWriter().print(code);
		
	}
	
	
	
	
	
	
	
}
