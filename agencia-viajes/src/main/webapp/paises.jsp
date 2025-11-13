<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Paquetes de Viajes - Agencia Mundial</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f2f5f7;
        }

        header {
            background-color: #0077b6;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            font-size: 22px;
            margin: 0;
        }

        header nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: 500;
        }

        header nav a:hover {
            text-decoration: underline;
        }

        h2 {
            text-align: center;
            margin-top: 25px;
            color: #023e8a;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 40px;
        }

        .card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .card-content {
            padding: 15px;
        }

        .card-content h3 {
            margin: 0;
            font-size: 18px;
            color: #0077b6;
        }

        .card-content p {
            margin: 8px 0;
            color: #555;
        }

        .btn {
            display: block;
            text-align: center;
            background-color: #0096c7;
            color: white;
            padding: 8px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #0077b6;
        }

        footer {
            background-color: #023e8a;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
<header>
    <h1>🌎 Agencia Mundial de Viajes</h1>
    <nav>
        <a href="#">Inicio</a>
        <a href="#">Paquetes</a>
        <a href="#">Promociones</a>
        <a href="#">Contacto</a>
        <a href="LogoutServlet">Cerrar Sesión</a>
    </nav>
</header>

<h2>Todos los Paquetes Disponibles</h2>

<div class="grid">
    <%-- 🌍 Lista de los países  --%>
    <%
        String[][] destinos = {
            {"Cartagena - Colombia", "4 días / 3 noches", "$450 USD", "https://upload.wikimedia.org/wikipedia/commons/5/5b/Cartagena_de_Indias_-_Colombia.jpg"},
            {"Cancún - México", "5 días / 4 noches", "$780 USD", "https://upload.wikimedia.org/wikipedia/commons/4/4d/Cancun_Beach.jpg"},
            {"Punta Cana - República Dominicana", "6 días / 5 noches", "$890 USD", "https://upload.wikimedia.org/wikipedia/commons/b/bf/Punta_Cana_Beach.jpg"},
            {"Barcelona - España", "7 días / 4 noches", "$1200 USD", "https://upload.wikimedia.org/wikipedia/commons/9/99/Barcelona_Skyline.jpg"},
            {"París - Francia", "6 días / 5 noches", "$1500 USD", "https://upload.wikimedia.org/wikipedia/commons/a/a8/Tour_Eiffel_Wikimedia_Commons.jpg"},
            {"Roma - Italia", "5 días / 4 noches", "$980 USD", "https://upload.wikimedia.org/wikipedia/commons/d/d2/Colosseo_2020.jpg"},
            {"Londres - Reino Unido", "6 días / 5 noches", "$1300 USD", "https://upload.wikimedia.org/wikipedia/commons/f/fd/Palace_of_Westminster_from_the_dome_on_Methodist_Central_Hall.jpg"},
            {"Nueva York - EE.UU.", "5 días / 4 noches", "$1250 USD", "https://upload.wikimedia.org/wikipedia/commons/a/a1/Manhattan_skyline_from_Hudson_River.jpg"},
            {"Buenos Aires - Argentina", "4 días / 3 noches", "$850 USD", "https://upload.wikimedia.org/wikipedia/commons/1/12/Buenos_Aires_Cityscape.jpg"},
            {"Río de Janeiro - Brasil", "5 días / 4 noches", "$950 USD", "https://upload.wikimedia.org/wikipedia/commons/9/93/Rio_de_Janeiro_-_View_of_Sugarloaf_Mountain.jpg"},
            {"Santiago - Chile", "4 días / 3 noches", "$770 USD", "https://upload.wikimedia.org/wikipedia/commons/4/4b/Santiago_de_Chile_panorama.jpg"},
            {"Lima - Perú", "5 días / 4 noches", "$620 USD", "https://upload.wikimedia.org/wikipedia/commons/8/8f/Lima_Skyline_Miraflores.jpg"},
            {"Tokio - Japón", "7 días / 6 noches", "$2100 USD", "https://upload.wikimedia.org/wikipedia/commons/1/12/Tokyo_Skyline_and_Mount_Fuji.jpg"},
            {"Seúl - Corea del Sur", "6 días / 5 noches", "$1900 USD", "https://upload.wikimedia.org/wikipedia/commons/8/8f/Seoul_skyline_at_night.jpg"},
            {"Bangkok - Tailandia", "5 días / 4 noches", "$980 USD", "https://upload.wikimedia.org/wikipedia/commons/9/9e/Bangkok_City_Skyline.jpg"},
            {"Dubái - Emiratos Árabes", "6 días / 5 noches", "$2400 USD", "https://upload.wikimedia.org/wikipedia/commons/a/a6/Dubai_skyline_2015.jpg"},
            {"Sídney - Australia", "7 días / 6 noches", "$2300 USD", "https://upload.wikimedia.org/wikipedia/commons/1/1c/Sydney_Opera_House_and_Harbour_Bridge.jpg"},
            {"Atenas - Grecia", "6 días / 5 noches", "$1500 USD", "https://upload.wikimedia.org/wikipedia/commons/d/d6/Acropolis_Athens_2019.jpg"},
            {"El Cairo - Egipto", "5 días / 4 noches", "$1250 USD", "https://upload.wikimedia.org/wikipedia/commons/e/e3/The_Great_Pyramid_of_Giza_%28Khufu%29.jpg"},
            {"Moscú - Rusia", "6 días / 5 noches", "$1600 USD", "https://upload.wikimedia.org/wikipedia/commons/f/fb/Red_Square_Moscow.jpg"},
            {"Berlín - Alemania", "5 días / 4 noches", "$1400 USD", "https://upload.wikimedia.org/wikipedia/commons/d/d9/Berlin_Brandenburg_Gate.jpg"},
            {"Ámsterdam - Países Bajos", "5 días / 4 noches", "$1350 USD", "https://upload.wikimedia.org/wikipedia/commons/8/8f/Amsterdam_Canals.jpg"},
            {"Zúrich - Suiza", "6 días / 5 noches", "$1700 USD", "https://upload.wikimedia.org/wikipedia/commons/f/f3/Z%C3%BCrich_skyline.jpg"},
            {"Lisboa - Portugal", "5 días / 4 noches", "$1200 USD", "https://upload.wikimedia.org/wikipedia/commons/4/4c/Lisbon_Cityscape.jpg"},
            {"Estambul - Turquía", "6 días / 5 noches", "$1400 USD", "https://upload.wikimedia.org/wikipedia/commons/7/7a/Istanbul_Skyline.jpg"},
            {"Marrakech - Marruecos", "5 días / 4 noches", "$1100 USD", "https://upload.wikimedia.org/wikipedia/commons/6/6e/Marrakech_Souk.jpg"},
            {"Toronto - Canadá", "6 días / 5 noches", "$1500 USD", "https://upload.wikimedia.org/wikipedia/commons/c/c0/Toronto_Skyline_2017.jpg"},
            {"Los Ángeles - EE.UU.", "5 días / 4 noches", "$1300 USD", "https://upload.wikimedia.org/wikipedia/commons/5/57/Los_Angeles_Skyline_at_Night.jpg"},
            {"San Francisco - EE.UU.", "5 días / 4 noches", "$1400 USD", "https://upload.wikimedia.org/wikipedia/commons/0/0c/Golden_Gate_Bridge.jpg"},
            {"Ciudad de Panamá - Panamá", "4 días / 3 noches", "$850 USD", "https://upload.wikimedia.org/wikipedia/commons/a/a8/Panama_City_Skyline.jpg"},
            {"Montevideo - Uruguay", "4 días / 3 noches", "$780 USD", "https://upload.wikimedia.org/wikipedia/commons/1/1d/Montevideo_Rambla.jpg"},
            {"Bogotá - Colombia", "5 días / 4 noches", "$820 USD", "https://upload.wikimedia.org/wikipedia/commons/6/67/Bogota_Skyline.jpg"},
            {"Quito - Ecuador", "5 días / 4 noches", "$790 USD", "https://upload.wikimedia.org/wikipedia/commons/6/61/Quito_Cityscape.jpg"},
            {"La Paz - Bolivia", "5 días / 4 noches", "$730 USD", "https://upload.wikimedia.org/wikipedia/commons/e/e5/La_Paz_Bolivia_Skyline.jpg"},
            {"Cusco - Perú", "4 días / 3 noches", "$760 USD", "https://upload.wikimedia.org/wikipedia/commons/1/10/Cusco_Plaza_de_Armas.jpg"},
            {"Medellín - Colombia", "4 días / 3 noches", "$740 USD", "https://upload.wikimedia.org/wikipedia/commons/8/8c/Medellin_Skyline.jpg"},
            {"Guayaquil - Ecuador", "4 días / 3 noches", "$700 USD", "https://upload.wikimedia.org/wikipedia/commons/a/a8/Malecon_2000_Guayaquil.jpg"},
            {"Asunción - Paraguay", "4 días / 3 noches", "$720 USD", "https://upload.wikimedia.org/wikipedia/commons/e/e4/Asuncion_Skyline.jpg"},
            {"San José - Costa Rica", "5 días / 4 noches", "$810 USD", "https://upload.wikimedia.org/wikipedia/commons/f/f5/San_Jose_Costa_Rica_Cityscape.jpg"},
            {"Montego Bay - Jamaica", "5 días / 4 noches", "$890 USD", "https://upload.wikimedia.org/wikipedia/commons/a/a6/Montego_Bay_Jamaica.jpg"},
            {"La Habana - Cuba", "5 días / 4 noches", "$840 USD", "https://upload.wikimedia.org/wikipedia/commons/0/0e/Havana_Malecon_Cuba.jpg"}
        };

        for (String[] destino : destinos) {
    %>
    <div class="card">
        <img src="<%= destino[3] %>" alt="<%= destino[0] %>">
        <div class="card-content">
            <h3><%= destino[0] %></h3>
            <p><%= destino[1] %></p>
            <p><strong><%= destino[2] %></strong></p>
            <a href="#" class="btn">Ver Detalles</a>
        </div>
    </div>
    <% } %>
</div>

<footer>
    © 2025 Agencia Mundial de Viajes | Todos los derechos reservados
</footer>

</body>
</html>