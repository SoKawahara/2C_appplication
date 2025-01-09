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
public class ViewTrip extends HttpServlet {
 public ViewTrip() {}
 protected void doGet(HttpServletRequest request,
 HttpServletResponse response)
 throws ServletException, IOException {
	 List<List<String>> todos = new ArrayList<>();
	 List<List<String>> memories = new ArrayList<>();
	 List<String> trip_info = new ArrayList<>();
	 String member_names = "";//これは取得してきたメンバーの名前の情報を入れるための変数
	 
	 String server = "//172.21.37.48:5432/";
	 String database = "todo_database";
	 String database_url = "jdbc:postgresql:" + server + database;
	 
	 String full_path = String.valueOf(request.getRequestURL());
	 
	 //ここから下にデータベースに接続する為の処理を書く
	 try {
		 Class.forName("org.postgresql.Driver");
		 Connection con = DriverManager.getConnection(database_url , "al22016" , "bond");
		 
		 //繰り返し使用するPreparedStatementを作成する
		 int prestmt_number = Integer.parseInt(full_path.substring(full_path.length()-1));
		 
		//ここで旅行先、日付を取得する
		 PreparedStatement prestmt_trip;
		 String get_trip_info = "select cast(trip_number as varchar) as trip_number , destination , cast(departure_day as varchar) as departure_day , cast(return_day as varchar) as return_day from trip where trip_number = ?";
		 prestmt_trip = con.prepareStatement(get_trip_info);
		 prestmt_trip.setInt(1, prestmt_number);
		 ResultSet result_trip_info = prestmt_trip.executeQuery();
		 while (result_trip_info.next()) {
			trip_info.add(result_trip_info.getString("TRIP_NUMBER"));
			trip_info.add(result_trip_info.getString("DESTINATION"));
			trip_info.add(result_trip_info.getString("DEPARTURE_DAY"));
			trip_info.add(result_trip_info.getString("RETURN_DAY"));
		 }
		 prestmt_trip.close();
		 
		 
		 //ここで旅行に参加しているメンバーを取得する
		 PreparedStatement prestmt_member;
		 String get_members = "select * from member where member_id in (select member_id from trip_member where trip_number = ?)";
		 prestmt_member = con.prepareStatement(get_members);
		 prestmt_member.setInt(1, prestmt_number);
		 ResultSet result_members = prestmt_member.executeQuery();
		 while (result_members.next()) {
			 //ここでは取得してきたメンバーの名前を「・」で繋いでいる
			 member_names = member_names + result_members.getString("NAME") + "・";
		 }
		 prestmt_member.close();
		 
		 //ここに現在登録されているTodoを取得する
		 PreparedStatement prestmt_todo;
		 String get_todos = "select * from todo where trip_number in (select trip_number from trip where trip_number = ?)";
		 prestmt_todo = con.prepareStatement(get_todos);
		 prestmt_todo.setInt(1, prestmt_number);
		 ResultSet result_todos = prestmt_todo.executeQuery();
		 while (result_todos.next()) {
			 List<String> tmp_list = new ArrayList<>();
			 tmp_list.add(result_todos.getString("TODO_NAME"));
			 tmp_list.add((String)result_todos.getString("TODO_ID"));
			 tmp_list.add((String)result_todos.getString("TRIP_NUMBER"));
			 todos.add(tmp_list);
		 }
		 prestmt_todo.close();
		 
		 //ここに現在登録されている思い出を取得する
		 PreparedStatement prestmt_memory;
		 String get_memories = "select * from memory where trip_number in (select trip_number from trip where trip_number = ?)";
		 prestmt_memory = con.prepareStatement(get_memories);
		 prestmt_memory.setInt(1, prestmt_number);
		 ResultSet result_memories = prestmt_memory.executeQuery();
		 while (result_memories.next()) {
			 List<String> tmp_memories = new ArrayList<>();
			 tmp_memories.add(String.valueOf(result_memories.getInt("TRIP_NUMBER")));
			 tmp_memories.add(String.valueOf(result_memories.getInt("MEMORY_ID")));
			 tmp_memories.add(String.valueOf(result_memories.getInt("MEMBER_ID")));
			 tmp_memories.add(result_memories.getString("CONTENT"));
			 memories.add(tmp_memories);
		 }
		 prestmt_memory.close();
		 con.close();
	 } catch (Exception e) {
		 e.printStackTrace();
	 }
	 
	 
	 request.setCharacterEncoding("UTF-8");
	 response.setContentType("text/html; charset=UTF-8");
	 
	 request.setAttribute("trip_info", trip_info);
	 request.setAttribute("get_todos", todos);
	 request.setAttribute("memories" , memories);
	 request.setAttribute("member_names", member_names);
	 
	 //ここで残りの処理をjspファイルに投げている
	 String url = "/WEB-INF/views/output.jsp";
	 RequestDispatcher dispatcher 
	   = getServletContext().getRequestDispatcher(url);
	 dispatcher.forward(request,  response);
 }
}