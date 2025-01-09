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
</head>
<body>
<div class="container">
    <h2 class="mt-4">Deposit Management</h2>
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
        %>
        <tr>
            <td><%= deposit.getId() %></td>
            <td><%= deposit.getUserId() %></td>
            <td><%= deposit.getPropertyId() %></td>
            <td><%= formattedAmount %></td>
            <td><%= deposit.getDepositDate() %></td>
            <td><%= deposit.getStatus() %></td>
            <td>
                <!-- Actions for managing deposits -->
                <form action="updateDepositStatus" method="POST" style="display:inline;">
                    <input type="hidden" name="depositId" value="<%= deposit.getId() %>">
                    <button type="submit" class="btn btn-success btn-sm" name="status" value="confirmed">Confirm</button>
                </form>
                <form action="updateDepositStatus" method="POST" style="display:inline;">
                    <input type="hidden" name="depositId" value="<%= deposit.getId() %>">
                    <button type="submit" class="btn btn-danger btn-sm" name="status" value="rejected">Reject</button>
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

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
