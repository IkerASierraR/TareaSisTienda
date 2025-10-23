package ModeloDAO;

import Config.clsConexion;
import Interfaces.CRUDUsuario;
import Modelo.clsUsuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO implements CRUDUsuario {
    Connection con;
    clsConexion cn = new clsConexion();
    PreparedStatement ps;
    ResultSet rs;
    
    @Override
    public clsUsuario validar(String usuario, String clave) {
        clsUsuario user = null;
        String sql = "SELECT idUsuario, Nombre, Clave, tipo FROM tbusuarios WHERE Nombre = ? AND Clave = ? AND (tipo = 'empleado' OR tipo = 'cliente')";
        
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, clave);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                user = new clsUsuario();
                user.setidUsuario(rs.getInt("idUsuario"));
                user.setNombre(rs.getString("Nombre"));
                user.setClave(rs.getString("Clave"));
                user.settipo(rs.getString("tipo"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return user;
    }
}