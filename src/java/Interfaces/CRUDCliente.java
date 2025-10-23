package Interfaces;

import Modelo.clsCliente;
import java.util.List;

public interface CRUDCliente {
    
    List<clsCliente> lista();
    clsCliente list(int idcliente);
    boolean add(clsCliente cliente);
    boolean edit(clsCliente cliente);
    boolean eliminar(int idcliente);
    
}
