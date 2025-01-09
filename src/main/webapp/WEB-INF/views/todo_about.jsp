<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Todo詳細</title>
</head>
<body>
  <section>
    <h1>Todo詳細</h1>
    <div>
      <% List<String> todo_about = (List<String>) request.getAttribute("todo_about"); %>
      <p>No. <%= todo_about.get(0) %><span style = "margin-left: 1rem;"><%= todo_about.get(2) %></span></p>
      <p>場所: <span style = "margin-left: 1rem;"><%= todo_about.get(3) %></span></p>
      <p>費用: <span style = "margin-left: 1rem;"><%= todo_about.get(4) %>円</p>
    </div>
    <form method = "GET" action="/2CExample/<%= todo_about.get(1) %>" style = "margin-bottom:0;margin-left: 1.5rem"><input type ="submit" value ="戻る"></form>
  </section>

</body>
</html>