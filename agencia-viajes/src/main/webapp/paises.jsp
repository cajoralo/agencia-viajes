<%@ page import="dao.FlightDAO,model.Flight" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    FlightDAO dao = new FlightDAO();
    java.util.List<Flight> vuelos = dao.search("", "", java.time.LocalDate.now());
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<title>Vuelos</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: #f5f7fa;
        margin: 0;
        padding: 20px;
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 25px;
        font-size: 28px;
    }

    table {
        width: 90%;
        margin: auto;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 10px;
        overflow: hidden;
    }

    th {
        background: #007bff;
        color: white;
        padding: 14px;
        font-size: 16px;
        text-transform: uppercase;
    }

    td {
        padding: 12px;
        text-align: center;
        color: #444;
    }

    tr:nth-child(even) {
        background: #f2f6ff;
    }

    tr:hover {
        background: #dce8ff;
    }

    .btn-volver {
        display: block;
        width: 200px;
        margin: 25px auto;
        padding: 12px;
        background: #28a745;
        color: white;
        text-align: center;
        text-decoration: none;
        border-radius: 8px;
        transition: 0.3s;
    }

    .btn-volver:hover {
        background: #1e7e34;
    }
</style>
</head>

<body>

<h2>Vuelos Disponibles Hoy</h2>

<table>
<tr>
    <th>Código</th>
    <th>Origen</th>
    <th>Destino</th>
    <th>Salida</th>
    <th>Precio</th>
    <th>Disponible</th>
</tr>

<% for(Flight f : vuelos) { %>
<tr>
  <td><%=f.getCode()%></td>
  <td><%=f.getOrigin()%></td>
  <td><%=f.getDestination()%></td>
  <td><%=f.getDepartTime()%></td>
  <td>$ <%=f.getPrice()%></td>
  <td><%=f.getSeatsAvailable()%></td>
</tr>
<% } %>

</table>

<a class="btn-volver" href="inicio.jsp">Volver al Inicio</a>

</body>
</html>