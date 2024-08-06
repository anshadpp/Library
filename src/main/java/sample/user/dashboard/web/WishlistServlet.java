package sample.user.dashboard.web;

import sample.user.dashboard.database.WishlistDao;
import sample.user.dashboard.model.ViewUUpload;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WishlistDao wishlistDao;

    public WishlistServlet() {
        // Default constructor if needed
    }

    // Constructor to accept WishlistDao
    public WishlistServlet(WishlistDao wishlistDao) {
        this.wishlistDao = wishlistDao;
    }

    public void init() {
        if (wishlistDao == null) { 
            wishlistDao = new WishlistDao(); // Initialize if not set externally
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userIdParam = request.getParameter("id");
        
        if (userIdParam != null) {
            try {
                int userId = Integer.parseInt(userIdParam);
                List<ViewUUpload> wishlistBooks = wishlistDao.getWishlist(userId);

                request.setAttribute("wishlistBooks", wishlistBooks);
                request.setAttribute("userId", userId);

                RequestDispatcher dispatcher = request.getRequestDispatcher("wishlist.jsp");
                dispatcher.forward(request, response);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID format");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    public boolean removeBookFromWishlist(int userId, int bookId) {
        return wishlistDao.deleteFromWishlist(userId, bookId);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
