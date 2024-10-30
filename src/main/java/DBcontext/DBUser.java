package DBcontext;

import Entity.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DBUser {
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Khai báo thông tin kết nối cơ sở dữ liệu
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/";
        String dbName = "webbds";
        String dbUsername = "root";  // Tài khoản MySQL của bạn
        String dbPassword = "";  // Mật khẩu MySQL của bạn

        // Tải driver MySQL
        Class.forName(dbDriver);


        return DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
    }

    public static void main(String[] args) {
        try {

            Connection conn = DbConnection1.initializeDatabase();
            Statement stmt = conn.createStatement();


            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            ResultSet rs = stmt.executeQuery(query);
            List<User> users = new ArrayList<>();
            while (rs.next()) {
                User u = new User();
                System.out.println("Ket noi thanh cong");
                System.out.println(rs.getString("username"));
                System.out.println(rs.getString("password"));
                users.add(u);
                System.out.println(users);
            }


            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}





