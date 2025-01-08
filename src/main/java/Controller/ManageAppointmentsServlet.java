package Controller;

import DBcontext.Database;
import Entity.Appointment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/appointment-manager")
public class ManageAppointmentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy danh sách lịch hẹn từ DB
        List<Appointment> appointments = getAppointments();

        // Truyền danh sách lịch hẹn vào JSP để hiển thị
        request.setAttribute("appointments", appointments);

        // Forward request đến trang appointments.jsp để hiển thị thông tin
        request.getRequestDispatcher("appointment-manager.jsp").forward(request, response);
    }

    // Lấy danh sách lịch hẹn từ cơ sở dữ liệu
    private List<Appointment> getAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String query = "SELECT * FROM appointments";

        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Appointment appointment = new Appointment(
                        rs.getInt("id"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("appointment_date"),
                        rs.getString("appointment_time"),
                        rs.getInt("property_count"),
                        rs.getString("created_at"),
                        rs.getString("username"),
                        rs.getInt("contacted")
                );
                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointments;
    }
}
