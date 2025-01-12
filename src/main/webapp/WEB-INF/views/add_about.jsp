<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>追加処理</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&family=Hina+Mincho&family=Kaisei+Opti&family=Pacifico&family=Playfair+Display:ital,wght@0,400..900;1,400..900&family=Prociono&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Tsukimi+Rounded&family=Yuji+Syuku&family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
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
</head>
<body>
  <section>
    <h1>～メンバー追加～</h1>
    <div>
    	<p>メンバー:</p>
    	<ul>
      		<% 
      		List<List<String>> add_about = (List<List<String>>) request.getAttribute("add_about");
      	    for (List<String> member : add_about) {
      	        String member_name = member.get(0); //名前
      	        String member_id = member.get(1);	//ID
      	      	String trip_number = member.get(2);		//旅行番号
      		%>
      		  <li style="display: flex; align-items: center; margin-bottom: 0.5rem;">
      			<span>
					ID: <%= member_id %> - <%= member_name %>
      			</span>
      			<form method = "POST" action="/2CExample/add_member" style = "margin-bottom:0;margin-left: 1.5rem">         
            		<input type="hidden" name="member_id" value="<%= member_id %>">
            		<input type="hidden" name="member_name" value="<%= member_name %>">
            		<input type="hidden" name="trip_number" value="<%= trip_number %>">
            		<input type="hidden" name="member_status" value="<%= "追加" %>">
          			<input class = "add-member" type ="submit" value ="追加">
          		</form>
      		</li>
      		<% } %>
      </ul>
    </div>
    <% String params_trip_number = (String) request.getAttribute("params_trip_number"); %>
    <form method = "GET" action="/2CExample/<%= params_trip_number %>" style = "margin-bottom:0;margin-left: 1.5rem"><input type ="submit" value ="戻る"></form>
  </section>

</body>
</html>