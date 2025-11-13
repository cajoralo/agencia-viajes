<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Agencia de Viajes</title>
    <style>
        body {
            background-image: url("https://images.unsplash.com/photo-1507525428034-b723cf961d3e");
            background-size: cover;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 10px gray;
            text-align: center;
            width: 300px;
        }

        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 8px;
            margin: 8px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Iniciar Sesión</h2>
        <form action="LoginServlet" method="post">
            <input type="text" name="username" placeholder="Usuario" required><br>
            <input type="password" name="password" placeholder="Contraseña" required><br>
            <input type="submit" value="Ingresar">
        </form>

        <% 
            // Muestra mensaje de error si viene desde el login fallido
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error">Usuario o contraseña incorrectos</div>
        <% 
            } 
        %>
    </div>
</body>
</html>