package ckfinder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CKFinderController {

    @GetMapping("/test")
    public String showForm() {
        // Trả về trang JSP chứa CKFinder
        return "test";
    }

    @PostMapping("/upload")
    public String uploadFile() {
        // Xử lý upload tệp (nếu có)
        return "redirect:/test"; // Chuyển hướng trở lại trang test
    }
}
