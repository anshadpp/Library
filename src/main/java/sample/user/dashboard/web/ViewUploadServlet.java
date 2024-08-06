package sample.user.dashboard.web;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.user.dashboard.database.ViewUploadDao;
import sample.user.dashboard.model.User;
import sample.user.dashboard.model.ViewUUpload;

@WebServlet("/previousUploads")
public class ViewUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ViewUploadDao viewUploadDao;

    public void init() {
        viewUploadDao = new ViewUploadDao(); // Initialize your DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userId = Integer.parseInt(request.getParameter("id"));

        // Fetch user details based on id
       
        List<ViewUUpload> uploads = viewUploadDao.getUploadsByUserId(userId);
        
       

            if (uploads != null && !uploads.isEmpty()) {
                request.setAttribute("uploads", uploads);
                
            } else {
                request.setAttribute("message", "No uploads found for this user.");
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("previousUploads.jsp");
            dispatcher.forward(request, response);
        } 
    }

