package DBcontext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {

    // Thông tin kết nối cơ sở dữ liệu
    private static final String URL = "jdbc:mysql://localhost:3306/webbds?useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Phương thức kết nối cơ sở dữ liệu
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
