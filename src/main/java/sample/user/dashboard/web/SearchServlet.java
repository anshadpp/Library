package sample.user.dashboard.web;

import sample.user.dashboard.database.SearchDoa;
import sample.user.dashboard.model.ViewUUpload;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private SearchDoa searchDoa;

    @Override
    public void init() throws ServletException {
    	searchDoa = new SearchDoa();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        List<ViewUUpload> books;
		try {
			books = SearchDoa.searchBooks(query);
			request.setAttribute("books", books);
	        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    }
}
