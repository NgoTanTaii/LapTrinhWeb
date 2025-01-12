<%
    // Sử dụng biến session có sẵn trong JSP
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng đến trang không có quyền truy cập
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<%@ page import="Entity.DepositOrder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit Manager</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<div class="container">
    <h2 class="mt-4">Quản Lý Đặt Cọc</h2>
    <hr>

    <!-- Bảng hiển thị các deposit -->
    <table class="table table-striped">
        <thead>
        <tr>
            <th>#</th>
            <th>ID Người Dùng</th>
            <th>ID Tài Sản</th>
            <th>Số Tiền Đặt Cọc</th>
            <th>Ngày Đặt Cọc</th>
            <th>Trạng Thái</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<DepositOrder> deposits = (List<DepositOrder>) request.getAttribute("deposits");
            // Sử dụng NumberFormat để định dạng tiền tệ
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            currencyFormat.setCurrency(java.util.Currency.getInstance("VND"));

            if (deposits != null && !deposits.isEmpty()) {
                for (DepositOrder deposit : deposits) {
                    // Lấy giá trị depositAmount và chuyển đổi từ BigDecimal sang double
                    BigDecimal amount = new BigDecimal(String.valueOf(deposit.getDepositAmount())); // Assuming depositAmount is a BigDecimal
                    double amountDouble = amount.doubleValue();

                    // Chuyển đổi số tiền thành triệu hoặc tỷ
                    String formattedAmount;
                    if (amountDouble >= 1_000_000_000) {
                        formattedAmount = currencyFormat.format(amountDouble / 1_000_000_000) + " tỷ"; // Chuyển thành tỷ
                    } else if (amountDouble >= 1_000_000) {
                        formattedAmount = currencyFormat.format(amountDouble / 1_000_000) + " triệu"; // Chuyển thành triệu
                    } else {
                        formattedAmount = currencyFormat.format(amountDouble); // Định dạng bình thường
                    }

                    // Chuyển trạng thái sang tiếng Việt
                    String statusInVietnamese = "";
                    switch (deposit.getStatus()) {
                        case "pending":
                            statusInVietnamese = "Đang chờ";
                            break;
                        case "process":
                            statusInVietnamese = "Đã xác nhận";
                            break;
                        case "cancel":
                            statusInVietnamese = "Đã hủy";
                            break;
                    }
        %>
        <tr id="deposit-<%= deposit.getId() %>">
            <td><%= deposit.getId() %>
            </td>
            <td><%= deposit.getUserId() %>
            </td>
            <td><%= deposit.getPropertyId() %>
            </td>
            <td><%= formattedAmount %>
            </td>
            <td><%= deposit.getDepositDate() %>
            </td>
            <td id="status-<%= deposit.getId() %>"><%= statusInVietnamese %>
            </td>
            <td>
                <!-- Actions for managing deposits -->
                <form action="updateDepositStatus" method="POST" style="display:inline;"
                      id="confirm-form-<%= deposit.getId() %>">
                    <input type="hidden" name="depositId" value="<%= deposit.getId() %>">
                    <% if (!"process".equals(deposit.getStatus()) && !"cancel".equals(deposit.getStatus())) { %>
                    <button type="button" class="btn btn-success btn-sm confirm-button" data-id="<%= deposit.getId() %>"
                            data-status="confirmed">Xác Nhận
                    </button>
                    <% } %>
                </form>
                <form action="updateDepositStatus" method="POST" style="display:inline;"
                      id="reject-form-<%= deposit.getId() %>">
                    <input type="hidden" name="depositId" value="<%= deposit.getId() %>">
                    <% if (!"cancel".equals(deposit.getStatus()) && !"process".equals(deposit.getStatus())) { %>
                    <button type="button" class="btn btn-danger btn-sm reject-button" data-id="<%= deposit.getId() %>"
                            data-status="rejected">Hủy
                    </button>
                    <% } %>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="7">Không có deposit nào.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script>
    $(document).ready(function () {
        // Xử lý hành động xác nhận
        $('.confirm-button').click(function () {
            var depositId = $(this).data('id');
            var status = $(this).data('status');
            $.ajax({
                url: 'updateDepositStatus',
                type: 'POST',
                data: {depositId: depositId, status: status},
                success: function (response) {
                    if (response.success) {
                        // Cập nhật trạng thái ngay lập tức
                        $('#status-' + depositId).text("Đã xác nhận");
                        $('#confirm-form-' + depositId).find('button').prop('disabled', true);
                        $('#reject-form-' + depositId).find('button').prop('disabled', true);
                        alert("Đặt cọc đã được xác nhận!");
                    } else {
                        alert("Có lỗi xảy ra khi xác nhận đặt cọc: " + response.message);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Lỗi kết nối đến máy chủ! Chi tiết: " + textStatus + " - " + errorThrown);
                }
            });
        });

        // Xử lý hành động hủy
        $('.reject-button').click(function () {
            var depositId = $(this).data('id');
            var status = $(this).data('status');
            $.ajax({
                url: 'updateDepositStatus',
                type: 'POST',
                data: {depositId: depositId, status: status},
                success: function (response) {
                    if (response.success) {
                        // Cập nhật trạng thái ngay lập tức
                        $('#status-' + depositId).text("Đã hủy");
                        $('#confirm-form-' + depositId).find('button').prop('disabled', true);
                        $('#reject-form-' + depositId).find('button').prop('disabled', true);
                        alert("Đặt cọc đã bị hủy!");
                    } else {
                        alert("Có lỗi xảy ra khi hủy đặt cọc: " + response.message);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Lỗi kết nối đến máy chủ! Chi tiết: " + textStatus + " - " + errorThrown);
                }
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
