package sample.user.dashboard.web;


import sample.user.dashboard.database.*;
import sample.user.dashboard.model.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardDao dashboardDao;

    public void init() {
        dashboardDao = new DashboardDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false); // Do not create a new session if it doesn't exist

        if (session != null && session.getAttribute("username") != null) {
        	
        String username = (String) session.getAttribute("username");
    	List<Books> books = dashboardDao.selectAllBooks();
        for (Books book : books) {
            System.out.println("Book in servlet: " + book.getBook_name()); // Logging
        }
        
        request.setAttribute("books", books);
        request.setAttribute("username", username);
        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }else {
    	response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
