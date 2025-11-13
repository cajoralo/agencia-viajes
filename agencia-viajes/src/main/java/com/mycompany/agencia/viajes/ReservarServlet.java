package com.mycompany.agencia.viajes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ReservarServlet")
public class ReservarServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = (String) request.getSession().getAttribute("usuario");
        int paisId = Integer.parseInt(request.getParameter("pais_id"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        try (Connection conn = Conexion.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO reservas (usuario, pais_id, cantidad) VALUES (?, ?, ?)"
            );
            ps.setString(1, usuario);
            ps.setInt(2, paisId);
            ps.setInt(3, cantidad);
            ps.executeUpdate();

            response.sendRedirect("reservas.jsp");
        } catch (SQLException e) {
            response.getWriter().println("Error al reservar: " + e.getMessage());
        }
    }
}