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
    <h1>Lista de Países</h1>
    <nav>
        <a href="reservas.jsp">Mis Reservas</a>
        <a href="logout.jsp">Cerrar Sesión</a>
    </nav>
</header>

<div class="container">
    <h2>Todos los Paquetes Disponibles</h2>
    <div class="grid">

<%
    // Lista de más de 50 países con descripción e imagen real
    String[][] paises = {
        {"Argentina", "Explora Buenos Aires, la Patagonia y las Cataratas del Iguazú.", "https://images.unsplash.com/photo-1579762593025-1c79685a877c"},
        {"Chile", "Desde el desierto de Atacama hasta los glaciares del sur.", "https://images.unsplash.com/photo-1526318472351-c75fcf07095b"},
        {"Perú", "Descubre Machu Picchu y la cultura inca.", "https://images.unsplash.com/photo-1505672678657-cc7037095e2c"},
        {"Ecuador", "Aventura en Galápagos y el centro del mundo.", "https://images.unsplash.com/photo-1508264165352-258859e62245"},
        {"Colombia", "Playas del Caribe y ciudades vibrantes como Medellín.", "https://images.unsplash.com/photo-1568192436745-3c5a5fda8f91"},
        {"México", "Ruinas mayas, playas y gastronomía incomparable.", "https://images.unsplash.com/photo-1576306468606-abc7f2d92c94"},
        {"Estados Unidos", "De Nueva York a California, el país de la diversidad.", "https://images.unsplash.com/photo-1506744038136-46273834b3fb"},
        {"Canadá", "Naturaleza, lagos y montañas impresionantes.", "https://images.unsplash.com/photo-1506744038136-46273834b3fb"},
        {"España", "Historia, playas y la pasión del flamenco.", "https://images.unsplash.com/photo-1505567745926-ba89000d255a"},
        {"Francia", "El encanto de París y los viñedos del sur.", "https://images.unsplash.com/photo-1502602898657-3e91760cbb34"},
        {"Italia", "Roma, Venecia y la auténtica comida italiana.", "https://images.unsplash.com/photo-1523475496153-3d6ccdb1a7b4"},
        {"Alemania", "Castillos, cerveza y cultura en cada rincón.", "https://images.unsplash.com/photo-1595821052544-fc0f87b9b3a9"},
        {"Reino Unido", "Londres, Escocia y paisajes históricos.", "https://images.unsplash.com/photo-1488747279002-c8523379faaa"},
        {"Portugal", "Playas del Algarve y el encanto de Lisboa.", "https://images.unsplash.com/photo-1563453392214-326f35b9c08b"},
        {"Países Bajos", "Canales, tulipanes y bicicletas en Ámsterdam.", "https://images.unsplash.com/photo-1506466010722-395aa2bef877"},
        {"Suiza", "Los Alpes, relojes y chocolate suizo.", "https://images.unsplash.com/photo-1470770841072-f978cf4d019e"},
        {"Austria", "Montañas, música clásica y arquitectura imperial.", "https://images.unsplash.com/photo-1505761671935-60b3a7427bad"},
        {"Suecia", "Diseño moderno y belleza natural.", "https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba"},
        {"Noruega", "Fiordos impresionantes y auroras boreales.", "https://images.unsplash.com/photo-1503264116251-35a269479413"},
        {"Finlandia", "Saunas, lagos y la casa de Santa Claus.", "https://images.unsplash.com/photo-1517777298220-7f1c2f83eabd"},
        {"Dinamarca", "Copenhague y el estilo nórdico de vida.", "https://images.unsplash.com/photo-1549893079-842e6e12b1fa"},
        {"Grecia", "Islas paradisíacas y ruinas antiguas.", "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"},
        {"Turquía", "Estambul y la mezcla entre Oriente y Occidente.", "https://images.unsplash.com/photo-1505735454784-02f239a7a3e0"},
        {"Marruecos", "Desiertos, zocos y la mágica Marrakech.", "https://images.unsplash.com/photo-1559589689-577aabd1db4e"},
        {"Egipto", "Las pirámides y el majestuoso río Nilo.", "https://images.unsplash.com/photo-1554215193-57f9643d21b4"},
        {"Sudáfrica", "Safaris, playas y la Table Mountain.", "https://images.unsplash.com/photo-1535914254981-b5012eebbd15"},
        {"Kenia", "Aventuras en la sabana africana.", "https://images.unsplash.com/photo-1551854838-212c50b4c0b8"},
        {"India", "El Taj Mahal y una cultura milenaria.", "https://images.unsplash.com/photo-1509927089733-56c28aa06e8a"},
        {"China", "La Gran Muralla y ciudades futuristas.", "https://images.unsplash.com/photo-1549890762-0a3f89b80b55"},
        {"Japón", "Tecnología, templos y tradición.", "https://images.unsplash.com/photo-1549693578-d683be217e58"},
        {"Corea del Sur", "Cultura pop, historia y gastronomía.", "https://images.unsplash.com/photo-1517824806704-9040b037703b"},
        {"Tailandia", "Playas, templos y vida nocturna.", "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"},
        {"Vietnam", "Bahía de Halong y paisajes verdes.", "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"},
        {"Indonesia", "Bali y miles de islas exóticas.", "https://images.unsplash.com/photo-1493558103817-58b2924bce98"},
        {"Australia", "Sídney, la Gran Barrera de Coral y desiertos rojos.", "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"},
        {"Nueva Zelanda", "Montañas, lagos y paisajes de película.", "https://images.unsplash.com/photo-1502786129293-79981df4e689"},
        {"Rusia", "Moscú, San Petersburgo y su vasta historia.", "https://images.unsplash.com/photo-1549890762-0a3f89b80b55"},
        {"Polonia", "Cracovia y la historia europea.", "https://images.unsplash.com/photo-1534351442741-8c9f32f6b9d8"},
        {"Hungría", "Budapest y sus termas.", "https://images.unsplash.com/photo-1551887373-6b3f8e51f2aa"},
        {"República Checa", "Praga, la ciudad de las cien torres.", "https://images.unsplash.com/photo-1562004760-aceed7bb0fe1"},
        {"Croacia", "Playas del Adriático y ciudades medievales.", "https://images.unsplash.com/photo-1568572933382-74d440642117"},
        {"Islandia", "Volcanes, cascadas y auroras boreales.", "https://images.unsplash.com/photo-1521207418485-99c705420785"},
        {"Filipinas", "Islas paradisíacas y gente amable.", "https://images.unsplash.com/photo-1535121897125-913f7b59c5b8"},
        {"Malasia", "Modernidad y selvas tropicales.", "https://images.unsplash.com/photo-1506744038136-46273834b3fb"},
        {"Singapur", "Ciudad moderna y limpia del sudeste asiático.", "https://images.unsplash.com/photo-1506744038136-46273834b3fb"},
        {"Arabia Saudita", "El desierto y las ciudades futuristas.", "https://images.unsplash.com/photo-1571786256017-aee7a0c009b0"},
        {"Emiratos Árabes Unidos", "Dubái y Abu Dabi: lujo y modernidad.", "https://images.unsplash.com/photo-1512453979798-5ea266f8880c"},
        {"Qatar", "Lujo árabe y cultura del Golfo.", "https://images.unsplash.com/photo-1549893079-842e6e12b1fa"}
    };

    for (int i = 0; i < paises.length; i++) {
        String nombre = paises[i][0];
        String descripcion = paises[i][1];
        String imagen = paises[i][2] + "?w=800&h=600&fit=crop";

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
                    <input type="hidden" name="pais_id" value="<%= i+1 %>">
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
%>

    </div>
</div>

</body>
</html>