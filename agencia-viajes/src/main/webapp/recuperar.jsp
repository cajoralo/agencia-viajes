
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Recuperar Contraseña</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    body {
        background-image: url("https://images.unsplash.com/photo-1507525428034-b723cf961d3e");
        background-size: cover;
        background-position: center;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .container {
        background: rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(12px);
        padding: 40px;
        border-radius: 15px;
        width: 350px;
        box-shadow: 0 0 15px rgba(0,0,0,0.4);
        text-align: center;
    }

    h2 {
        color: #fff;
        margin-bottom: 25px;
        font-size: 26px;
        text-shadow: 1px 1px 3px #000;
    }

    label {
        color: white;
        display: block;
        margin-bottom: 8px;
        text-shadow: 1px 1px 2px #000;
        font-weight: bold;
        text-align: left;
    }

    input {
        width: 100%;
        padding: 12px;
        border-radius: 8px;
        border: none;
        outline: none;
        margin-bottom: 15px;
    }

    button {
        width: 100%;
        padding: 12px;
        background: #007bff;
        border: none;
        border-radius: 8px;
        color: white;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #0056b3;
    }

    .mensaje-error {
        color: #ffdddd;
        margin-top: 12px;
        font-weight: bold;
        text-shadow: 1px 1px 2px #000;
    }
</style>
</head>

<body>

    <div class="container">
        <h2>Recuperar Contraseña</h2>

        <form action="enviarRecuperacion" method="post">
            <input type="email" name="correo" placeholder="Correo registrado" required />
            <button type="submit">Enviar código</button>
        </form>

        <p class="mensaje-error">${mensaje}</p>
    </div>

</body>
</html>