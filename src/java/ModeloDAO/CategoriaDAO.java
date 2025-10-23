package ModeloDAO;

import Config.clsConexion;
import Interfaces.CRUDCategoria;
import Modelo.clsCategoria;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO implements CRUDCategoria {

    @Override
    public List<clsCategoria> lista() {
        List<clsCategoria> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM tbcategoria";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                clsCategoria cat = new clsCategoria();
                cat.setIdcategoria(rs.getInt("idcategoria"));
                cat.setCategoria(rs.getString("Categoria"));
                cat.setEstado(rs.getInt("Estado"));
                lista.add(cat);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar categorías: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }

    @Override
    public clsCategoria list(int idcat) {
        clsCategoria cat = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM tbcategoria WHERE idcategoria = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idcat);
            rs = ps.executeQuery();
            if (rs.next()) {
                cat = new clsCategoria();
                cat.setIdcategoria(rs.getInt("idcategoria"));
                cat.setCategoria(rs.getString("Categoria"));
                cat.setEstado(rs.getInt("Estado"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener categoría: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return cat;
    }

    @Override
    public boolean add(clsCategoria cat) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "INSERT INTO tbcategoria (Categoria, Estado) VALUES (?, ?)";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cat.getCategoria());
            ps.setInt(2, cat.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar categoría: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean edit(clsCategoria cat) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "UPDATE tbcategoria SET Categoria = ?, Estado = ? WHERE idcategoria = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cat.getCategoria());
            ps.setInt(2, cat.getEstado());
            ps.setInt(3, cat.getIdcategoria());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al editar categoría: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean eliminar(int idcat) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "DELETE FROM tbcategoria WHERE idcategoria = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idcat);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al eliminar categoría: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }
    
    public List<clsCategoria> listarActivas() {
        List<clsCategoria> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM tbcategoria WHERE Estado = 1";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                clsCategoria cat = new clsCategoria();
                cat.setIdcategoria(rs.getInt("idcategoria"));
                cat.setCategoria(rs.getString("Categoria"));
                cat.setEstado(rs.getInt("Estado"));
                lista.add(cat);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar categorías activas: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }
}