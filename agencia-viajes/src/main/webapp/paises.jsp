<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="com.mycompany.agencia.viajes.Conexion" %>

<%
    // Validar sesión activa
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Paquetes de Viajes - Agencia de Viajes</title>

<style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:Arial, sans-serif;}
    body{background:#eef3f8;}
    header{
        background:linear-gradient(45deg,#004A99,#007BFF);
        padding:20px;
        color:white;
        text-align:center;
    }
    nav{margin-top:10px;}
    nav a{color:white;margin:0 15px;text-decoration:none;font-weight:bold;}
    nav a:hover{color:#ffea00;}

    .container{padding:40px;}
    h2{margin-bottom:20px;color:#003366;font-size:32px;text-align:center;}

    .grid{
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
        gap:25px;
    }

    .card{
        background:white;
        border-radius:12px;
        overflow:hidden;
        box-shadow:0 4px 12px rgba(0,0,0,.2);
        transition:.3s;
    }
    .card:hover{transform:translateY(-6px);}
    .card img{width:100%;height:160px;object-fit:cover;}
    .card-content{padding:15px;text-align:center;}
    .card-content h3{color:#004a99;margin-bottom:5px;}
    .card-content p{color:#555;margin-bottom:8px;}
    strong{color:#007BFF;font-size:16px;}
    button{
        margin-top:10px;width:100%;padding:10px;border:none;
        background:#007BFF;color:white;border-radius:6px;cursor:pointer;
        font-weight:bold;transition:.3s;
    }
    button:hover{background:#0056c9;}
</style>
</head>
<body>

<header>
    <h1>? Mundo Travel</h1>
    <nav>
        <a href="inicio.jsp">Inicio</a>
        <a href="paises.jsp">Destinos</a>
        <a href="reservas.jsp">Mis Reservas</a>
        <a href="logout.jsp">Cerrar Sesión</a>
    </nav>
</header>

<div class="container">
    <h2>Todos los Paquetes Disponibles</h2>
    <div class="grid">

<%
    try {
        conn = Conexion.getConnection();
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM paises ORDER BY nombre");

        while (rs.next()) {
            String nombre = rs.getString("nombre");
            String descripcion = rs.getString("descripcion");
            int id = rs.getInt("id");

            // Imagen aleatoria relacionada al país desde Unsplash
            String imagen = "https://source.unsplash.com/400x250/?" + nombre.replace(" ", "%20");

            // Generar precio y duración realista
            int precio = 400 + (int)(Math.random() * 1500);
            int dias = 3 + (int)(Math.random() * 5);
%>

        <div class="card">
            <img src="<%= imagen %>" alt="Imagen de <%= nombre %>">
            <div class="card-content">
                <h3><%= nombre %></h3>
                <p><%= descripcion %></p>
                <p><%= dias %> días / <%= (dias - 1) %> noches</p>
                <strong>$<%= precio %> USD</strong>
                <form action="ReservarServlet" method="post">
                    <input type="hidden" name="pais_id" value="<%= id %>">
                    <input type="hidden" name="precio" value="<%= precio %>">
                    <input type="hidden" name="duracion" value="<%= dias %>">
                    <br>
                    <label>Cantidad: </label>
                    <input type="number" name="cantidad" value="1" min="1" max="10">
                    <button type="submit">Reservar ??</button>
                </form>
            </div>
        </div>

<%
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error al mostrar países: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>

    </div>
</div>

</body>
</html>