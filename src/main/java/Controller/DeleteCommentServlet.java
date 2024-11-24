package Controller;

import Dao.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteCommentServlet")
public class DeleteCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentIdParam = request.getParameter("commentId");
        String redirectPage = request.getParameter("redirectPage"); // New parameter to determine where to redirect

        if (commentIdParam != null) {
            int commentId = Integer.parseInt(commentIdParam);
            CommentDAO commentDAO = new CommentDAO();
            boolean success = commentDAO.deleteComment(commentId);

            if (success) {
                request.setAttribute("message", "Comment deleted successfully.");
            } else {
                request.setAttribute("message", "Failed to delete comment.");
            }
        }

        // Redirect based on the `redirectPage` parameter
        if ("commentsManager".equals(redirectPage)) {
            response.sendRedirect("comments-manager.jsp");
        } else {
            // Assuming `propertyId` is passed if the delete action comes from `property-detail.jsp`
            String propertyId = request.getParameter("propertyId");
            response.sendRedirect("property-detail.jsp?id=" + propertyId);
        }
    }
}
