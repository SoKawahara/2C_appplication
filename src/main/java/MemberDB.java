import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//web.xmlでマッピングしたURLに対してアクセスされた際にここに処理が飛んでくる
public class MemberDB extends HttpServlet{
	public MemberDB() {
	}
	public void doPost(HttpServletRequest request , 
	          HttpServletResponse response)
    throws IOException , ServletException {
		//ここで送信されたフォームの内容を取得する
		String member_id = request.getParameter("member_id");
		String member_name = request.getParameter("member_name");
		String member_status = request.getParameter("member_status");
		String trip_number 	= request.getParameter("trip_number");
		
		//送信されたtodo_statusの値(達成、削除、追加)によって処理を分ける
		//Javaで文字列の比較を行うにはequalsメソッドを使用する
		if (member_status.equals("削除")){

			//削除を行うメソッドを使用するためにMemberDBクラスのインスタンスを作成する
			MemberDB delete = new MemberDB();
			delete.delete(Integer.parseInt(member_id) , Integer.parseInt(trip_number));
		}else{
			System.out.println("追加が押されましした");
			MemberDB add = new MemberDB();
	        add.add(Integer.parseInt(member_id) , Integer.parseInt(trip_number));
		}
		
		//この下で画面の描画を行う
		//getContextPath()メソッドを使用することでサーバー内でアプリがデプロイされている場所を取得する
		response.sendRedirect(request.getContextPath() + "/" + trip_number);
	}
    public int member_id;
    public int trip_number;


    // DB接続のためのアドレスなど
    String server = "//172.21.37.48:5432/";
    String dataBase = "todo_database";
    String user = "al22016";
    String passWord = "bond";
    String url = "jdbc:postgresql:" + server + dataBase;

    //これは追加する為の処理を行っているコンストラクタ
    public void add(int member_id, int trip_number) {
        this.trip_number = trip_number;
        this.member_id = member_id;

        try  {
        	Class.forName("org.postgresql.Driver");
        	Connection connection = DriverManager.getConnection(url, user, passWord);
            // 新しいidを生成

            // 新しいレコードを追加
            String insertQuery = "INSERT INTO trip_member VALUES (?, ? ) ";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setInt(1, member_id);
                preparedStatement.setInt(2, trip_number);


                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("新しい人物が追加されました。ID: " +member_id);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void delete(int member_id, int trip_number){
        try (Connection connection = DriverManager.getConnection(url, user, passWord)) {
            String deleteQuery = "DELETE FROM trip_member WHERE member_id = ? AND trip_number = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery)) {
                preparedStatement.setInt(1, member_id);
                preparedStatement.setInt(2, trip_number);

                int rowsDeleted = preparedStatement.executeUpdate();
                if (rowsDeleted > 0) {
                    System.out.println("mennberが削除されました。ID: " + member_id + ", Trip Number: " + trip_number);
                } else {
                    System.out.println("指定された条件のmemberが見つかりませんでした。ID: " + member_id + ", Trip Number: " + trip_number);
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