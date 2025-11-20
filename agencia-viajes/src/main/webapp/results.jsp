
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head><title>Resultados</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #eef2f7;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        padding-top: 60px;
    }

    .card {
        background: #fff;
        width: 420px;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 0 15px rgba(0,0,0,0.12);
        text-align: center;
    }

    h2 {
        color: #333;
        margin-bottom: 25px;
        font-size: 26px;
    }

    .msg-error {
        background: #ffd4d4;
        color: #a10000;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 15px;
        font-size: 16px;
    }

    .msg-success {
        background: #d7ffdf;
        color: #009933;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 15px;
        font-size: 16px;
    }

    .btn {
        display: inline-block;
        padding: 12px 20px;
        margin-top: 15px;
        background: #007bff;
        color: #fff;
        text-decoration: none;
        font-size: 16px;
        border-radius: 8px;
        font-weight: bold;
        transition: 0.3s;
    }

    .btn:hover {
        background: #005fcc;
    }
</style>

</head>
<body>
<h2>Resultados</h2>
<c:if test="${not empty error}">
  <p style="color:red">${error}</p>
</c:if>
<c:if test="${not empty message}">
  <p style="color:green">${message}</p>
</c:if>
<a href="inicio.jsp">Volver</a>
</body>
</html>