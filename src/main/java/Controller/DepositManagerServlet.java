    package Controller;

    import Dao.DepositOrderDAO;
    import Entity.DepositOrder;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;

    import java.io.IOException;
    import java.sql.SQLException;
    import java.util.List;

    @WebServlet("/depositManager")
    public class DepositManagerServlet extends HttpServlet {
        private DepositOrderDAO depositOrderDAO;

        @Override
        public void init() {
            depositOrderDAO = new DepositOrderDAO();
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                // Fetch the list of deposits
                List<DepositOrder> deposits = depositOrderDAO.getAllDeposits();
                // Set the list as a request attribute
                request.setAttribute("deposits", deposits);
                // Forward to the JSP
                request.getRequestDispatcher("deposited-manager.jsp").forward(request, response);
            } catch (SQLException e) {
                // Handle exceptions here (e.g., log it and forward to an error page)
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error retrieving deposits: " + e.getMessage());
                request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
            }
        }
    }
