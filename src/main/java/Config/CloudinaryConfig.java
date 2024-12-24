package Config;



public class CloudinaryConfig {

    public static Cloudinary cloudinary() {
        // Sử dụng đúng phương thức ObjectUtils.asMap() để cấu hình Cloudinary
        return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dg0f7bdho", // Thay thế bằng Cloud Name của bạn
                "api_key", "551574467338612", // Thay thế bằng API Key của bạn
                "api_secret", "c_u8F_nzao8gzflLQtx9lvOnsEw" // Thay thế bằng API Secret của bạn
        ));
    }
}
