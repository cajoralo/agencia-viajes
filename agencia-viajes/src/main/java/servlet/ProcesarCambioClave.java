
package servlet;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name="ProcesarCambioClave", urlPatterns={"/procesarCambioClave"})
public class ProcesarCambioClave extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Integer codigoCorrecto = (Integer) sesion.getAttribute("codigoRecuperacion");
        String correo = (String) sesion.getAttribute("correoRecuperacion");

        String codigoIngresadoStr = request.getParameter("codigo");
        String nuevaClave = request.getParameter("nuevaClave");
        String confirmar = request.getParameter("confirmar");

        if (codigoCorrecto == null || correo == null) {
            request.setAttribute("mensaje", "Sesión expirada. Genere un nuevo código.");
            request.getRequestDispatcher("recuperar.jsp").forward(request, response);
            return;
        }

        if (codigoIngresadoStr == null || codigoIngresadoStr.isEmpty()) {
            request.setAttribute("mensaje", "Ingrese el código enviado.");
            request.getRequestDispatcher("ingresarCodigo.jsp").forward(request, response);
            return;
        }

        int codigoIngresado;
        try {
            codigoIngresado = Integer.parseInt(codigoIngresadoStr);
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "Código inválido.");
            request.getRequestDispatcher("ingresarCodigo.jsp").forward(request, response);
            return;
        }

        if (codigoIngresado != codigoCorrecto) {
            request.setAttribute("mensaje", "Código incorrecto.");
            request.getRequestDispatcher("ingresarCodigo.jsp").forward(request, response);
            return;
        }

        if (nuevaClave == null || !nuevaClave.equals(confirmar)) {
            request.setAttribute("mensaje", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("cambiarClave.jsp").forward(request, response);
            return;
        }

        // Actualizar en BD
        boolean ok = userDAO.actualizarClave(correo, nuevaClave);
        if (!ok) {
            request.setAttribute("mensaje", "Error al actualizar la contraseña.");
            request.getRequestDispatcher("cambiarClave.jsp").forward(request, response);
            return;
        }

        sesion.removeAttribute("codigoRecuperacion");
        sesion.removeAttribute("correoRecuperacion");

        request.setAttribute("mensaje", "Contraseña actualizada correctamente. Inicia sesión.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
