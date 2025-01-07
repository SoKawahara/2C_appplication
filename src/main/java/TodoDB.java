import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class TodoDB {
    public int todo_id;
    public int trip_number;
    public int value;
    public String todo_name = "";

    // DB接続のためのアドレスなど
    String server = "//172.21.37.48:5432/";
    String dataBase = "todo_database";
    String user = "al22016";
    String passWord = "bond";
    String url = "jdbc:postgresql:" + server + dataBase;

    public TodoDB(int todo_name) {
    	
    }
    public TodoDB(int trip_number, int value, String todo_name) {
        this.trip_number = trip_number;
        this.value = value;
        this.todo_name = todo_name;

        try  {
        	Class.forName("org.postgresql.Driver");
        	Connection connection = DriverManager.getConnection(url, user, passWord);
            // 新しいtodo_idを生成
            int newTodoId = generateNewTodoId(connection);

            // 新しいレコードを追加
            String insertQuery = "INSERT INTO todo (todo_id, trip_number, value, todo_name) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setInt(1, newTodoId);
                preparedStatement.setInt(2, trip_number);
                preparedStatement.setInt(3, value);
                preparedStatement.setString(4, todo_name);

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

    public static void main(String[] args) {
        // テスト用
        new TodoDB(1, 100, "新しいタスク");
    }
}