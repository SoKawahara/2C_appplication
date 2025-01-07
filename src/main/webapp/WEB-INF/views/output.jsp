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
        <h3>Todo</h3>
        <!-- request.getAttributeではObject型に変換されて渡されてくるのでList型に変換する -->
        <% List<List<String>> todos = (List<List<String>>)(request.getAttribute("get_todos")); %>
        <% for (int i = 0 ; i < todos.size() ; ++i){ %>
          <div style = "display: flex;justify-content:space-between;align-items:center;border-bottom: 1px solid black;padding: 0 1rem;margin-bottom:1rem;">
            <p>No.<%= todos.get(i).get(1) %></p>
            <p style = "margin-left: 1rem;"><%= todos.get(i).get(0) %></p>
            <div style = "display: flex">
              <form method = "GET" action="" style = "margin-bottom:0;margin-left: 1.5rem"><input type ="submit" value ="達成"></form>
              <form method = "GET" action="" style = "margin-bottom:0;margin-left:.5rem"><input type ="submit" value ="削除"></form>
            </div>    
          </div>
        <% } %>
      </div>
    </section>
    <section class = "memory-container">
      <h1>思い出</h1>
      <section class = "memory-content">
        <% List<List<String>> memories = (List<List<String>>) request.getAttribute("memories"); %>
        <% for (int i = 0 ; i < memories.size() ; ++i ){ %>
            <p><span style = "margin-right: 1rem;">No. <%= memories.get(i).get(1) %></span><%= memories.get(i).get(3) %></p>
        <% } %>
        <div>
          <form method = "GET" action="" style = "margin-bottom:0;">
            <input type = "text" name = "memory" size = "60" placeholder = "ここに思い出を入力してください" style = "margin-bottom: 1rem">
            <input type ="submit" value ="思い出を追加する">
          </form>
    
        </div>
        
      </section>
    </section>
  </section>
</body>
</html>