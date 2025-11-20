
package dao;
import com.mycompany.agencia.viajes.config.Conexion;
import model.Flight;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
public class FlightDAO {
 
    public List<Flight> search(String origin, String destination, LocalDate date) {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM flights WHERE origin ILIKE ? AND destination ILIKE ? AND DATE(depart_time) = ?";
        try (Connection c = Conexion.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + origin + "%");
            ps.setString(2, "%" + destination + "%");
            ps.setDate(3, Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Flight f = new Flight();
                    f.setId(rs.getInt("id"));
                    f.setCode(rs.getString("code"));
                    f.setOrigin(rs.getString("origin"));
                    f.setDestination(rs.getString("destination"));
                    Timestamp dt = rs.getTimestamp("depart_time");
                    Timestamp at = rs.getTimestamp("arrive_time");
                    f.setDepartTime(dt.toLocalDateTime());
                    f.setArriveTime(at.toLocalDateTime());
                    f.setPrice(rs.getDouble("price"));
                    f.setSeatsTotal(rs.getInt("seats_total"));
                    f.setSeatsAvailable(rs.getInt("seats_available"));
                    list.add(f);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Flight findById(int id) {
        String sql = "SELECT * FROM flights WHERE id = ?";
        try (Connection c = Conexion.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Flight f = new Flight();
                    f.setId(rs.getInt("id"));
                    f.setCode(rs.getString("code"));
                    f.setOrigin(rs.getString("origin"));
                    f.setDestination(rs.getString("destination"));
                    f.setDepartTime(rs.getTimestamp("depart_time").toLocalDateTime());
                    f.setArriveTime(rs.getTimestamp("arrive_time").toLocalDateTime());
                    f.setPrice(rs.getDouble("price"));
                    f.setSeatsTotal(rs.getInt("seats_total"));
                    f.setSeatsAvailable(rs.getInt("seats_available"));
                    return f;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // reduce seats with transaction (returns true if successful)
    public boolean reduceSeats(int flightId, int qty) {
        String select = "SELECT seats_available FROM flights WHERE id = ? FOR UPDATE";
        String update = "UPDATE flights SET seats_available = seats_available - ? WHERE id = ?";
        Connection c = null;
        try {
            c = Conexion.getConnection();
            c.setAutoCommit(false);
            try (PreparedStatement ps = c.prepareStatement(select)) {
                ps.setInt(1, flightId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int available = rs.getInt("seats_available");
                        if (available < qty) {
                            c.rollback();
                            return false;
                        }
                        try (PreparedStatement ps2 = c.prepareStatement(update)) {
                            ps2.setInt(1, qty);
                            ps2.setInt(2, flightId);
                            ps2.executeUpdate();
                        }
                        c.commit();
                        return true;
                    } else {
                        c.rollback();
                        return false;
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            try { if (c != null) c.rollback(); } catch (SQLException e) { e.printStackTrace(); }
            return false;
        } finally {
            try { if (c != null) c.setAutoCommit(true); if (c != null) c.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}

