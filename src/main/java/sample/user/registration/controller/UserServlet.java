package sample.user.registration.controller;
import java.io.IOException;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sample.user.resgistration.dao.UserDao;
import sample.user.resgistration.model.Users;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/register")

public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserDao userDao =new UserDao();

    /**
     * Default constructor. 
     */
    public UserServlet() {
    	super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/userregister.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		
		
		
		
		
		
		Users user= new Users();
		user.setName(name);
		user.setUsername(username);
		user.setEmail(email);
		user.setPhone(phone);
		user.setPassword(password);
		
		
		
        try {
            int result = userDao.registerUser(user);
            if (result == -1) {
                // Duplicate entry error
                request.setAttribute("error", "Username or Email already exists.");
                request.getRequestDispatcher("/WEB-INF/views/userregister.jsp").forward(request, response);
            } else {
            	request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

		RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);
		
	}

}
