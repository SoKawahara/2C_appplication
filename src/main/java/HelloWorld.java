import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
public class HelloWorld extends HttpServlet {
 public HelloWorld() {}
 protected void doGet(HttpServletRequest request,
 HttpServletResponse response)
 throws ServletException, IOException {
	 String url = "/WEB-INF/views/output.jsp";
	 
	 request.setCharacterEncoding("UTF-8");
	 response.setContentType("text/html; charset=UTF-8");
	 RequestDispatcher dispatcher 
	   = getServletContext().getRequestDispatcher(url);
	 dispatcher.forward(request,  response);
 }
}