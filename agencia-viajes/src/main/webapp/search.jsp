<%@ page import="dao.FlightDAO,model.Flight" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String origin = request.getParameter("origin") != null ? request.getParameter("origin") : "";
    String destination = request.getParameter("destination") != null ? request.getParameter("destination") : "";
    String dateStr = request.getParameter("date");
    java.time.LocalDate date = dateStr != null && !dateStr.isEmpty() ? java.time.LocalDate.parse(dateStr) : java.time.LocalDate.now();
    FlightDAO dao = new FlightDAO();
    java.util.List<Flight> results = dao.search(origin, destination, date);
    request.setAttribute("results", results);
%>
<html>
<head><title>Resultados</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #eef2f7;
        margin: 0;
        padding: 20px;
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 25px;
        font-size: 28px;
    }

    .error {
        text-align: center;
        background: #ffd4d4;
        color: #a10000;
        padding: 12px;
        border-radius: 8px;
        width: 80%;
        margin: 15px auto;
        font-size: 16px;
    }

    table {
        width: 90%;
        margin: auto;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        border-radius: 10px;
        overflow: hidden;
    }

    th {
        background: #007bff;
        color: white;
        padding: 14px;
        text-transform: uppercase;
        font-size: 14px;
    }

    td {
        padding: 12px;
        text-align: center;
        color: #444;
    }

    tr:nth-child(even) {
        background: #f3f7ff;
    }

    tr:hover {
        background: #dce6ff;
    }

    input[type="number"] {
        width: 60px;
        padding: 6px;
        border: 1px solid #aaa;
        border-radius: 6px;
        text-align: center;
    }

    button {
        background: #28a745;
        color: white;
        border: none;
        padding: 8px 14px;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #1f7f34;
    }
</style>

</head>
<body>
<h2>Resultados</h2>
<c:if test="${not empty error}">
  <p style="color:red">${error}</p>
</c:if>
<table border="1">
<tr><th>Codigo</th><th>Origen</th><th>Destino</th><th>Salida</th><th>Precio</th><th>Disponible</th><th>Acción</th></tr>
<% for (Flight f : results) { %>
<tr>
  <td><%=f.getCode()%></td>
  <td><%=f.getOrigin()%></td>
  <td><%=f.getDestination()%></td>
  <td><%=f.getDepartTime()%></td>
  <td><%=f.getPrice()%></td>
  <td><%=f.getSeatsAvailable()%></td>
  <td>
    <form action="<%=request.getContextPath()%>/reservar" method="post">
      <input type="hidden" name="flightId" value="<%=f.getId()%>"/>
      Cant: <input type="number" name="qty" value="1" min="1" max="<%=f.getSeatsAvailable()%>"/>
      <button type="submit">Reservar</button>
    </form>
  </td>
</tr>
<% } %>
</table>
</body>
</html>