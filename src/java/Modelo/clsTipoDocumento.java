package Modelo;

public class clsTipoDocumento {
    
    private int idtipodocumento;
    private String nombre;

    public clsTipoDocumento() {
    }

    public clsTipoDocumento(int idtipodocumento, String nombre) {
        this.idtipodocumento = idtipodocumento;
        this.nombre = nombre;
    }

    public int getIdtipodocumento() {
        return idtipodocumento;
    }

    public void setIdtipodocumento(int idtipodocumento) {
        this.idtipodocumento = idtipodocumento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }  
}
