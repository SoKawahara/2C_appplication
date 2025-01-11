import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class TodoAbout extends HttpServlet {
	public TodoAbout() {}
	public void doGet(HttpServletRequest request , 
			           HttpServletResponse response)
	    throws IOException , ServletException
	    {
		  //送信されてきたクエリパラメータからTodoを特定する
		  String params_trip_number = request.getParameter("trip_number");
		  String params_todo_id = request.getParameter("todo_id");
		  
		  // DB接続のためのアドレスなど
		  String server = "//172.21.37.48:5432/";
		  String database_url = "todo_database";
		  
		  //JSPファイルで使用するための変数
		  List<String> todo_about = new ArrayList<String>();
		  
		  try {
				 Class.forName("org.postgresql.Driver");
				 Connection con = DriverManager.getConnection("jdbc:postgresql:" + server + database_url , "al22016" , "bond");
				  
				 //ここで旅行に参加するメンバーを追加する処理を書く
				 PreparedStatement prestmt;
				 String get_members = "SELECT * FROM TODO WHERE TRIP_NUMBER = ? AND TODO_ID = ?";
				 prestmt = con.prepareStatement(get_members);
				 prestmt.setInt(1, Integer.parseInt(params_trip_number));
				 prestmt.setInt(2 ,Integer.parseInt(params_todo_id));
				 
				 ResultSet result_members = prestmt.executeQuery();
				 
				 while(result_members.next()) {
					 todo_about.add(String.valueOf(result_members.getInt(1)));
					 todo_about.add(String.valueOf(result_members.getInt(2)));
					 todo_about.add(result_members.getString(3));
					 todo_about.add(result_members.getString(4));
					 todo_about.add(String.valueOf(result_members.getInt(5)));
					 todo_about.add(String.valueOf(result_members.getBoolean(6)));
				 }
				 	 
				 prestmt.close();
				 con.close();
			 } catch (Exception e) {
				 e.printStackTrace();
			 }
		  
		  
		  
		  String url = "/WEB-INF/views/todo_about.jsp";
		  response.setContentType("text/html; charset=UTF-8");
			 
		  request.setAttribute("todo_about", todo_about);

		  //ここで残りの処理をjspファイルに投げている
		  RequestDispatcher dispatcher 
			  = getServletContext().getRequestDispatcher(url);
		  dispatcher.forward(request,  response);
		
	    }
	    
}