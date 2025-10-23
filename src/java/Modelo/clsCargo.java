package Modelo;

public class clsCargo {
    private int idcargo;
    private String nombre;
    private int estado;

    public clsCargo() {
    }

    public clsCargo(int idcargo, String nombre, int estado) {
        this.idcargo = idcargo;
        this.nombre = nombre;
        this.estado = estado;
    }

    public int getIdcargo() {
        return idcargo;
    }

    public void setIdcargo(int idcargo) {
        this.idcargo = idcargo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
    
}