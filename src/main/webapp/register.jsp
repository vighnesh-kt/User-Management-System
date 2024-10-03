<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Register</title>
<link rel="stylesheet" type="text/css" href="register.css">
</head>
<body>
    <form action="register" method="post">
    <h1>Register</h1>
    
    <% 
    String message = (String) request.getAttribute("message");
    if (message != null) {
	%>
        <p style="color: red;"><%= message %></p>
	<% 
	    } 
	%>
    
    
        <label for="user_name">Name:</label>
        <input type="text" id="user_name" name="user_name" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="pwd">Password:</label>
        <input type="password" id="pwd" name="pwd" required><br><br>

        <label for="pnumber">Phone:</label>
        <input type="tel" id="pnumber"
					name="pnumber" required>
        <br><br>

        <button type="submit" >Register</button>

        <a href="login.jsp">Click to login</a>
    </form>
</body>
</html>
