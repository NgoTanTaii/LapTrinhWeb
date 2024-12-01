package Dao;



import DBcontext.Database;
import Entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {

    public User login(String user, String pass) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection connection = Database.getConnection();
             PreparedStatement pst = connection.prepareStatement(query)) {

            // Thiết lập giá trị cho câu lệnh SQL
            pst.setString(1, user);
            pst.setString(2, pass);

            // Thực thi câu lệnh truy vấn
            ResultSet rs = pst.executeQuery();

            // Nếu tìm thấy kết quả trả về, tạo đối tượng User
            if (rs.next()) {
                User u = new User(rs.getString("username"), rs.getString("password"));
                return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }


        return null;
    }
}





