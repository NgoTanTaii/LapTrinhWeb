// Mở modal
function openModal() {
    document.getElementById("contactModal").style.display = "block";
}

// Đóng modal
function closeModal() {
    document.getElementById("contactModal").style.display = "none";
}

// Đảm bảo rằng người dùng có thể đóng modal khi bấm ra ngoài
window.onclick = function(event) {
    if (event.target == document.getElementById("contactModal")) {
        closeModal();
    }
}