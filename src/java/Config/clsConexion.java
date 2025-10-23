package Config;

import java.sql.*;

public class clsConexion {
    
    private static final String URL = "jdbc:mysql://localhost:3306/bdsistienda_iasr?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Conexión exitosa a la base de datos.");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver no encontrado - " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error de conexión BD: " + e.getMessage());
        }
        return con;
    }

    public static void closeResources(ResultSet rs, PreparedStatement ps) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            System.err.println("Error cerrando recursos: " + e.getMessage());
        }
    }

    public static void close(PreparedStatement ps) {
        closeResources(null, ps);
    }

    public static void close(ResultSet rs) {
        closeResources(rs, null);
    }
}