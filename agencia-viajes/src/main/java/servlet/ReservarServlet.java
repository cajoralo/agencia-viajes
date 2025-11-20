
package servlet;

import dao.BookingDAO;
import dao.FlightDAO;
import model.Flight;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

    @WebServlet(name = "ReservarServlet", urlPatterns = {"/reservar"})
public class ReservarServlet extends HttpServlet {

    private final FlightDAO flightDAO = new FlightDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    protected void doPost(HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User u = (User) session.getAttribute("user");

        int flightId = Integer.parseInt(req.getParameter("flightId"));
        int qty = Integer.parseInt(req.getParameter("qty"));

        Flight f = flightDAO.findById(flightId);
        if (f == null) {
            req.setAttribute("error", "Vuelo no encontrado");
            req.getRequestDispatcher("/results.jsp").forward(req, resp);
            return;
        }

        if (f.getSeatsAvailable() < qty) {
            req.setAttribute("error", "No hay suficientes asientos");
            req.getRequestDispatcher("/results.jsp").forward(req, resp);
            return;
        }

        double total = f.getPrice() * qty;
        try {
            int bookingId = bookingDAO.createBooking(u.getId(), flightId, qty, total);
            req.setAttribute("message", "Reserva creada con ID: " + bookingId);
            req.getRequestDispatcher("/reservas.jsp").forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("error", "Error al crear la reserva: " + ex.getMessage());
            req.getRequestDispatcher("/results.jsp").forward(req, resp);
        }
    }
}

