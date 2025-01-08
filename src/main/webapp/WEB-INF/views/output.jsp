<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>

<html>
<head>
  <title>テスト</title>
  <style>
    body {
     overflow-x: hidden;
    }
    h1 {
      width: 40%;
      margin: 3rem auto;
      text-align: center;
      font-size: 30px;
      font-weight: red;
      border-bottom: 2px solid black;
    }
    
    h3 {
      font-size: 18px;
      text-align: center;
    }
   
    h3::before {
      content: "●"
    }
    .trip-container {
      width: 90%;
      padding: 1rem;
      margin: 2rem auto;
      border: 2px solid black;
      display: flex;
      justify-content: space-around;
    }
    .memory-content {
      width: 90%;
      margin: auto;
      padding: 1rem;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .memory-content p {
      font-size: 18px;
      border-bottom: 1px solid black;
    }
    .memory-content p::before {
      content: "〇";
      margin-right: .3rem;
    }
    .todo-container {
      width: 45%;
    }
    .memory-container {
      width: 45%;
      border: 2px solid black;
    }
    
    .destination,
    .member,
    .date,
    .todo {
      width: 100%;
      margin-bottom: 0.5rem;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    
    .destination p ,
    .member p,
    .date p 
     {
      text-align: center;
      border: 3px outset #7ca9f2;
      display: lnline-block;
      padding: 0 1rem;
    }
    .todo {
      border: 1.5px solid black;
    }
    .todo p {
      text-align: center;
    }
    
    .todo-form {
      border: 2px solid black;
      padding: 1.5rem;
    }
    
    .todo-form input ,
    .memory-form input{
      display: block;
      margin: auto;
      width: 430px;
    }
    
    .todo-form input:nth-of-type(2),
    .memory-form input:nth-of-type(2) {
      width: 130px;
      margin-bottom: 2rem;
    }
    
    .archive {
      background-color: #8eb5f5;
      border-radius: 20px;
      border: 2px solid #8eb5f5;
      color: white;
    }
    
    .delete {
      background-color: #d14d5d;
      border: 2px solid #d14d5d;
      border-radius: 20px;
      color: white;
    }
    
    
    
    
  </style>
</head>

<body>
  <h1>旅行アプリケーション</h1>
  <section class = "trip-container">
    <section class = "todo-container">
      <div class = "destination">
        <h3>旅行先</h3>
        <p>大阪・京都</p>
      </div>
      <div class = "member">
        <h3>メンバー</h3>
        <div style = "display: flex;align-items:center">
          <p>${ member_names }</p>
          <form method = "GET" action="" style = "margin-bottom:0;margin-left: 1.5rem"><input type ="submit" value ="追加"></form>
        </div>
        
      </div>
      <div class = "date">
        <h3>日付</h3>
        <p>2024/02/12～2024/02/14</p>
      </div>
      <div class = "todo">
        <h3>Todo一覧</h3>
        <!-- request.getAttributeではObject型に変換されて渡されてくるのでList型に変換する -->
        <% List<List<String>> todos = (List<List<String>>)(request.getAttribute("get_todos")); %>
        <% if (todos.size() > 0) { %>
          <% for (int i = 0 ; i < todos.size() ; ++i){ %>
            <div style = "display: flex;justify-content:space-between;align-items:center;border-bottom: 1px solid black;padding: 0 1rem;margin-bottom:1rem;">
              <p>No.<%= todos.get(i).get(1) %></p>
              <p style = "margin-left: 1rem;"><%= todos.get(i).get(0) %></p>
              <div style = "display: flex">
                <form method = "GET" action="" style = "margin-bottom:0;margin-left: 1.5rem"><input class = "archive" type ="submit" value ="達成"></form>
                <form method = "GET" action="" style = "margin-bottom:0;margin-left:.5rem"><input class = "delete" type ="submit" value ="削除"></form>
                <form method = "GET" action="/2CExample/todo_about" style = "margin-bottom:0;margin-left:.5rem">
                  <input type="hidden" name="trip_number" value=<%= todos.get(i).get(2) %>>
                  <input type="hidden" name="todo_id" value=<%= todos.get(i).get(1) %>>
                  <input type = "submit" value = "詳細">
                </form>
              </div>    
            </div>
          <% } %>
        <% } else { %>
          <p>*現在登録されているTodoはありません</p>
        <% } %>
      	
        <div class = "todo-form">
          <h2 style = "margin-top: 0;text-align:center;">～新規Todo作成～</h2>
          <form method = "POST" action="/2CExample/add_todo" style = "margin-bottom:0;">
            <label for = "todo">Todo名:</label>
            <input type = "text" name = "todo" id = "todo" size = "60" placeholder = "ここにTodoを入力してください" style = "margin-bottom: 1rem; width: 400px;">
            <label for = "todo_place">場所:</label>
            <input type = "text" name = "todo_place" id = "todo_place" size = "40" placeholder = "ここに場所を入力してください" style = "margin-bottom: 1rem; width: 400px">
            <label for = "todo_value">費用:</label>
            <input type = "text" name = "todo_value" id = "todo_value" size = "20" placeholder = "ここに費用を入力してください(*半角数字で入力してください)" style = "margin-bottom: 1rem; width: 400px">
            <input type ="submit" value ="Todoを追加する">
          </form>
        </div>
      </div>
    </section>
    <section class = "memory-container">
      <h1>思い出</h1>
      <section class = "memory-content">
        <% List<List<String>> memories = (List<List<String>>) request.getAttribute("memories"); %>
        <% if (memories.size() > 0) { %>
          <% for (int i = 0 ; i < memories.size() ; ++i ){ %>
            <p><span style = "margin-right: 1rem;">No. <%= memories.get(i).get(1) %></span><%= memories.get(i).get(3) %></p>
          <% } %>
        <% } else { %>
          <p>*現在登録されている思い出はありません</p>
        <% } %>
        <div class = "memory-form">
          <form method = "POST" action="/2CExample/add_memory" style = "margin-bottom:0;">
            <input type = "text" name = "memory" size = "60" placeholder = "ここに思い出を入力してください" style = "margin-bottom: 1rem">
            <input type ="submit" value ="思い出を追加する">
          </form>
        </div>
        
      </section>
    </section>
  </section>
</body>
</html>