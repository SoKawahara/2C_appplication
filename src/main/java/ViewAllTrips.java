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

public class ViewAllTrips extends HttpServlet {
	public ViewAllTrips() {}
	public void doGet(HttpServletRequest request,
			           HttpServletResponse response)
	   throws IOException , ServletException
	   {
		 //データベースへ接続するための情報
		 String server = "//172.21.37.48:5432/";
		 String database = "todo_database";
		 String database_url = "jdbc:postgresql:" + server + database;
		 
		 //旅行情報を格納するためのリスト
		 List<List<String>> all_trips = new ArrayList<>();
		 
		 try {
			 Class.forName("org.postgresql.Driver");
			 Connection con = DriverManager.getConnection(database_url , "al22016" , "bond");
			 
			 Statement stmt = con.createStatement();
			 String get_all_trips = "select cast(trip_number as varchar) as trip_number , destination from trip";
			 ResultSet rs = stmt.executeQuery(get_all_trips);
			 
			 while (rs.next()) {
				 List<String> each_trip = new ArrayList<>();
				 each_trip.add(rs.getString("TRIP_NUMBER"));
				 each_trip.add(rs.getString("DESTINATION"));
				 all_trips.add(each_trip);
			 }
			 con.close();
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		//ここで残りの処理をjspファイルに投げている
		 String url = "/WEB-INF/views/index.jsp";
		 
		 request.setAttribute("all_trips" , all_trips);
		 RequestDispatcher dispatcher 
		   = getServletContext().getRequestDispatcher(url);
		 dispatcher.forward(request,  response);
	   }
}
