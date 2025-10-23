package ModeloDAO;

import Config.clsConexion;
import Interfaces.CRUDCliente;
import Modelo.clsCliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO implements CRUDCliente {

    @Override
    public List<clsCliente> lista() {
        List<clsCliente> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT c.*, td.nombre as nombreDocumento " +
                     "FROM tbcliente c " +
                     "INNER JOIN tbtipodocumento td ON c.idTipoDocumento = td.idtipodocumento";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                clsCliente cli = new clsCliente();
                cli.setIdcliente(rs.getInt("idcliente"));
                cli.setNombre(rs.getString("Nombre"));
                cli.setApellido(rs.getString("Apellido"));
                cli.setIdTipoDocumento(rs.getInt("idTipoDocumento"));
                cli.setNumeroDocumento(rs.getString("NumeroDocumento"));
                cli.setTelefono(rs.getString("Telefono"));
                cli.setDireccion(rs.getString("Direccion"));
                cli.setEmail(rs.getString("Email"));
                cli.setClave(rs.getString("Clave"));
                cli.setEstado(rs.getInt("Estado"));
                cli.setNombreDocumento(rs.getString("nombreDocumento"));
                lista.add(cli);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar clientes: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }

    @Override
    public clsCliente list(int idCli) {
        clsCliente cli = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT c.*, td.nombre as nombreDocumento " +
                     "FROM tbcliente c " +
                     "INNER JOIN tbtipodocumento td ON c.idTipoDocumento = td.idtipodocumento " +
                     "WHERE c.idcliente = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idCli);
            rs = ps.executeQuery();
            if (rs.next()) {
                cli = new clsCliente();
                cli.setIdcliente(rs.getInt("idcliente"));
                cli.setNombre(rs.getString("Nombre"));
                cli.setApellido(rs.getString("Apellido"));
                cli.setIdTipoDocumento(rs.getInt("idTipoDocumento"));
                cli.setNumeroDocumento(rs.getString("NumeroDocumento"));
                cli.setTelefono(rs.getString("Telefono"));
                cli.setDireccion(rs.getString("Direccion"));
                cli.setEmail(rs.getString("Email"));
                cli.setClave(rs.getString("Clave"));
                cli.setEstado(rs.getInt("Estado"));
                cli.setNombreDocumento(rs.getString("nombreDocumento"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener cliente: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return cli;
    }

    @Override
    public boolean add(clsCliente cli) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "INSERT INTO tbcliente (Nombre, Apellido, idTipoDocumento, NumeroDocumento, " +
                     "Telefono, Direccion, Email, Clave, Estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cli.getNombre());
            ps.setString(2, cli.getApellido());
            ps.setInt(3, cli.getIdTipoDocumento());
            ps.setString(4, cli.getNumeroDocumento());
            ps.setString(5, cli.getTelefono());
            ps.setString(6, cli.getDireccion());
            ps.setString(7, cli.getEmail());
            ps.setString(8, cli.getClave());
            ps.setInt(9, cli.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar cliente: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean edit(clsCliente cli) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "UPDATE tbcliente SET Nombre=?, Apellido=?, idTipoDocumento=?, NumeroDocumento=?, " +
                     "Telefono=?, Direccion=?, Email=?, Clave=?, Estado=? WHERE idcliente=?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cli.getNombre());
            ps.setString(2, cli.getApellido());
            ps.setInt(3, cli.getIdTipoDocumento());
            ps.setString(4, cli.getNumeroDocumento());
            ps.setString(5, cli.getTelefono());
            ps.setString(6, cli.getDireccion());
            ps.setString(7, cli.getEmail());
            ps.setString(8, cli.getClave());
            ps.setInt(9, cli.getEstado());
            ps.setInt(10, cli.getIdcliente());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al editar cliente: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean eliminar(int idCli) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "DELETE FROM tbcliente WHERE idcliente = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idCli);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al eliminar cliente: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }
}