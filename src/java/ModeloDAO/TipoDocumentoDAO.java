package ModeloDAO;

import Config.clsConexion;
import Interfaces.CRUDTipoDocumento;
import Modelo.clsTipoDocumento;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TipoDocumentoDAO implements CRUDTipoDocumento {

    @Override
    public List<clsTipoDocumento> lista() {
        List<clsTipoDocumento> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM tbtipodocumento ORDER BY nombre";
        try {
            con = clsConexion.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                clsTipoDocumento tipoDoc = new clsTipoDocumento();
                tipoDoc.setIdtipodocumento(rs.getInt("idtipodocumento"));
                tipoDoc.setNombre(rs.getString("nombre"));
                lista.add(tipoDoc);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar tipos de documento: " + e.getMessage());
        } finally {
            clsConexion.close(rs);
            clsConexion.close(ps);
        }
        return lista;
    }
}