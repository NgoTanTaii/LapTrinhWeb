package Controller;

import Dao.PropertyBystatusDAO;
import Entity.Property1;

import java.util.List;

public class PropertyBystatusDAOTest {
    public static void main(String[] args) {
        // Khởi tạo đối tượng DAO
        PropertyBystatusDAO dao = new PropertyBystatusDAO();

        // Thiết lập trạng thái cần tìm kiếm, ví dụ status = 1
        int status = 1;

        // Gọi phương thức getPropertiesByStatus để lấy danh sách bất động sản
        List<Property1> properties = dao.getPropertiesByStatus(status);

        // Kiểm tra và in ra danh sách bất động sản
        if (properties != null && !properties.isEmpty()) {
            System.out.println("Danh sách bất động sản có status = " + status + ":");
            for (Property1 property : properties) {
                System.out.println("ID: " + property.getId());
                System.out.println("Tiêu đề: " + property.getTitle());
                System.out.println("Diện tích: " + property.getArea());
                System.out.println("Địa chỉ: " + property.getAddress());
                System.out.println("Mô tả: " + property.getDescription());
                System.out.println("Loại: " + property.getType());
                System.out.println("Trạng thái: " + property.getStatus());
                System.out.println(property.getImageUrl());
                System.out.println("---------------");
            }
        } else {
            System.out.println("Không có bất động sản nào có status = " + status);
        }
    }
}
