<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<title>Login - Agencia de Viajes</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }


body {
background-image: url("https://images.unsplash.com/photo-1507525428034-b723cf961d3e");
background-size: cover;
background-position: center;
height: 100vh;
display: flex;
justify-content: center;
align-items: center;
}


.login-container {
backdrop-filter: blur(10px);
background: rgba(255,255,255,0.2);
padding: 40px;
border-radius: 15px;
width: 350px;
box-shadow: 0 0 15px rgba(0,0,0,0.3);
}


h2 {
text-align: center;
margin-bottom: 25px;
color: #fff;
font-size: 28px;
text-shadow: 1px 1px 2px #000;
}


.group {
margin-bottom: 20px;
}


label {
color: white;
font-weight: bold;
text-shadow: 1px 1px 2px #000;
}


input {
width: 100%;
padding: 10px;
border-radius: 8px;
border: none;
margin-top: 5px;
outline: none;
}


button {
width: 100%;
padding: 12px;
background: #007bff;
border: none;
border-radius: 8px;
</style>
</head>
<body>
    <div class="login-container">
        <h2>Iniciar Sesión</h2>


        <form action="inicio.jsp" method="post">
            <div class="group">
                <label>Usuario:</label>
                <input type="text" name="user" placeholder="Ingrese su usuario" required />
            </div>


            <div class="group">
                <label>Contraseña:</label>
                <input type="password" name="pass" placeholder="Ingrese su contraseña" required />
            </div>


            <button type="submit">Entrar</button>
            <a href="recuperar.jsp" style="display:block;margin-top:15px;text-align:center;color:#fff;text-shadow:1px 1px 2px #000;">¿Olvidaste tu contraseña?</a>
            <a href="cambiarClave.jsp" style="display:block;margin-top:10px;text-align:center;color:#fff;text-shadow:1px 1px 2px #000;">Cambiar contraseña</a>
        </form>
    </div>


</body>
</html>