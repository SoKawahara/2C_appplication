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

public class DeleteAbout extends HttpServlet {
	public DeleteAbout() {}
	public void doGet(HttpServletRequest request , 
			           HttpServletResponse response)
	    throws IOException , ServletException
	    {
		  //送信されてきたクエリパラメータから旅行番号を特定する
		  String params_trip_number = request.getParameter("trip_number");
		  
		  // DB接続のためのアドレスなど
		  String server = "//172.21.37.48:5432/";
		  String database_url = "todo_database";
		  
		  //JSPファイルで使用するための変数
		  //[名前,ID]を持つ
		  List<List<String>> delete_about = new ArrayList<>();
		  
		  
		  
		  
		  
		  //System.out.println("aaaaa");
		  
		  try {
				 Class.forName("org.postgresql.Driver");
				 Connection con = DriverManager.getConnection("jdbc:postgresql:" + server + database_url , "al22016" , "bond");
				  
				 //参加していないメンバーを取得する処理を書く
				 PreparedStatement prestmt;
				 String get_members = 	"SELECT m.name, m.member_id " + 
	                     				"FROM member m " + 
	                     				"WHERE m.member_id IN ( " + 
	                     				"    SELECT tm.member_id " + 
	                     				"    FROM trip_member tm " + 
	                     				"    WHERE tm.trip_number = ? " + 
	                     				")" +
	                     				"ORDER BY m.member_id ASC" ;
				 prestmt = con.prepareStatement(get_members);
				 prestmt.setInt(1, Integer.parseInt(params_trip_number));

				 ResultSet result_members = prestmt.executeQuery();
				 
				 
				 
				 while(result_members.next()) {
					 List<String> tmplist = new ArrayList<>();
					 tmplist.add(result_members.getString(1));
					 tmplist.add(result_members.getString(2));
					 tmplist.add(params_trip_number);
					 delete_about.add(tmplist);
				 }
				 	 
				 prestmt.close();
				 con.close();
			 } catch (Exception e) {
				 e.printStackTrace();
			 }
		  
		  
		  
		  String url = "/WEB-INF/views/delete_about.jsp";
		  response.setContentType("text/html; charset=UTF-8");
		  
	 
		  request.setAttribute("delete_about", delete_about);
		  request.setAttribute("params_trip_number", params_trip_number);
		  //ここで残りの処理をjspファイルに投げている
		  RequestDispatcher dispatcher 
			  = getServletContext().getRequestDispatcher(url);
		  dispatcher.forward(request,  response);
		
	    }
	    
}