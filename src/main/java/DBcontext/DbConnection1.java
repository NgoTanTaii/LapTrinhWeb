package DBcontext;

import java.sql.*;

public class DbConnection1 {
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Khai báo thông tin kết nối cơ sở dữ liệu
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/";
        String dbName = "mysql";
        String dbUsername = "root";  // Tài khoản MySQL của bạn
        String dbPassword = "";  // Mật khẩu MySQL của bạn


        Class.forName(dbDriver);


        return DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
    }

    public static void main(String[] args) {
        try {

            Connection conn = DbConnection1.initializeDatabase();
            Statement stmt = conn.createStatement();


            String query = "SELECT * FROM properties";
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
