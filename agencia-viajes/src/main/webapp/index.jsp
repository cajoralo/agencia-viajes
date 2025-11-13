<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Agencia de Viajes</title>
    <style>
      body {
        background-image: url("https://images.unsplash.com/photo-1507525428034-b723cf961d3e");
        background-size: cover;
        background-position: center;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }

      .login-box {
        background-color: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0px 0px 15px rgba(0,0,0,0.3);
        text-align: center;
        width: 300px;
        transform: translateX(200px); /* mueve el cuadro hacia la derecha */
      }

      input {
        width: 90%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
      }

      button {
        width: 100%;
        padding: 10px;
        background-color: teal;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }

      .error {
        color: red;
        font-size: 0.9em;
      }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Iniciar Sesión</h2>
    <form action="LoginServlet" method="post">
        <input type="text" name="usuario" placeholder="Usuario" required>
        <input type="password" name="contrasena" placeholder="Contraseña" required>
        <button type="submit">Entrar</button>
    </form>

    <% 
        String error = request.getParameter("error");
        if ("1".equals(error)) { 
    %>
        <p class="error">Usuario o contraseña incorrectos</p>
    <% 
        } else if ("2".equals(error)) { 
    %>
        <p class="error">Error de conexión con la base de datos</p>
    <% 
        } 
    %>
</div>
</body>
</html>