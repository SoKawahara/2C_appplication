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

public class MemoryDB extends HttpServlet {
	public MemoryDB () {
		
	}
	public void doPost(HttpServletRequest request , 
			           HttpServletResponse response)
	    throws IOException , ServletException
	    {
		  String memory_content = request.getParameter("memory");
		  new MemoryDB(1 , 1 , memory_content);
		  
		  //この下で画面の描画を行う
		  //getContextPath()メソッドを使用することでサーバー内でアプリがデプロイされている場所を取得する
		  response.sendRedirect(request.getContextPath() + "/");
		
	    }
    public int memory_id;
    public int trip_number;
    public int member_id;
    public String content = "";

    // DB接続のためのアドレスなど
    String server = "//172.21.37.48:5432/";
    String dataBase = "todo_database";
    String user = "al22016";
    String passWord = "bond";
    String url = "jdbc:postgresql:" + server + dataBase;

    public MemoryDB(int trip_number, int member_id, String content) {
        this.trip_number = trip_number;
        this.member_id = member_id;
        this.content = content;

        try  {
        	Class.forName("org.postgresql.Driver");
        	Connection connection = DriverManager.getConnection(url, user, passWord);
            // 新しいtodo_idを生成
            int newMemoryId = generateNewTodoId(connection);

            // 新しいレコードを追加
            String insertQuery = "INSERT INTO memory (memory_id, trip_number, member_id, content) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setInt(1, newMemoryId);
                preparedStatement.setInt(2, trip_number);
                preparedStatement.setInt(3, member_id);
                preparedStatement.setString(4, content);

                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("新しいMemoryが追加されました。ID: " + newMemoryId);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private int generateNewTodoId(Connection connection) {
        int newMemoryId = 0;
        String query = "SELECT MAX(memory_id) AS max_id FROM memory";

        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            if (resultSet.next()) {
                newMemoryId = resultSet.getInt("max_id") + 1;
            } else {
                newMemoryId = 1; // テーブルが空の場合、最初のIDを1に設定
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return newMemoryId;
    }
    public void deleteMemoryByIdAndTripNumber(int memoryId, int tripNumber) {
        try (Connection connection = DriverManager.getConnection(url, user, passWord)) {
            String deleteQuery = "DELETE FROM memory WHERE memory_id = ? AND trip_number = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery)) {
                preparedStatement.setInt(1, memoryId);
                preparedStatement.setInt(2, tripNumber);

                int rowsDeleted = preparedStatement.executeUpdate();
                if (rowsDeleted > 0) {
                    System.out.println("MEMORYが削除されました。ID: " + memoryId + ", Trip Number: " + tripNumber);
                } else {
                    System.out.println("指定された条件のMEMORYが見つかりませんでした。ID: " + memoryId + ", Trip Number: " + tripNumber);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
    	//テスト用
    	
        //新しい思い出を作る
        //new MemoryDB(1, 1, "新しい思い出");
        
    	//(memory_id,trip_number)の思い出を削除する
        MemoryDB memoryDB = new MemoryDB();
        memoryDB.deleteMemoryByIdAndTripNumber(3,1);
        
    }
}
