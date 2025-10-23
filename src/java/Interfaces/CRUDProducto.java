package Interfaces;

import Modelo.clsProducto;
import java.util.List;

public interface CRUDProducto {
    List<clsProducto> lista();
    clsProducto list(int idProducto);
    boolean add(clsProducto producto);
    boolean edit(clsProducto producto);
    boolean eliminar(int idProducto);
}
