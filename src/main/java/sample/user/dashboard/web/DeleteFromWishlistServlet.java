package sample.user.dashboard.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sample.user.dashboard.database.WishlistDao;

@WebServlet("/deleteFromWishlist")
public class DeleteFromWishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private WishlistDao wishlistDao = new WishlistDao();
    private WishlistServlet wishlistService = new WishlistServlet(wishlistDao);

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookIdParam = request.getParameter("bookId");
        String userIdParam = request.getParameter("userId");

        int bookId = Integer.parseInt(bookIdParam);
        int userId = Integer.parseInt(userIdParam);

        try {
            boolean removed = wishlistService.removeBookFromWishlist(userId, bookId);

            if (removed) {
                response.sendRedirect("wishlist?id=" + userId + "&status=removed");
            } else {
                response.sendRedirect("wishlist?id=" + userId + "&status=error");
            }
        } catch (Exception e) {
            response.sendRedirect("wishlist?id=" + userId + "&status=error");
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
