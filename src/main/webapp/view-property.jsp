<%@ page import="Entity.Property1" %>
<%@ page import="Dao.PropertyDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String propertyId = request.getParameter("property_id");
    if (propertyId == null || propertyId.isEmpty()) {
        out.print("ID bất động sản không hợp lệ.");
        return;
    }

    PropertyDAO propertyDAO = new PropertyDAO();
    Property1 property = propertyDAO.getPropertyById(Integer.parseInt(propertyId));

    if (property == null) {
        out.print("Không tìm thấy bất động sản.");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Bất Động Sản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .property-field {
            margin-bottom: 15px;
            color: #333;
        }

        .property-label {
            font-weight: bold;
        }

        .property-value {
            margin-left: 10px;
            color: #555;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007BFF;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Chi tiết Bất Động Sản</h2>

    <div class="property-field">
        <span class="property-label">ID:</span>
        <span class="property-value"><%= property.getId() %></span>
    </div>

    <div class="property-field">
        <span class="property-label">Tên:</span>
        <span class="property-value"><%= property.getTitle() %></span>
    </div>

    <div class="property-field">
        <span class="property-label">Giá :</span>
        <span class="property-value">
        <%
            String price = "";
            if ("2".equals(property.getStatus())) {
                // Nếu trạng thái là cho thuê, hiển thị giá theo đơn vị triệu
                price = property.getPrice() + " triệu" ;
            } else {
                // Nếu trạng thái không phải là cho thuê, hiển thị giá bình thường
                price = property.getPrice() + " tỷ VNĐ";
            }
        %>
        <%= price %>
    </span>
    </div>


    <div class="property-field">
        <span class="property-label">Địa chỉ:</span>
        <span class="property-value"><%= property.getAddress() %></span>
    </div>

    <div class="property-field">
        <span class="property-label">Diện tích (m²):</span>
        <span class="property-value"><%= property.getArea() %></span>
    </div>

    <div class="property-field">
        <span class="property-label">Hình Ảnh:</span>
        <span class="property-value">
        <img src="<%= property.getImageUrl() %>" alt="Hình ảnh Bất Động Sản" style="max-width: 100%; height: auto;">
    </span>
    </div>


    <div class="property-field">
        <span class="property-label">Mô tả:</span>
        <span class="property-value"><%= property.getDescription() %></span>
    </div>

    <div class="property-field">
        <span class="property-label">Loại sản phẩm:</span>
        <span class="property-value"><%= property.getType() %></span>
    </div>

    <div class="property-field">
        <span class="property-label">Trạng thái:</span>
        <span class="property-value">
        <%
            String statusDescription = "";
            String status = property.getStatus(); // Lấy giá trị trạng thái

            // Kiểm tra trạng thái và mô tả
            switch (status) {
                case "1":
                    statusDescription = "Nhà đất bán";
                    break;
                case "2":
                    statusDescription = "Nhà đất cho thuê";
                    break;
                case "3":
                    statusDescription = "Dự án";
                    break;

                default:
                    statusDescription = "Trạng thái không xác định";
                    break;
            }
        %>
        <%= statusDescription %>
    </span>
    </div>


    <a href="home-manager" class="back-link">Quay lại</a>
</div>

</body>
</html>
