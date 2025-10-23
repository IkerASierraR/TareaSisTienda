package Modelo;

public class clsEmpleado {
    private int idEmpleado;
    private String nombre;
    private String apellido;
    private int idcargo;
    private String usuario;
    private String clave;
    private int idTipoDocumento;
    private String numeroDocumento;
    private String telefono;
    private int estado;

    private String nombreCargo;
    private String nombreDocumento;

    public clsEmpleado() {
    }

    public clsEmpleado(int idEmpleado, String nombre, String apellido, int idcargo, String usuario, 
                      String clave, int idTipoDocumento, String numeroDocumento, String telefono, int estado) {
        this.idEmpleado = idEmpleado;
        this.nombre = nombre;
        this.apellido = apellido;
        this.idcargo = idcargo;
        this.usuario = usuario;
        this.clave = clave;
        this.idTipoDocumento = idTipoDocumento;
        this.numeroDocumento = numeroDocumento;
        this.telefono = telefono;
        this.estado = estado;
    }

    public int getIdEmpleado() { 
        return idEmpleado; 
    }
    
    public void setIdEmpleado(int idEmpleado) { 
        this.idEmpleado = idEmpleado; 
    }
    
    public String getNombre() { 
        return nombre; 
    }
    
    public void setNombre(String nombre) { 
        this.nombre = nombre; 
    }
    
    public String getApellido() { 
        return apellido; 
    }
    
    public void setApellido(String apellido) { 
        this.apellido = apellido; 
    }
    
    public int getIdcargo() { 
        return idcargo; 
    }
    
    public void setIdcargo(int idcargo) { 
        this.idcargo = idcargo; 
    }
    
    public String getUsuario() { 
        return usuario; 
    }
    
    public void setUsuario(String usuario) { 
        this.usuario = usuario; 
    }
    
    public String getClave() { 
        return clave; 
    }
    
    public void setClave(String clave) { 
        this.clave = clave; 
    }
    
    public int getIdTipoDocumento() { 
        return idTipoDocumento; 
    }
    
    public void setIdTipoDocumento(int idTipoDocumento) { 
        this.idTipoDocumento = idTipoDocumento; 
    }
    
    public String getNumeroDocumento() { 
        return numeroDocumento; 
    }
    
    public void setNumeroDocumento(String numeroDocumento) { 
        this.numeroDocumento = numeroDocumento; 
    }
    
    public String getTelefono() { 
        return telefono; 
    }
    
    public void setTelefono(String telefono) { 
        this.telefono = telefono; 
    }
    
    public int getEstado() { 
        return estado; 
    }
    
    public void setEstado(int estado) { 
        this.estado = estado; 
    }
    
    public String getNombreCargo() { 
        return nombreCargo; 
    }
    
    public void setNombreCargo(String nombreCargo) { 
        this.nombreCargo = nombreCargo; 
    }
    
    public String getNombreDocumento() { 
        return nombreDocumento; 
    }
    
    public void setNombreDocumento(String nombreDocumento) { 
        this.nombreDocumento = nombreDocumento; 
    }
}