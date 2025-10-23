package Interfaces;

import Modelo.clsEmpleado;
import java.util.List;

public interface CRUDEmpleado {
    List<clsEmpleado> lista();
    clsEmpleado list(int idEmpleado);
    boolean add(clsEmpleado empleado);
    boolean edit(clsEmpleado empleado);
    boolean eliminar(int idEmpleado);
}
