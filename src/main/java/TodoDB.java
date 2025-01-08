import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//web.xmlでマッピングしたURLに対してアクセスされた際にここに処理が飛んでくる
public class TodoDB extends HttpServlet{
	public TodoDB() {
	}
	public void doPost(HttpServletRequest request , 
	          HttpServletResponse response)
    throws IOException , ServletException {
		//ここで送信されたフォームの内容を取得する
		String todo_content = request.getParameter("todo");
		String todo_place = request.getParameter("todo_place");
		String todo_value = request.getParameter("todo_value");
		String todo_status = request.getParameter("todo_status");
		
		//送信されたtodo_statusの値(達成、削除、追加)によって処理を分ける
		//Javaで文字列の比較を行うにはequalsメソッドを使用する
		if (todo_status.equals("達成")) {
		} else if (todo_status.equals("削除")){
			//trip_numberとtodo_idを取得する
			String todo_id = request.getParameter("todo_id");
			String trip_number = request.getParameter("trip_number");
			
			//削除を行うメソッドを使用するためにTodoDBクラスのインスタンスを作成する
			TodoDB todo = new TodoDB();
			todo.deleteTodoByIdAndTripNumber(Integer.parseInt(todo_id) , Integer.parseInt(trip_number));
		}else{
			System.out.println("追加が押されましした");
	        new TodoDB(1 , Integer.parseInt(todo_value) , todo_content , todo_place);
		}
		
		//この下で画面の描画を行う
		//getContextPath()メソッドを使用することでサーバー内でアプリがデプロイされている場所を取得する
		response.sendRedirect(request.getContextPath() + "/");
	}
    public int todo_id;
    public int trip_number;
    public int value;
    public String todo_name = "";
    public String place = "";
    public boolean achieve;

    // DB接続のためのアドレスなど
    String server = "//172.21.37.48:5432/";
    String dataBase = "todo_database";
    String user = "al22016";
    String passWord = "bond";
    String url = "jdbc:postgresql:" + server + dataBase;

    //これはTodoを追加する為の処理を行っているコンストラクタ
    public TodoDB(int trip_number, int value, String todo_name , String place) {
        this.trip_number = trip_number;
        this.value = value;
        this.todo_name = todo_name;
        this.place = place;

        try  {
        	Class.forName("org.postgresql.Driver");
        	Connection connection = DriverManager.getConnection(url, user, passWord);
            // 新しいtodo_idを生成
            int newTodoId = generateNewTodoId(connection);

            // 新しいレコードを追加
            String insertQuery = "INSERT INTO todo (todo_id, trip_number, value, todo_name, place , achieve) VALUES (?, ?, ?, ?, ? ,false)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setInt(1, newTodoId);
                preparedStatement.setInt(2, trip_number);
                preparedStatement.setInt(3, value);
                preparedStatement.setString(4, todo_name);
                preparedStatement.setString(5, place);

                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("新しいTODOが追加されました。ID: " + newTodoId);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private int generateNewTodoId(Connection connection) {
        int newTodoId = 0;
        String query = "SELECT MAX(todo_id) AS max_id FROM todo";

        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            if (resultSet.next()) {
                newTodoId = resultSet.getInt("max_id") + 1;
            } else {
                newTodoId = 1; // テーブルが空の場合、最初のIDを1に設定
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return newTodoId;
    }
    public void deleteTodoByIdAndTripNumber(int todoId, int tripNumber) {
        try (Connection connection = DriverManager.getConnection(url, user, passWord)) {
            String deleteQuery = "DELETE FROM todo WHERE todo_id = ? AND trip_number = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery)) {
                preparedStatement.setInt(1, todoId);
                preparedStatement.setInt(2, tripNumber);

                int rowsDeleted = preparedStatement.executeUpdate();
                if (rowsDeleted > 0) {
                    System.out.println("TODOが削除されました。ID: " + todoId + ", Trip Number: " + tripNumber);
                } else {
                    System.out.println("指定された条件のTODOが見つかりませんでした。ID: " + todoId + ", Trip Number: " + tripNumber);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        // テスト用
    	
    	//新しいTODOを作る
    	//new TodoDB(1, 100, "新しいタスク" , "京都");
        
    	//(todo_id,trip_number)のTODOを削除する
        TodoDB todoDB = new TodoDB();
        todoDB.deleteTodoByIdAndTripNumber(4,1);
        
        
        
    }
}