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
      margin: 3rem auto 0 auto;
      text-align: center;
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 500;
      font-style: normal;
      color: #abcade;
    }
    h2 {
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 450;
      font-style: normal;
      color: #ced9db;
    }
    p ,
    input {
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
    }
    label {
      color: #ced9db;
      font-family: "Caveat", serif;
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
    }
    
    .title-border {
      width: 50%;
      margin: 0 auto;
      height: 2.8px; /* 線の太さ */
      background: linear-gradient(to right, #0e1af0 , #4784ed , #47d4ed);
    }
    .trip-container {
      margin-top: 2rem;
      display: flex;
      justify-content: space-around;
      align-items: start;
    }
    .trip-container::before {
      background-image: url("/2CExample/images/airplane.jpg");
      content: "";
      position: absolute;
      inset: 0;
      background-size: cover;
      filter: blur(0.55rem);
      z-index: -1;
    }
    .view-all-trips {
      width: 55%;
    }
    .new-trip {
      width: 35%;
      border: 1.5px dashed grey;
      border-radius: 10px;
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
    
    .create-new-trip {
      width: 90%;
      margin: auto;
    }
    .create-new-trip form {
      margin-left: 0!important;
    }
    .create-new-trip label {
      display: block;
    }
    .create-new-trip input[type="submit"] {
      width: 120px;
      display: block;
      margin: 1.5rem auto;
    }
    .trip-name ,
    .trip-member{
      display: block;
      width: 300px;
      margin: 1rem auto;
      text-align: center;
    }
    
    #trip-days {
      display: flex;
      justify-content: space-around;
      align-items: center;
      height: 30px;
    }
    
    .action-trip {
      display: flex;
      justify-content: space-around;
    }
    
    .delete-trip {
      background-color: #d14d5d;
      border: 2px solid #d14d5d;
      border-radius: 20px;
      color: white;
    }
    .caution {
      width: 90%;
      padding: .5rem;
      margin: auto;
      display: flex;
      flex-direction: column;
      align-items: center;
      border: 1px solid black;
      border-radius: 15px;
    }
    .caution p {
      margin: 0;
      color: #e4eced;
    }
    .caution p:nth-child(3) {
      color: #99cff0;
    }
    
    
</style>
<link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Hina+Mincho&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Hina+Mincho&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&family=Zen+Old+Mincho&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Hina+Mincho&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&family=Zen+Old+Mincho&display=swap" rel="stylesheet">
</head>
<body>
  <h1>〇旅行アプリケーション</h1>
  <div class = "title-border"></div>
  <section class = "trip-container">
    <div class = "view-all-trips">
      <h2>●旅行一覧</h2>
      <div class = "caution">
        <p>*旅行の詳細を見るには「詳細」をクリックしてください</p>
        <p>*旅行を削除するには「削除」をクリックしてください</p>
        <p>(旅行を削除する際には登録されたTodoや思い出、メンバーなども削除されます)</p>
      </div>
      <% List<List<String>> all_trips = (List<List<String>>) request.getAttribute("all_trips"); %>
      <% if (all_trips.size() > 0) { %>
        <% for (int i = 0 ; i < all_trips.size() ; ++i) { %>
          <div class = "about-each-trip">
            <p>No. <%= all_trips.get(i).get(0) %></p>
            <p><%= all_trips.get(i).get(1) %></p>
            <div class = "action-trip">
              <form method = "GET" action="/2CExample/<%= all_trips.get(i).get(0) %>" style = "margin-bottom:0;margin-left: 1.5rem">
                <input style = "border-radius: 20px;"type ="submit" name = "trip_status" value ="詳細">
                <input type="hidden" name="trip_number" value=<%= all_trips.get(i).get(0) %>>
              </form>
              <form method = "POST" action = "/2CExample/delete" style = "margin-bottom:0;margin-left: 1.5rem;">
                <input class = "delete-trip" type ="submit" name = "trip_status" value ="削除">
                <input type="hidden" name="trip_number" value=<%= all_trips.get(i).get(0) %>>
              </form>
            </div>
          </div>
        <% } %>  
      <% } else { %>
        <p style = "margin-top: 2rem;text-align:center;">*現在登録されている旅行はありません</p>
      <% } %>
      
    </div>
    <div class = "new-trip">
      <h2>●新規旅行作成</h2>
      <div class = "caution" style = "margin-bottom: 1.5rem;">
        <p style = "text-align: center;">(*メンバーは詳細画面から追加してください)</p>
      </div>
      <div class = "create-new-trip">
        <form method = "POST" action="/2CExample/new" style = "margin-bottom:0;margin-left: 1.5rem">
          <label for = "trip-name">旅行先名:</label>
          <input type = "text" name = "trip_name" id = "trip-name" class = "trip-name">
          <label for = "trip_days">期間:</label>
          <div id = "trip-days">
            <input type = "date" name = "departure_day">
            <p>～</p>
            <input type = "date" name = "return_day">
          </div>
          <input class = "archive" type ="submit" name = "trip_status" value ="旅行を追加する">
      </form>
      </div>
    </div>
  </section>
</body>
</html>