<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>削除処理</title>
</head>
<body>
  <section>
    <h1>削除詳細</h1>
    <div>
    	<p>メンバー:</p>
    	<ul>
      		<% 
      		List<List<String>> delete_about = (List<List<String>>) request.getAttribute("delete_about");
      	    for (List<String> member : delete_about) {
      	        String member_name = member.get(0); //名前
      	        String member_id = member.get(1);	//ID
      	      	String trip_number = member.get(2);		//旅行番号
      		%>
      		  <li style="display: flex; align-items: center; margin-bottom: 0.5rem;">
      			<span>
					ID: <%= member_id %> - <%= member_name %>
      			</span>
      			<form method = "POST" action="/2CExample/delete_member" style = "margin-bottom:0;margin-left: 1.5rem">         
            		<input type="hidden" name="member_id" value="<%= member_id %>">
            		<input type="hidden" name="member_name" value="<%= member_name %>">
            		<input type="hidden" name="trip_number" value="<%= trip_number %>">
            		<input type="hidden" name="member_status" value="<%= "削除" %>">
          			<input type ="submit" value ="削除">
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