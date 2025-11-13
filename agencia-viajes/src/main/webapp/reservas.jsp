<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.agencia.viajes.Conexion" %>
<%@ page import="javax.servlet.http.*" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String usuario = (String) sesion.getAttribute("usuario");
%>

<html>
<head>
    <title>Mis Reservas</title>
    <style>
        body { font-family: Arial; background: #f9f9f9; }
        table {
            border-collapse: collapse;
            width: 90%;
            margin: 30px auto;
            background: white;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #28a745;
            color: white;
        }
        .boton {
            background: #007BFF;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
        .boton:hover {
            background: #0056b3;
        }
    </style>
</head>

<body>
    <h2 align="center">?? Reservas de <%= usuario %></h2>

    <table>
        <tr>
            <th>País</th>
            <th>Cantidad</th>
            <th>Fecha de reserva</th>
        </tr>

        <%
            try (Connection conn = Conexion.getConnection()) {
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT p.nombre, r.cantidad, r.fecha_reserva " +
                    "FROM reservas r INNER JOIN paises p ON r.pais_id = p.id " +
                    "WHERE r.usuario = ? ORDER BY r.fecha_reserva DESC"
                );
                ps.setString(1, usuario);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("nombre") %></td>
                <td><%= rs.getInt("cantidad") %></td>
                <td><%= rs.getTimestamp("fecha_reserva") %></td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error al mostrar reservas: " + e.getMessage());
            }
        %>
    </table>

    <div style="text-align:center;">
        <a href="paises.jsp" class="boton">Volver a países</a>
    </div>
</body>
</html>