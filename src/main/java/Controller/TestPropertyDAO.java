package Controller;

import Dao.PropertyDAO;
import Entity.Property1;
import java.util.Arrays;
import java.util.List;

public class TestPropertyDAO {
    public static void main(String[] args) {
        // Thành phố cần kiểm tra
        String city = "TP.HCM";
        int limit = 5; // Số lượng sản phẩm muốn kiểm tra

        // Khởi tạo PropertyDAO
        PropertyDAO PropertyDAO = new PropertyDAO();

        // Lấy danh sách bất động sản có giá cao nhất
        List<Property1> highestPriceProperties = PropertyDAO.getHighestPriceProperties(city, limit);
        // Lấy danh sách bất động sản có diện tích lớn nhất
        List<Property1> largestAreaProperties = PropertyDAO.getLargestAreaProperties(city, limit);

        // In kết quả ra console cho bất động sản có giá cao nhất
        System.out.println("Sản phẩm có giá cao nhất từ thành phố " + city + ":");
        if (highestPriceProperties.isEmpty()) {
            System.out.println("Không có sản phẩm nào.");
        } else {
            for (Property1 property : highestPriceProperties) {
                System.out.println("Tên: " + property.getTitle());
                System.out.println("Giá: " + property.getPrice() + " tỷ");
                System.out.println("Diện tích: " + property.getArea() + " m²");
                System.out.println("Địa chỉ: " + property.getAddress());
                System.out.println("Ảnh: " + property.getImageUrl());
                System.out.println("--------------------------");
            }
        }

        // In kết quả ra console cho bất động sản có diện tích lớn nhất
        System.out.println("Sản phẩm có diện tích lớn nhất từ thành phố " + city + ":");
        if (largestAreaProperties.isEmpty()) {
            System.out.println("Không có sản phẩm nào.");
        } else {
            for (Property1 property : largestAreaProperties) {
                System.out.println("Tên: " + property.getTitle());
                System.out.println("Giá: " + property.getPrice() + " tỷ");
                System.out.println("Diện tích: " + property.getArea() + " m²");
                System.out.println("Địa chỉ: " + property.getAddress());
                System.out.println("Ảnh: " + property.getImageUrl());
                System.out.println("--------------------------");
            }
        }
    }
}
