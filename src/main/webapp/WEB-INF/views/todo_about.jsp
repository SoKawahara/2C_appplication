<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Todo詳細</title>
<style>
  h1 {
      margin: 3rem 0 1.5rem 0;
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 500;
      font-style: normal;
  }
  p ,
  span,
  input {
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
  }
  input:hover {
    cursor: pointer;
  }
  .add-member {
      background-color: #8eb5f5;
      border-radius: 20px;
      border: 2px solid #8eb5f5;
      color: white;
  }
  .add-member:hover {
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
  <section>
    <h1>～Todo詳細～</h1>
    <div>
      <% List<String> todo_about = (List<String>) request.getAttribute("todo_about"); %>
      <p>No. <%= todo_about.get(0) %><span style = "margin-left: 1rem;"><%= todo_about.get(2) %></span></p>
      <p>場所: <span style = "margin-left: 1rem;"><%= todo_about.get(3) %></span></p>
      <p>費用: <span style = "margin-left: 1rem;"><%= todo_about.get(4) %>円</p>
      <p>ステータス: 
        <% if (todo_about.get(5).equals("true")) { %>
          <span style = "margin-left: 1rem;">達成済み</span>
        <% } else { %>
          <span style = "margin-left: 1rem">未達成</span>
        <% } %>
      </p>
    </div>
    <form method = "GET" action="/2CExample/<%= todo_about.get(1) %>" style = "margin-bottom:0;margin-left: 1.5rem"><input type ="submit" value ="戻る"></form>
  </section>

</body>
</html>