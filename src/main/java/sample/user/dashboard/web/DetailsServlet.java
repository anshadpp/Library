package sample.user.dashboard.web;

import sample.user.dashboard.database.DetailsDao;

import sample.user.dashboard.model.ViewUUpload;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/details")
public class DetailsServlet extends HttpServlet{
	   	private static final long serialVersionUID = 1L;

	    private DetailsDao detailsDao;

	    @Override
	    public void init() throws ServletException {
	        detailsDao = new DetailsDao();
	    }

	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String bookId = request.getParameter("bookId");
	        System.out.println(bookId);
	        
	        if (bookId != null && !bookId.isEmpty()) {
	            try {
	                int id = Integer.parseInt(bookId);
	                ViewUUpload book = detailsDao.getBookById(id);
	                
	                
	                if (book != null) {
	                    request.setAttribute("book", book);
	                    request.getRequestDispatcher("/details.jsp").forward(request, response);
	                } else {
	                	System.out.println("error"); // redirect to an error page if book not found
	                }
	            } catch (NumberFormatException e) {
	            	System.out.println("error"); // redirect to an error page if bookId is not a valid integer
	            }
	        } else {
	        	System.out.println("error");// redirect to an error page if bookId is null or empty
	        }
	    }
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Handle the read book action
	        String bookId = request.getParameter("bookId");
	        
	        if (bookId != null && !bookId.isEmpty()) {
	            try {
	                int id = Integer.parseInt(bookId);
	                // Redirect to the page or functionality for reading the book
	                response.sendRedirect("readBook?bookId=" + id);
	            } catch (NumberFormatException e) {
	            	System.out.println("error"); // redirect to an error page if bookId is not a valid integer
	            }
	        } else {
	        	System.out.println("error"); // redirect to an error page if bookId is null or empty
	        }
	    }
	}

