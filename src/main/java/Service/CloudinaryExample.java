package Service;

import java.io.File;
import java.io.IOException;

public class CloudinaryExample {
    public static void main(String[] args) {
        CloudinaryService cloudinaryService = new CloudinaryService();

        // Đường dẫn tới file ảnh cần upload
        File imageFile = new File("C:\\Users\\Linh Luu\\Downloads\\IMG_0176.JPG");

        try {
            // Upload ảnh
            String imageUrl = cloudinaryService.uploadImage(imageFile);
            System.out.println("Ảnh đã upload thành công: " + imageUrl);

            // Xóa ảnh (nếu cần)
            String publicId = "your-image-public-id"; // Thay thế với publicId của ảnh bạn muốn xóa
            cloudinaryService.deleteImage(publicId);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
