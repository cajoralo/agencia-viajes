
package dao;
import com.mycompany.agencia.viajes.config.Conexion;
import model.Flight;

import java.sql.*;
import java.util.List;
public class BookingDAO {
   

    // Crea booking simple con un item (vuelo) - simplificado para ejemplo
    public int createBooking(int userId, int flightId, int qty, double totalAmount) throws SQLException {
        Connection c = null;
        String insertBooking = "INSERT INTO bookings(user_id,total_amount,status) VALUES (?,?,?) RETURNING id";
        String insertItem = "INSERT INTO booking_items (booking_id,item_type,item_ref,price,qty) VALUES (?,?,?,?,?)";
        String selectFlight = "SELECT price FROM flights WHERE id = ? FOR UPDATE";
        String updateFlight = "UPDATE flights SET seats_available = seats_available - ? WHERE id = ?";

        try {
            c = Conexion.getConnection();
            c.setAutoCommit(false);

            // Verificar precio/disponibilidad
            double price;
            try (PreparedStatement ps = c.prepareStatement(selectFlight)) {
                ps.setInt(1, flightId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        price = rs.getDouble("price");
                    } else {
                        c.rollback();
                        throw new SQLException("Flight not found");
                    }
                }
            }

            // Insert booking
            int bookingId;
            try (PreparedStatement ps = c.prepareStatement(insertBooking)) {
                ps.setInt(1, userId);
                ps.setDouble(2, totalAmount);
                ps.setString(3, "CONFIRMED");
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        bookingId = rs.getInt(1);
                    } else {
                        c.rollback();
                        throw new SQLException("No booking id returned");
                    }
                }
            }

            // Insert item
            try (PreparedStatement ps = c.prepareStatement(insertItem)) {
                ps.setInt(1, bookingId);
                ps.setString(2, "FLIGHT");
                ps.setInt(3, flightId);
                ps.setDouble(4, price);
                ps.setInt(5, qty);
                ps.executeUpdate();
            }

            // actualizar seats
            try (PreparedStatement ps = c.prepareStatement(updateFlight)) {
                ps.setInt(1, qty);
                ps.setInt(2, flightId);
                int rows = ps.executeUpdate();
                if (rows != 1) {
                    c.rollback();
                    throw new SQLException("No se pudo actualizar asientos");
                }
            }

            c.commit();
            return bookingId;

        } catch (SQLException ex) {
            if (c != null) try { c.rollback(); } catch(SQLException e){ e.printStackTrace(); }
            throw ex;
        } finally {
            if (c != null) {
                try { c.setAutoCommit(true); c.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}    

