package Interfaces;

import Modelo.clsCargo;
import java.util.List;

public interface CRUDCargo {
    List<clsCargo> lista();
    clsCargo list(int idCargo);
    boolean add(clsCargo cargo);
    boolean edit(clsCargo cargo);
    boolean eliminar(int idCargo);
}
