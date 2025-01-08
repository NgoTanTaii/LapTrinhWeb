package Controller;

import Dao.AppointmentDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/updateContactedStatus")
public class UpdateContactedStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, IOException {
        // Lấy danh sách các tham số gửi từ form
        Enumeration<String> parameterNames = request.getParameterNames();

        // Duyệt qua từng tham số
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();

            // Kiểm tra nếu tên tham số bắt đầu với "contacted_"
            if (paramName.startsWith("contacted_")) {
                // Lấy ID của lịch hẹn từ tên tham số (ví dụ: contacted_1 -> ID = 1)
                int appointmentId = Integer.parseInt(paramName.split("_")[1]);

                // Lấy giá trị của checkbox (1 nếu được chọn, null nếu không chọn)
                String value = request.getParameter(paramName);
                int contacted = (value != null) ? 1 : 0;

                // Cập nhật trạng thái "Đã Liên Lạc" trong cơ sở dữ liệu
                // Giả sử bạn có phương thức updateContactedStatus trong DAO để cập nhật DB
                AppointmentDAO appointmentDAO = new AppointmentDAO();
                appointmentDAO.updateContactedStatus(appointmentId, contacted);
            }
        }

        // Sau khi cập nhật, chuyển hướng lại trang danh sách lịch hẹn
        response.sendRedirect("appointment-manager");
    }
}
