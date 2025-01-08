import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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
	 List<List<String>> todos = new ArrayList<>();
	 List<List<String>> memories = new ArrayList<>();
	 String member_names = "";
	 
	 String server = "//172.21.37.48:5432/";
	 String database = "todo_database";
	 String database_url = "jdbc:postgresql:" + server + database;
	 
	 
	 //ここから下にデータベースに接続する為の処理を書く
	 try {
		 Class.forName("org.postgresql.Driver");
		 Connection con = DriverManager.getConnection(database_url , "al22016" , "bond");
		 
		 Statement stmt = con.createStatement();
		 
		 //ここで旅行に参加するメンバーを追加する処理を書く
		 String get_members = "SELECT * FROM MEMBER";
		 ResultSet result_members = stmt.executeQuery(get_members);
		 while (result_members.next()) {
			 member_names = member_names + result_members.getString("NAME") + "・";
		 }
		 
		 //ここに現在登録されているTodoを書く
		 String get_todos = "SELECT * FROM TODO";
		 ResultSet result_todos = stmt.executeQuery(get_todos);
		 while (result_todos.next()) {
			 List<String> tmp_list = new ArrayList<>();
			 tmp_list.add(result_todos.getString("TODO_NAME"));
			 tmp_list.add((String)result_todos.getString("TODO_ID"));
			 tmp_list.add((String)result_todos.getString("TRIP_NUMBER"));
			 todos.add(tmp_list);
		 }
		 
		 //ここに現在登録されている思い出を追加する
		 String get_memories = "SELECT * FROM MEMORY";
		 ResultSet result_memories = stmt.executeQuery(get_memories);
		 while (result_memories.next()) {
			 List<String> tmp_memories = new ArrayList<>();
			 tmp_memories.add(String.valueOf(result_memories.getInt("TRIP_NUMBER")));
			 tmp_memories.add(String.valueOf(result_memories.getInt("MEMORY_ID")));
			 tmp_memories.add(String.valueOf(result_memories.getInt("MEMBER_ID")));
			 tmp_memories.add(result_memories.getString("CONTENT"));
			 memories.add(tmp_memories);
		 }
		 
		 
		 stmt.close();
		 con.close();
	 } catch (Exception e) {
		 e.printStackTrace();
	 }
	 
	 
	 request.setCharacterEncoding("UTF-8");
	 response.setContentType("text/html; charset=UTF-8");
	 
	 request.setAttribute("get_todos", todos);
	 request.setAttribute("memories" , memories);
	 request.setAttribute("member_names", member_names);
	 
	 //ここで残りの処理をjspファイルに投げている
	 RequestDispatcher dispatcher 
	   = getServletContext().getRequestDispatcher(url);
	 dispatcher.forward(request,  response);
 }
}