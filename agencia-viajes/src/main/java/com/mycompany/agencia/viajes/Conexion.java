package com.mycompany.agencia.viajes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    private static final String URL = "jdbc:postgresql://localhost:54321/agencia_viajes";
    private static final String USER = "postgres";
    private static final String PASSWORD = "1234";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver"); // carga el driver
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error al cargar el driver de PostgreSQL", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}