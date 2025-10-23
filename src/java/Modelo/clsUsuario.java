package Modelo;

public class clsUsuario {
    private int idUsuario;
    private String Nombre;
    private String Clave;
    private String tipo;
    
    public clsUsuario() {}
    
    public clsUsuario(int idUsuario, String Nombre, String Clave, String tipo) {
        this.idUsuario = idUsuario;
        this.Nombre = Nombre;
        this.Clave = Clave;
        this.tipo = tipo;
    }
    
    // Getters y Setters (manteniendo mayúsculas como en tus otros modelos)
    public int getidUsuario() { return idUsuario; }
    public void setidUsuario(int idUsuario) { this.idUsuario = idUsuario; }
    
    public String getNombre() { return Nombre; }
    public void setNombre(String Nombre) { this.Nombre = Nombre; }
    
    public String getClave() { return Clave; }
    public void setClave(String Clave) { this.Clave = Clave; }
    
    public String gettipo() { return tipo; }
    public void settipo(String tipo) { this.tipo = tipo; }
}