package flower;

import java.sql.*;
public class Mysqluse {
    private Connection con;
    private int code=-1;
    //  -1δ��ʼ��  0 ����    -2 �����쳣  -3�����쳣
    public Mysqluse(){
    		String driver = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/flower?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            String user = "���ݿ��û���";		//root
            String password = "���ݿ�����";  //���ݿ�����
            try {
                //������������
                Class.forName(driver);
                //getConnection()����������MySQL���ݿ⣡��
                this.con = DriverManager.getConnection(url,user,password);
                if(!this.con.isClosed())
                    this.code=0;
            } catch(ClassNotFoundException e) {
                //���ݿ��������쳣����
                this.code=-2;
                e.printStackTrace();
            } catch(SQLException e) {
                //���ݿ�����ʧ���쳣����
                this.code = -3;
                e.printStackTrace();
            }

    }

    public PreparedStatement initperpare(String s) {
        PreparedStatement statement = null;
        try {
            //����statement���������ִ��SQL��䣡��
            statement = con.prepareStatement(s);
        }catch(SQLException e) {
            //���ݿ�����ʧ���쳣����
            code = -3;
            e.printStackTrace();
        }
        return statement;
    }

    public int getCode() {
        return code;
    }

    
    public void close(){
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    // �ж� �Ƿ� Ϊ �� ���� null
    public boolean  NoNull(String... str){
        for (String item : str){
            if ( item == null || item.equals("") ){
                return false;
            }
        }
        return true;
    }



}






