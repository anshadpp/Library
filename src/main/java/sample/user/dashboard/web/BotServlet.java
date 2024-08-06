package sample.user.dashboard.web;



import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/BotServlet")
public class BotServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Map<String, String> botResponses = new HashMap<>();

    static {
        botResponses.put("How to view Previous uploads?", "You can see the option in upload tabs drawer.");
        botResponses.put("How to buy a book?", "To buy a book, click the book image and then click buy button.");
        botResponses.put("How to upload a book?", "You can upload a book by clicking on the 'Upload' button in drawer.");
        botResponses.put("How to contact support?", "You can contact us via email at support@yourlibrary.com.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String question = request.getParameter("question");
        String answer = botResponses.getOrDefault(question, "Sorry, I don't have an answer for that.");
        response.setContentType("text/plain");
        response.getWriter().write(answer);
    }
}
