package DBcontext;

import Controller.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDbConnection {

    // Phương thức khởi tạo kết nối tới cơ sở dữ liệu

    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Khai báo thông tin kết nối cơ sở dữ liệu
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/";
        String dbName = "mysql";
        String dbUsername = "root";  // Tài khoản MySQL của bạn
        String dbPassword = "";  // Mật khẩu MySQL của bạn

        // Tải driver MySQL
        Class.forName(dbDriver);


        return DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
    }

    public static void main(String[] args) {
        // Kết nối và xử lý truy vấn trong try-with-resources để tự động đóng tài nguyên
        try {

            Connection conn = DbConnection.initializeDatabase();
            Statement stmt = conn.createStatement();


            String query = "SELECT id, username, email, role FROM users";
            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {
                System.out.println("Ket noi thanh cong");
            } else {
                System.out.println("Ket noi that bai");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}