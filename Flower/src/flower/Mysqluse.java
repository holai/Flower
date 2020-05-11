package flower;

import java.sql.*;
public class Mysqluse {
    private Connection con;
    private int code=-1;
    //  -1未初始化  0 正常    -2 驱动异常  -3连接异常
    public Mysqluse(){
    		String driver = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/flower?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            String user = "数据库用户名";		//root
            String password = "数据库密码";  //数据库密码
            try {
                //加载驱动程序
                Class.forName(driver);
                //getConnection()方法，连接MySQL数据库！！
                this.con = DriverManager.getConnection(url,user,password);
                if(!this.con.isClosed())
                    this.code=0;
            } catch(ClassNotFoundException e) {
                //数据库驱动类异常处理
                this.code=-2;
                e.printStackTrace();
            } catch(SQLException e) {
                //数据库连接失败异常处理
                this.code = -3;
                e.printStackTrace();
            }

    }

    public PreparedStatement initperpare(String s) {
        PreparedStatement statement = null;
        try {
            //创建statement类对象，用来执行SQL语句！！
            statement = con.prepareStatement(s);
        }catch(SQLException e) {
            //数据库连接失败异常处理
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



    // 判断 是否 为 空 或者 null
    public boolean  NoNull(String... str){
        for (String item : str){
            if ( item == null || item.equals("") ){
                return false;
            }
        }
        return true;
    }



}






