package ModeloDAO;

import Config.clsConexion;
import Interfaces.CRUDEmpleado;
import Modelo.clsEmpleado;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO implements CRUDEmpleado {

    @Override
    public List<clsEmpleado> lista() {
        List<clsEmpleado> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT e.*, c.nombre as nombreCargo, td.nombre as nombreDocumento " +
                     "FROM tbempleado e " +
                     "INNER JOIN tbcargo c ON e.idcargo = c.idcargo " +
                     "INNER JOIN tbtipodocumento td ON e.idTipoDocumento = td.idtipodocumento";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                clsEmpleado emp = new clsEmpleado();
                emp.setIdEmpleado(rs.getInt("idEmpleado"));
                emp.setNombre(rs.getString("Nombre"));
                emp.setApellido(rs.getString("Apellido"));
                emp.setIdcargo(rs.getInt("idcargo"));
                emp.setUsuario(rs.getString("Usuario"));
                emp.setClave(rs.getString("Clave"));
                emp.setIdTipoDocumento(rs.getInt("idTipoDocumento"));
                emp.setNumeroDocumento(rs.getString("NumeroDocumento"));
                emp.setTelefono(rs.getString("Telefono"));
                emp.setEstado(rs.getInt("Estado"));
                emp.setNombreCargo(rs.getString("nombreCargo"));
                emp.setNombreDocumento(rs.getString("nombreDocumento"));
                lista.add(emp);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar empleados: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }

    @Override
    public clsEmpleado list(int idEmp) {
        clsEmpleado emp = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT e.*, c.nombre as nombreCargo, td.nombre as nombreDocumento " +
                     "FROM tbempleado e " +
                     "INNER JOIN tbcargo c ON e.idcargo = c.idcargo " +
                     "INNER JOIN tbtipodocumento td ON e.idTipoDocumento = td.idtipodocumento " +
                     "WHERE e.idEmpleado = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idEmp);
            rs = ps.executeQuery();
            if (rs.next()) {
                emp = new clsEmpleado();
                emp.setIdEmpleado(rs.getInt("idEmpleado"));
                emp.setNombre(rs.getString("Nombre"));
                emp.setApellido(rs.getString("Apellido"));
                emp.setIdcargo(rs.getInt("idcargo"));
                emp.setUsuario(rs.getString("Usuario"));
                emp.setClave(rs.getString("Clave"));
                emp.setIdTipoDocumento(rs.getInt("idTipoDocumento"));
                emp.setNumeroDocumento(rs.getString("NumeroDocumento"));
                emp.setTelefono(rs.getString("Telefono"));
                emp.setEstado(rs.getInt("Estado"));
                emp.setNombreCargo(rs.getString("nombreCargo"));
                emp.setNombreDocumento(rs.getString("nombreDocumento"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener empleado: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return emp;
    }

    @Override
    public boolean add(clsEmpleado emp) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "INSERT INTO tbempleado (Nombre, Apellido, idcargo, Usuario, Clave, idTipoDocumento, NumeroDocumento, Telefono, Estado) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, emp.getNombre());
            ps.setString(2, emp.getApellido());
            ps.setInt(3, emp.getIdcargo());
            ps.setString(4, emp.getUsuario());
            ps.setString(5, emp.getClave());
            ps.setInt(6, emp.getIdTipoDocumento());
            ps.setString(7, emp.getNumeroDocumento());
            ps.setString(8, emp.getTelefono());
            ps.setInt(9, emp.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar empleado: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean edit(clsEmpleado emp) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "UPDATE tbempleado SET Nombre=?, Apellido=?, idcargo=?, Usuario=?, Clave=?, " +
                     "idTipoDocumento=?, NumeroDocumento=?, Telefono=?, Estado=? WHERE idEmpleado=?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, emp.getNombre());
            ps.setString(2, emp.getApellido());
            ps.setInt(3, emp.getIdcargo());
            ps.setString(4, emp.getUsuario());
            ps.setString(5, emp.getClave());
            ps.setInt(6, emp.getIdTipoDocumento());
            ps.setString(7, emp.getNumeroDocumento());
            ps.setString(8, emp.getTelefono());
            ps.setInt(9, emp.getEstado());
            ps.setInt(10, emp.getIdEmpleado());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al editar empleado: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean eliminar(int idEmp) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "DELETE FROM tbempleado WHERE idEmpleado = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idEmp);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al eliminar empleado: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }
}