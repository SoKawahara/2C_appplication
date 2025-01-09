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
      font-weight: 400;
      font-family: "Noto Sans JP", "游ゴシック体", "Yu Gothic", "Meiryo", sans-serif;
      border-bottom: 2px solid black;
    }
    
    h1:before {
      content: "〇";
    }
    
    h3 {
      font-size: 22px;
      text-align: center;
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 450;
      font-style: normal;
    }
   
    h3::before {
      content: "〇"
    }
    
    p {
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
    }
    
    input {
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 420;
      font-style: normal;
    }
    .trip-container {
      width: 90%;
      padding: 1rem;
      margin: 2rem auto;
      border: 5px groove grey;
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
      margin-bottom: .6rem;
    }
    .memory-content p::before {
      margin-right: .3rem;
    }
    .todo-container {
      width: 45%;
    }
    .memory-container {
      width: 45%;
    }
    
    .memory-h1 {
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 450;
      font-style: normal;
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
      padding-bottom: 2rem;
    }
    .todo p {
      text-align: center;
    }
    
    .todo-form {
      border: 2px outset grey;
      border-radius: 30px;
      padding: 1.5rem;
    }
    
    .todo-form h2 ,
    .memory-form h2 {
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 450;
      font-style: normal;
    }
    
    .todo-form input ,
    .memory-form input{
      display: block;
      margin: auto;
      width: 430px;
    }
    
    .todo-form input:nth-of-type(2),
    .memory-form input:nth-of-type(4) {
      width: 130px;
      margin-bottom: 2rem;
    }
    
    .memory-form {
      padding-top: 1.5rem;
      width: 100%;
      margin: auto;
      border: 2px inset grey;
      border-radius: 30px;
    }
    
    .archive {
      background-color: #8eb5f5;
      border-radius: 20px;
      border: 2px solid #8eb5f5;
      color: white;
    }
    
    .archive:hover {
      cursor: pointer;
    }
    
    .delete {
      background-color: #d14d5d;
      border: 2px solid #d14d5d;
      border-radius: 20px;
      color: white;
    }
    
    .delete:hover {
      cursor: pointer;
    }
    
    .view-about-todo {
      transition: 0.8s;
      border-radius: 20px;
    }
    
    .view-about-todo:hover {
      background-color: black;
      color: white;
      cursor: pointer;
    }
  </style>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Hina+Mincho&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  
</head>

