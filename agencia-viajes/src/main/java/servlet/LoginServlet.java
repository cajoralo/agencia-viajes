
package servlet;

import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (userDAO.checkLogin(username, password)) {

            HttpSession session = req.getSession(true);
            session.setAttribute("user", userDAO.findByUsername(username));

            resp.sendRedirect("inicio.jsp");
        } else {
            req.setAttribute("error", "Usuario o contraseña incorrectos");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}