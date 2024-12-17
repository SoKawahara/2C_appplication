import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
public class HelloWorld extends HttpServlet {
 public HelloWorld() {}
 protected void doGet(HttpServletRequest request,
 HttpServletResponse response)
 throws ServletException, IOException {
 PrintWriter out = response.getWriter();
 out.println(
 "<html><body>Hello World!</body></html>");
 }
}