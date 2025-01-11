import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class Trip extends HttpServlet {
	//これはCreateNewTrip内で使用するフィールド
	public String trip_name = "";
	public String departure_day = "";
	public String return_day = "";
	
	//これは作成した旅行の旅行番号を格納するための変数
	//これをクラス変数として扱うのはdoPostメソッドが使用するコンストラクタとnew_tripがしようするコンストラクタが別物であるから
	//publicフィールドはインスタンスごとに管理されるから
	static int trip_number = 0;
	public Trip() {}
	
	//これは追加の処理を行うときに使用するコンストラクタ
	public Trip(String trip_name , String departure_day , String return_day) {
		this.trip_name = trip_name;
		this.departure_day = departure_day;
		this.return_day = return_day;
	}
	
	//これは削除の処理を行うときに使用するコンストラクタ
	public Trip(int trip_number) {
		Trip.trip_number = trip_number; 
	}
	
	public void doPost(HttpServletRequest request,
			           HttpServletResponse response)
	    throws IOException , ServletException
	    {
		  //フォームで送信された値を取得することができた
		  String trip_name = request.getParameter("trip_name");
		  String departure_day = request.getParameter("departure_day");
		  String return_day = request.getParameter("return_day");
		  
		  //送信されたリクエストが旅行の追加なのか削除なのかで処理を分ける
		  String trip_status = request.getParameter("trip_status");
		  if (trip_status.equals("旅行を追加する")) {
			//追加処理を行うためのコンストラクタを用いてCreateNewTripのインスタンスを作成
			  Trip new_trip = new Trip(trip_name , departure_day , return_day);
			  int result_add_new_trip = new_trip.AddNewTrip();//ここで追加処理を行う
			  if (result_add_new_trip == 1) {
				  response.sendRedirect(request.getContextPath() + "/" + String.valueOf(Trip.trip_number));
			  } else {
				  response.sendRedirect(request.getContextPath() + "/top");//作成に失敗した際には一覧画面に遷移させる
			  }
		  } else {
			  //送信された内容が削除だった時の処理を書く
			  Trip delete_trip = new Trip(Integer.parseInt(request.getParameter("trip_number")));
			  delete_trip.DeleteTrip(Trip.trip_number);
			  response.sendRedirect(request.getContextPath() + "/top");		  
		  }
	    }
	//このメソッド中でデータベースへの追加処理を行う
	private int AddNewTrip() {
		// DB接続のためのアドレスなど
		  String server = "//172.21.37.48:5432/";
		  String database_url = "todo_database";
		  
		  //データベース接続の確立を行う
		  try {
				 Class.forName("org.postgresql.Driver");
				 Connection con = DriverManager.getConnection("jdbc:postgresql:" + server + database_url , "al22016" , "bond");
				 
				 //この下で実際に追加処理を行う
				 int max_id = GetMaxTripId(con);//最初にtrip_idの最大値を取得する
				 if (max_id == -1) {
					 throw new Exception("失敗しました");//取得に失敗したとき例外を投げる
				 } else {
					 Trip.trip_number = max_id;//旅行番号が正常に取得出来たらフィールドに設定する
					 System.out.println("追加メソッドの中での参照結果" + Trip.trip_number);
				 }
				 
				 //明日はここから（departure_day , return_dayは現状String型である）
				 //しかしデータベースのカラムにはdate型が指定されている
				 PreparedStatement prestmt;
				 String sql = "insert into trip values (? , ? , ? , ?)";
				 prestmt = con.prepareStatement(sql);
				 
				 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				 java.util.Date date_departure_day = sdf.parse(departure_day);
				 java.util.Date date_return_day = sdf.parse(return_day);
				 
				 java.sql.Date set_departure_day = new java.sql.Date(date_departure_day.getTime());
				 java.sql.Date set_return_day = new java.sql.Date(date_return_day.getTime());
				 prestmt.setInt(1, max_id);
				 prestmt.setDate(2 , set_departure_day);
				 prestmt.setDate(3, set_return_day);
				 prestmt.setString(4, trip_name);
				 
				 prestmt.executeUpdate();
				 return 1;//成功したら1を返す
		      } catch (Exception e) {
				 e.printStackTrace();
				 return 0;//失敗したら0を返す
			 }	
	}
	
	//このメソッドの中で旅行の削除を行う
	//削除を行う際には関連するTodo , 思い出 , Todoをすべて削除しないといけない
	private void DeleteTrip(int trip_number) {
		// DB接続のためのアドレスなど
		  String server = "//172.21.37.48:5432/";
		  String database_url = "todo_database";
		  
		  //データベース接続の確立を行う
		  try {
				 Class.forName("org.postgresql.Driver");
				 Connection con = DriverManager.getConnection("jdbc:postgresql:" + server + database_url , "al22016" , "bond");
				 
				 //関連するTodo,思い出,メンバーの削除
				 //先に関連する項目を削除しないと外部キー制約に反する
				 DeleteAllTodo(con , Trip.trip_number);
				 DeleteAllMemory(con , Trip.trip_number);
				 DeleteAllMember(con, Trip.trip_number);
				 
				 //旅行の削除を行う
				 try {
					 PreparedStatement prestmt;
					 String delete_trip_sql = "delete from trip where trip_number = ?";
					 prestmt = con.prepareStatement(delete_trip_sql);
					 prestmt.setInt(1, Trip.trip_number);
					 prestmt.executeQuery();
					 
					 prestmt.close();
				 } catch (Exception e) {
				 }
				 con.close();
		      } catch (Exception e) {
				 e.printStackTrace();
			}
	}
	
	//指定された旅行番号のTodoをすべて削除するためのメソッド
	private void DeleteAllTodo (Connection con , int trip_number) {
		//Todoの削除を行う
		PreparedStatement prestmt;
		String delete_todo_sql = "delete from todo where trip_number = ?";
		try {
			 prestmt = con.prepareStatement(delete_todo_sql);
			 prestmt.setInt(1, trip_number);
			 prestmt.executeQuery();
			 prestmt.close();
		} catch (Exception e) {
			System.out.println("Todoの削除に失敗しました");
		}
	}
	
	//指定された旅行番号の思い出をすべて削除する為のメソッド
	private void DeleteAllMemory(Connection con , int trip_number) {
		//思い出の削除を行う
		PreparedStatement prestmt;
		String delete_memory_sql = "delete from memory where trip_number = ?";
		try {
			prestmt = con.prepareStatement(delete_memory_sql);
			prestmt.setInt(1, trip_number);
			prestmt.executeQuery();
			prestmt.close();
		} catch (Exception e) {
		    System.out.println("思い出の削除に失敗しました");
		}
	}
	
	//指定された旅行番号のメンバーをすべて削除するためのメソッド
	private void DeleteAllMember(Connection con , int trip_number) {
		//思い出の削除を行う
		PreparedStatement prestmt;
		String delete_member_sql = "delete from trip_member where trip_number = ?";
		try {
			prestmt = con.prepareStatement(delete_member_sql);
			prestmt.setInt(1, trip_number);
			prestmt.executeQuery();
			prestmt.close();
		} catch (Exception e) {
			System.out.println("メンバーの削除に失敗しました");
		}
	}
	//現在のTripテーブルのtrip_idの最大値を取得するためのメソッド
	private int GetMaxTripId(Connection con) {
		int maxId = 0;
		try {
			Statement stmt = con.createStatement();
			String get_max_id = "select max(trip_number) as trip_number from trip";
			ResultSet result_max_id = stmt.executeQuery(get_max_id);
			
			if (result_max_id.next()) {
				maxId = result_max_id.getInt("trip_number") + 1;
			} else {
				maxId = 1;//tripテーブルが空の時にはtrip_number = 1とする
			}
			stmt.close();
			return maxId;//成功したとき最大のtrip_numberを返す
		}catch (Exception e){
			return -1;//失敗したとき-1を返す
		}
	}
}