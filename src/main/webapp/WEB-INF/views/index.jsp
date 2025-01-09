<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>旅行アプリケーション</title>
<style>
  h1 {
      width: 40%;
      margin: 3rem auto;
      text-align: center;
      font-size: 30px;
      font-weight: 400;
      font-family: "Noto Sans JP", "游ゴシック体", "Yu Gothic", "Meiryo", sans-serif;
      border-bottom: 2px solid black;
    }
    .trip-container {
      margin-top: 2rem;
      display: flex;
      justify-content: space-around;
      align-items: center;
    }
    .view-all-trips {
      width: 55%;
      border: 2px solid black;
    }
    .new-trip {
      width: 35%;
      border: 2px solid black;
    }
    .view-all-trips h2,
    .new-trip h2 {
      text-align: center;
    }
    
    .about-each-trip {
      display: flex;
      justify-content: space-around;
      align-items: center;
      width: 80%;
      margin: 1rem auto;
      border-bottom: 1px solid black;
    }
</style>
</head>
<body>
  <h1>〇旅行アプリケーション</h1>
  <section class = "trip-container">
    <div class = "view-all-trips">
      <h2>●旅行一覧</h2>
      <% List<List<String>> all_trips = (List<List<String>>) request.getAttribute("all_trips"); %>
      <% if (all_trips.size() > 0) { %>
        <% for (int i = 0 ; i < all_trips.size() ; ++i) { %>
          <div class = "about-each-trip">
            <p>No. <%= all_trips.get(i).get(0) %></p>
            <p><%= all_trips.get(i).get(1) %></p>
              <form method = "GET" action="/2CExample/<%= all_trips.get(i).get(0) %>" style = "margin-bottom:0;margin-left: 1.5rem">
                <input class = "archive" type ="submit" name = "trip_status" value ="詳細">
                <input type="hidden" name="trip_number" value=<%= all_trips.get(i).get(0) %>>
              </form>
          </div>
        <% } %>  
      <% } else { %>
      <% } %>
      
    </div>
    <div class = "new-trip">
      <h2>●新規旅行作成</h2>
    </div>
  </section>
</body>
</html>