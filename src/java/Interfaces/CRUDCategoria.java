package Interfaces;

import Modelo.clsCategoria;
import java.util.List;

public interface CRUDCategoria {
    List<clsCategoria> lista();
    clsCategoria list(int idCategoria);
    boolean add(clsCategoria categoria);
    boolean edit(clsCategoria categoria);
    boolean eliminar(int idCategoria);
}