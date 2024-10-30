package DBcontext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private static final String URL = "jdbc:mysql://localhost:3306/webbds"; // Thay bằng URL cơ sở dữ liệu của bạn
    private static final String USER = "root"; // Tên người dùng của bạn
    private static final String PASSWORD = ""; // Mật khẩu của bạn

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
