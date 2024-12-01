package Service;

import Config.CloudinaryConfig;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.File;
import java.io.IOException;
import java.util.Map;

public class CloudinaryService {
    private final Cloudinary cloudinary;

    public CloudinaryService() {
        this.cloudinary = CloudinaryConfig.cloudinary();
    }

    public String uploadImage(File imageFile) throws IOException {
        // Chỉ giữ lại các tham số hợp lệ cho upload
        Map<String, Object> uploadParams = ObjectUtils.asMap(
                "quality", "90",           // Chất lượng ảnh 90%
                "dpr", "2",                // Tăng độ phân giải cho màn hình Retina
                "fetch_format", "auto"     // Tự động chọn định dạng ảnh tối ưu (WebP, JPG, PNG...)
        );

        // Thực hiện upload và nhận kết quả trả về
        Map<String, Object> uploadResult = cloudinary.uploader().upload(imageFile, uploadParams);

        // Trả về URL của ảnh sau khi upload thành công
        return (String) uploadResult.get("secure_url");
    }


    public void deleteImage(String publicId) throws IOException {
        cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
    }
}
