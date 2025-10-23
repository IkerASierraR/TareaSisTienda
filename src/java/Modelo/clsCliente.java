package Modelo;

public class clsCliente {
    private int idcliente;
    private String nombre;
    private String apellido;
    private int idTipoDocumento;
    private String numeroDocumento;
    private String telefono;
    private String direccion;
    private String email;
    private String clave;
    private int estado;
    
    private String nombreDocumento;

    public clsCliente() {
    }

    public clsCliente(int idcliente, String nombre, String apellido, int idTipoDocumento, 
                     String numeroDocumento, String telefono, String direccion, 
                     String email, String clave, int estado) {
        this.idcliente = idcliente;
        this.nombre = nombre;
        this.apellido = apellido;
        this.idTipoDocumento = idTipoDocumento;
        this.numeroDocumento = numeroDocumento;
        this.telefono = telefono;
        this.direccion = direccion;
        this.email = email;
        this.clave = clave;
        this.estado = estado;
    }

    public int getIdcliente() { 
        return idcliente; 
    }
    
    public void setIdcliente(int idcliente) { 
        this.idcliente = idcliente; 
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
    
    public String getDireccion() { 
        return direccion; 
    }
    
    public void setDireccion(String direccion) { 
        this.direccion = direccion; 
    }
    
    public String getEmail() { 
        return email; 
    }
    
    public void setEmail(String email) { 
        this.email = email; 
    }
    
    public String getClave() { 
        return clave; 
    }
    
    public void setClave(String clave) { 
        this.clave = clave; 
    }
    
    public int getEstado() { 
        return estado; 
    }
    
    public void setEstado(int estado) { 
        this.estado = estado; 
    }
    
    public String getNombreDocumento() { 
        return nombreDocumento; 
    }
    
    public void setNombreDocumento(String nombreDocumento) { 
        this.nombreDocumento = nombreDocumento; 
    }
}