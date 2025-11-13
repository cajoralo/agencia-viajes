package com.mycompany.agencia.viajes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("username");
        String contrasena = request.getParameter("password");

        // 🔹 Login manual (usuario fijo en el código)
        if ("admin".equals(usuario) && "1234".equals(contrasena)) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            response.sendRedirect("paises.jsp");
        } else {
            response.sendRedirect("index.jsp?error=1");
        }
    }
}
