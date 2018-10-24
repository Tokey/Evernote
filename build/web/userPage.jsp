

<%@page import="WebTest.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>To Do</title>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <!-- OFFLINE -->
        <link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Shadows+Into+Light+Two" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Cookie" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Pattaya" rel="stylesheet">
        <link rel="stylesheet" href="main.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>

        <%
            Connection con = DatabaseConnection.dbConnector();
            PrintWriter pw = response.getWriter();
            if (session.getAttribute("user") == null) {
                //pw.println("You're not logged in!!");
                response.sendRedirect("index.html");
            }
            /*
            try {

                PreparedStatement statement = con.prepareStatement(
                        "SELECT * FROM items where id = '" + (Integer) session.getAttribute("userID") + "'");
                //statement.setString(0, LOGIN_UsernameField.getText());
                //statement.setString(0, LOGIN_PasswordField.getPassword());
                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    pw.println("Item:" + rs.getString("number") + "<br>");
                }

            } catch (Exception e) {
                pw.println(e);
            }
             */


        %>

        <!-- Starting NAVbar -->
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">E V E R N O T E</a>
                </div>
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Writers Hub </a></li>
                    <li><a href="todayPage.jsp">Recent Notes</a></li>
                    
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#?value=<%= (String) session.getAttribute("user")%>"><span class="glyphicon glyphicon-user"></span>  Greetings!!!    <%= (String) session.getAttribute("user")%> </a></li>
                    <li><a href="userLogout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                </ul>
            </div>
        </nav>

        <!-- End of NAVbar -->


        <div class="container">
            <div class="list">
                <h1>Write at your hearts content!</h1>

                <ul class="items">
                    <%
                        try {
                            PreparedStatement statement = con.prepareStatement(
                                    "SELECT * FROM items where id = '" + (Integer) session.getAttribute("userID") + "'");
                            //statement.setString(0, LOGIN_UsernameField.getText());
                            //statement.setString(0, LOGIN_PasswordField.getPassword());
                            ResultSet rs = statement.executeQuery();
                            while (rs.next()) {
                    %>
                    <li>
                        <% if ("0".equalsIgnoreCase(rs.getString("done"))) {%>
                        <span class="item"> <%= rs.getString("name")%> </span>
                        <a href="doneItem?item=<%= rs.getString("number")%>" class="done-button">Mark favorite</a>
                        <a href="deleteItem?item=<%= rs.getString("number")%>" class="done-button"> Delete Note</a>
                        <span class="created" style="
                              font-size: 12px;
                              font-style: italic;
                              background-color: #d9dfel;
                              color: #404f9a;
                              padding: 3px 6px;
                              font-family: sans-serif;
                              "> Created at: <%= rs.getString("created")%></span>
                        <% }%>

                        <% if ("1".equalsIgnoreCase(rs.getString("done"))) {%>
                        <span class="item">**** <%= rs.getString("name")%> </span>
                        <a href="notdoneItem?item=<%= rs.getString("number")%>" class="done-button">Remove Favorite</a>
                        <a href="deleteItem?item=<%= rs.getString("number")%>" class="done-button"> Delete Note</a>
                        <% }%>
                    </li>
                    <% }
                        } catch (Exception e) {
                            pw.println(e);
                        }%>

                </ul>

                <form class="item-add" action="addItem" method="post">
                    <input type="text" name="item" required placeholder="Thinking about something? Write Away!!" class="input" autocomplete="off">
                    <input type="submit" name="submitBtn" value="Add" class="submit"> 
                </form>
            </div>
        </div>


    </body>
</html>