<body>
  <h1>旅行アプリケーション</h1>
  <% List<String> trip_info = (List<String>) request.getAttribute("trip_info"); %>
  <section class = "trip-container">
    <section class = "todo-container">
      <div class = "destination">
        <h3>旅行先</h3>
        <p><%= trip_info.get(1) %></p>
      </div>
      <div class = "member">
        <h3>メンバー</h3>
        <div style = "display: flex;align-items:center">
          <% String member_names = String.valueOf(request.getAttribute("member_names")); %>
          <% if (member_names.length() > 0) { %>
            <p><%= member_names %></p>
          <% } else { %>
            <p>＊登録されているメンバーがいません</p>
          <% } %>
          <form method = "GET" action="" style = "margin-bottom:0;margin-left: 1.5rem"><input type ="submit" value ="追加"></form>
        </div>
        
      </div>
      <div class = "date">
        <h3>日付</h3>
        <p><%= trip_info.get(2) %>～<%= trip_info.get(3) %></p>
      </div>
      <div class = "todo">
        <h3 style = "margin-bottom: 1rem;">Todo一覧</h3>
        <!-- request.getAttributeではObject型に変換されて渡されてくるのでList型に変換する -->
        <% List<List<String>> todos = (List<List<String>>)(request.getAttribute("get_todos")); %>
        <% if (todos.size() > 0) { %>
          <% for (int i = 0 ; i < todos.size() ; ++i){ %>
            <div style = "display: flex;justify-content:space-between;align-items:center;border-bottom: 1px solid black;padding: 0 1rem;margin-bottom:1rem;">
              <p>No.<%= todos.get(i).get(1) %></p>
              <p style = "margin-left: 1rem;"><%= todos.get(i).get(0) %></p>
              <div style = "display: flex">
                <form method = "POST" action="/2CExample/add_todo" style = "margin-bottom:0;margin-left: 1.5rem">
                  <input class = "archive" type ="submit" name = "todo_status" value ="達成">
                  <input type="hidden" name="trip_number" value=<%= todos.get(i).get(2) %>>
                  <input type="hidden" name="todo_id" value=<%= todos.get(i).get(1) %>>
                  <input type = "hidden" name = "add_todo_trip_number" value = <%= trip_info.get(0) %>>
                </form>
                <form method = "POST" action="/2CExample/add_todo" style = "margin-bottom:0;margin-left:.5rem">
                  <input class = "delete" type ="submit" name = "todo_status" value ="削除">
                  <input type="hidden" name="trip_number" value=<%= todos.get(i).get(2) %>>
                  <input type="hidden" name="todo_id" value=<%= todos.get(i).get(1) %>>
                  <input type = "hidden" name = "add_todo_trip_number" value = <%= trip_info.get(0) %>>
                </form>
                <form method = "GET" action="/2CExample/todo_about" style = "margin-bottom:0;margin-left:.5rem">
                  <input type="hidden" name="trip_number" value=<%= todos.get(i).get(2) %>>
                  <input type="hidden" name="todo_id" value=<%= todos.get(i).get(1) %>>
                  <input type = "hidden" name = "add_todo_trip_number" value = <%= trip_info.get(0) %>>
                  <input type = "submit" value = "詳細" class = "view-about-todo">
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
            <input type="hidden" name="todo_status" value="追加">
            <input type = "hidden" name = "add_todo_trip_number" value = <%= trip_info.get(0) %>>
            <input type ="submit" value ="Todoを追加する">
          </form>
        </div>
      </div>
    </section>
    <section class = "memory-container">
      <h1 class = "memory-h1" style = "margin-bottom: 0;">思い出</h1>
      <section class = "memory-content">
        <% List<List<String>> memories = (List<List<String>>) request.getAttribute("memories"); %>
        <% if (memories.size() > 0) { %>
          <% for (int i = 0 ; i < memories.size() ; ++i ){ %>
            <div style = "display: flex;align-items:center;border-bottom: 1px solid black;">
              <p><span style = "margin: 0 1rem;">No. <%= memories.get(i).get(1) %></span><%= memories.get(i).get(3) %>
              <form method = "POST" action="/2CExample/add_memory" style = "margin-bottom:0;margin-left:1rem">
                <input class = "delete" type ="submit" name = "memory_status" value ="削除">
                <input type="hidden" name="trip_number" value = <%= memories.get(i).get(0) %>>
                <input type="hidden" name="memory_id" value = <%= memories.get(i).get(1) %>>
                <input type = "hidden" name = "add_memory_trip_number" value = <%= trip_info.get(0) %>>
              </form>
              </p>
            </div>
          <% } %>
        <% } else { %>
          <p>*現在登録されている思い出はありません</p>
        <% } %>
        <div class = "memory-form" style = "margin-top: 1.5rem;">
          <h2 style = "margin-top: 0;text-align:center;">～新規思い出作成～</h2>
          <form method = "POST" action="/2CExample/add_memory" style = "margin-bottom:0;">
            <input type = "text" name = "memory" size = "60" placeholder = "ここに思い出を入力してください" style = "margin-bottom: 1rem">
            <input type ="hidden" name = "memory_status" value ="追加">
            <input type = "hidden" name = "add_memory_trip_number" value = <%= trip_info.get(0) %>>
            <input type ="submit" value ="思い出を追加する">
          </form>
        </div>
        
      </section>
    </section>
  </section>
</body>
</html>