
package servlet;


import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet(name="EnviarRecuperacion", urlPatterns={"/enviarRecuperacion"})
public class EnviarRecuperacion extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");

        if (correo == null || correo.isEmpty()) {
            request.setAttribute("mensaje", "Ingrese un correo.");
            request.getRequestDispatcher("recuperar.jsp").forward(request, response);
            return;
        }

        if (!userDAO.correoExiste(correo)) {
            request.setAttribute("mensaje", "El correo no está registrado.");
            request.getRequestDispatcher("recuperar.jsp").forward(request, response);
            return;
        }

        int codigo = new Random().nextInt(900000) + 100000; // 6 dígitos

        HttpSession sesion = request.getSession();
        sesion.setAttribute("codigoRecuperacion", codigo);
        sesion.setAttribute("correoRecuperacion", correo);

        // --- CONFIGURACIÓN DE CORREO (reemplaza) ---
        final String remitente = "tucorreo@gmail.com";
        final String claveApp = "tu_clave_app";
        Properties props = new Properties();
        props.put("mail.smtp.host","smtp.gmail.com");
        props.put("mail.smtp.port","587");
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.starttls.enable","true");

        Session sessionMail = Session.getInstance(props,
            new jakarta.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(remitente, claveApp);
                }
            });

        try {
            Message msg = new MimeMessage(sessionMail);
            msg.setFrom(new InternetAddress(remitente));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correo));
            msg.setSubject("Código de recuperación - Agencia Viajes");
            msg.setText("Tu código de recuperación es: " + codigo);

            Transport.send(msg);

            request.setAttribute("mensaje", "Se envió el código a tu correo.");
            request.getRequestDispatcher("ingresarCodigo.jsp").forward(request, response);

        } catch (MessagingException e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error enviando correo. Intente más tarde.");
            request.getRequestDispatcher("recuperar.jsp").forward(request, response);
        }
    }
}
