function openModal() {
    document.getElementById("contact-agent.jsp").style.display = "block";
}

// Đóng modal
function closeModal() {
    document.getElementById("contactModal").style.display = "none";
}

// Đảm bảo rằng người dùng có thể đóng modal khi bấm ra ngoài
window.onclick = function (event) {
    if (event.target == document.getElementById("contactModal")) {
        closeModal();
    }
}


// Hàm lọc các tư vấn viên theo thành phố
function filterConsultants() {
    var city = document.getElementById('city').value; // Lấy giá trị thành phố từ dropdown
    var consultantCards = document.querySelectorAll('.consultant-card'); // Lấy tất cả các thẻ tư vấn viên

    consultantCards.forEach(function (card) {
        var cardCity = card.getAttribute('data-city'); // Lấy thông tin thành phố của tư vấn viên

        // Kiểm tra xem thành phố của tư vấn viên có khớp với lựa chọn không
        if (city === "" || cardCity === city) {
            card.style.display = "block"; // Hiển thị nếu khớp
        } else {
            card.style.display = "none"; // Ẩn nếu không khớp
        }
    });
}



