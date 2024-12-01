let slideIndex = 0;

function showSlides() {
    let slides = document.getElementsByClassName("mySlides");

    // Ẩn tất cả các slide
    for (let i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }

    // Tăng index để hiển thị slide tiếp theo
    slideIndex++;

    // Nếu đến cuối danh sách thì quay lại slide đầu tiên
    if (slideIndex > slides.length) {
        slideIndex = 1;
    }

    // Hiển thị slide hiện tại
    slides[slideIndex - 1].style.display = "block";

    // Tự động chuyển slide sau 3 giây
    setTimeout(showSlides, 60000);
}

// Gọi hàm để bắt đầu slideshow
showSlides();
