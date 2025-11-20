

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Ingresar Código</title></head>
<body style="background:url('/mnt/data/0d0354b0-381a-4723-89bb-b8a617bf6efa.png') center/cover no-repeat;">
  <h2>Ingrese el código enviado a su correo</h2>
  <form action="procesarCambioClave" method="post">
    <input type="text" name="codigo" placeholder="Código" required />
    <input type="password" name="nuevaClave" placeholder="Nueva contraseña" required />
    <input type="password" name="confirmar" placeholder="Confirmar contraseña" required />
    <button type="submit">Cambiar contraseña</button>
  </form>
  <p style="color:red">${mensaje}</p>
</body>
</html>