package ModeloDAO;

import Config.clsConexion;
import Interfaces.CRUDProducto;
import Modelo.clsProducto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO implements CRUDProducto {

    @Override
    public List<clsProducto> lista() {
        List<clsProducto> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT p.*, c.Categoria as nombreCategoria "
                + "FROM tbproducto p "
                + "INNER JOIN tbcategoria c ON p.idcategoria = c.idcategoria";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                clsProducto prod = new clsProducto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setIdcategoria(rs.getInt("idcategoria"));
                prod.setNombre(rs.getString("Nombre"));
                prod.setCantidad(rs.getInt("Cantidad"));
                prod.setPrecioUnitario(rs.getDouble("PrecioUnitario"));
                prod.setEstado(rs.getInt("Estado"));
                prod.setNombreCategoria(rs.getString("nombreCategoria"));
                lista.add(prod);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar productos: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }

    @Override
    public clsProducto list(int idProd) {
        clsProducto prod = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT p.*, c.Categoria as nombreCategoria "
                + "FROM tbproducto p "
                + "INNER JOIN tbcategoria c ON p.idcategoria = c.idcategoria "
                + "WHERE p.idProducto = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idProd);
            rs = ps.executeQuery();
            if (rs.next()) {
                prod = new clsProducto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setIdcategoria(rs.getInt("idcategoria"));
                prod.setNombre(rs.getString("Nombre"));
                prod.setCantidad(rs.getInt("Cantidad"));
                prod.setPrecioUnitario(rs.getDouble("PrecioUnitario"));
                prod.setEstado(rs.getInt("Estado"));
                prod.setNombreCategoria(rs.getString("nombreCategoria"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener producto: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return prod;
    }

    @Override
    public boolean add(clsProducto prod) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "INSERT INTO tbproducto (idcategoria, Nombre, Cantidad, PrecioUnitario, Estado) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, prod.getIdcategoria());
            ps.setString(2, prod.getNombre());
            ps.setInt(3, prod.getCantidad());
            ps.setDouble(4, prod.getPrecioUnitario());
            ps.setInt(5, prod.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar producto: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean edit(clsProducto prod) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "UPDATE tbproducto SET idcategoria=?, Nombre=?, Cantidad=?, PrecioUnitario=?, Estado=? "
                + "WHERE idProducto=?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, prod.getIdcategoria());
            ps.setString(2, prod.getNombre());
            ps.setInt(3, prod.getCantidad());
            ps.setDouble(4, prod.getPrecioUnitario());
            ps.setInt(5, prod.getEstado());
            ps.setInt(6, prod.getIdProducto());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al editar producto: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }

    @Override
    public boolean eliminar(int idProd) {
        Connection con = null;
        PreparedStatement ps = null;
        
        String sql = "DELETE FROM tbproducto WHERE idProducto = ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idProd);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al eliminar producto: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }
    
    public List<clsProducto> listarActivosPorCategoria(Integer idCategoria) {
        List<clsProducto> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.*, c.Categoria as nombreCategoria ")
                .append("FROM tbproducto p ")
                .append("INNER JOIN tbcategoria c ON p.idcategoria = c.idcategoria ")
                .append("WHERE p.Estado = 1 AND p.Cantidad > 0");

        if (idCategoria != null) {
            sql.append(" AND p.idcategoria = ?");
        }

        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql.toString());
            if (idCategoria != null) {
                ps.setInt(1, idCategoria);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                clsProducto prod = new clsProducto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setIdcategoria(rs.getInt("idcategoria"));
                prod.setNombre(rs.getString("Nombre"));
                prod.setCantidad(rs.getInt("Cantidad"));
                prod.setPrecioUnitario(rs.getDouble("PrecioUnitario"));
                prod.setEstado(rs.getInt("Estado"));
                prod.setNombreCategoria(rs.getString("nombreCategoria"));
                lista.add(prod);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar productos activos: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }

    public boolean restarStock(int idProducto, int cantidad) {
        Connection con = null;
        PreparedStatement ps = null;

        String sql = "UPDATE tbproducto SET Cantidad = Cantidad - ? WHERE idProducto = ? AND Cantidad >= ?";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, cantidad);
            ps.setInt(2, idProducto);
            ps.setInt(3, cantidad);
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar stock: " + e.getMessage());
            return false;
        } finally {
            clsConexion.close(ps);
        }
    }
}