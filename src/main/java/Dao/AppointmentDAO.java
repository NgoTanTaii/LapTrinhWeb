package Dao;

import DBcontext.Database;
import Entity.Appointment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public static int saveAppointment(Appointment appointment) {
        String query = "INSERT INTO appointments (address, phone, appointment_date, appointment_time, property_count, created_at, username) " +
                "VALUES (?, ?, ?, ?, ?, NOW(), ?)";

        int appointmentId = -1;

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, appointment.getAddress());
            stmt.setString(2, appointment.getPhone());
            stmt.setString(3, appointment.getAppointmentDate());
            stmt.setString(4, appointment.getAppointmentTime());
            stmt.setInt(5, appointment.getPropertyCount());
            stmt.setString(6, appointment.getUsername());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        appointmentId = rs.getInt(1);  // Lấy ID của appointment vừa được tạo
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointmentId;
    }

    // Phương thức lấy tất cả các lịch hẹn từ cơ sở dữ liệu
    public static List<Appointment> getAllAppointments() {
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


    public void updateContactedStatus(int appointmentId, int contacted) {
        String query = "UPDATE appointments SET contacted = ? WHERE id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, contacted);
            stmt.setInt(2, appointmentId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


