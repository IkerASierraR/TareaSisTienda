package ModeloDAO;

import Config.clsConexion;
import Interfaces.CRUDCargo;
import Modelo.clsCargo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CargoDAO implements CRUDCargo {

    @Override
    public List<clsCargo> lista() {
        List<clsCargo> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM tbcargo";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                clsCargo car = new clsCargo();
                car.setIdcargo(rs.getInt("idcargo"));
                car.setNombre(rs.getString("nombre"));
                car.setEstado(rs.getInt("estado"));
                lista.add(car);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar cargos: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }

    @Override
    public clsCargo list(int idcar) {
        clsCargo car = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM tbcargo WHERE idcargo = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idcar);
            rs = ps.executeQuery();
            if (rs.next()) {
                car = new clsCargo();
                car.setIdcargo(rs.getInt("idcargo"));
                car.setNombre(rs.getString("nombre"));
                car.setEstado(rs.getInt("estado"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener cargo: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return car;
    }

    @Override
    public boolean add(clsCargo car) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "INSERT INTO tbcargo (nombre, estado) VALUES (?, ?)";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, car.getNombre());
            ps.setInt(2, car.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar cargo: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean edit(clsCargo car) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "UPDATE tbcargo SET nombre = ?, estado = ? WHERE idcargo = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, car.getNombre());
            ps.setInt(2, car.getEstado());
            ps.setInt(3, car.getIdcargo());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al editar cargo: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean eliminar(int idcar) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "DELETE FROM tbcargo WHERE idcargo = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idcar);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al eliminar cargo: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }
    
    
}