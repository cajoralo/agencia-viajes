
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Pantalla de Inicio</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        header {
            background: #003366;
            color: #fff;
            padding: 20px;
            text-align: center;
            font-size: 22px;
        }

        .container {
            margin: 40px auto;
            width: 80%;
            text-align: center;
        }

        a {
            display: inline-block;
            margin: 15px;
            padding: 15px 25px;
            font-size: 18px;
            text-decoration: none;
            background: #0055a5;
            color: white;
            border-radius: 8px;
        }

        a:hover {
            background: #003f7f;
        }
    </style>
</head>
<body>

<header>
    Bienvenido a la Agencia de Viajes
</header>

<div class="container">
    <h2>Seleccione una opción</h2>

    <a href="paises.jsp">Ver Países</a>
    <a href="reservas.jsp">Reservas</a>
    <a href="search.jsp">Buscar</a>
    <a href="results.jsp">Resultados</a>
    <a href="recuperar.jsp">Recuperar contraseña</a>

    <br><br>
    <a href="login.jsp" style="background:#990000;">Cerrar Sesión</a>
</div>

</body>
</html>