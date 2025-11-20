package dao;

import com.mycompany.agencia.viajes.config.Conexion;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class UserDAO {

   public boolean correoExiste(String correo) {
        String sql = "SELECT 1 FROM usuario WHERE correo = ?";
        try (Connection c = Conexion.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, correo);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

   public boolean validarClaveActual(String correo, String claveActual) {
        String sql = "SELECT 1 FROM usuario WHERE correo = ? AND clave = ?";
        try (Connection c = Conexion.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, correo);
            ps.setString(2, claveActual);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarClave(String correo, String nuevaClave) {
        String sql = "UPDATE usuario SET clave = ? WHERE correo = ?";
        try (Connection c = Conexion.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, nuevaClave);
            ps.setString(2, correo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
public boolean checkLogin(String username, String password) {
    String sql = "SELECT * FROM users WHERE username = ? AND passwordHash = ?";

    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, username);
        ps.setString(2, password); // si luego usas hash aquí cambiará

        ResultSet rs = ps.executeQuery();
        return rs.next();

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
public User findByUsername(String username) {

    String sql = "SELECT * FROM users WHERE username = ?";

    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, username);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            User u = new User();

            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPasswordHash(rs.getString("passwordHash"));
            u.setFullName(rs.getString("fullName"));
            u.setEmail(rs.getString("email"));
            u.setPhone(rs.getString("phone"));
            u.setRole(rs.getString("role"));

            return u;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}
}