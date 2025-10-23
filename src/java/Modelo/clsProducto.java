package Modelo;

public class clsProducto {
    private int idProducto;
    private int idcategoria;
    private String nombre;
    private int cantidad;
    private double precioUnitario;
    private int estado;
    
    private String nombreCategoria;

    public clsProducto() {
    }

    public clsProducto(int idProducto, int idcategoria, String nombre, int cantidad, 
                      double precioUnitario, int estado) {
        this.idProducto = idProducto;
        this.idcategoria = idcategoria;
        this.nombre = nombre;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.estado = estado;
    }

    public int getIdProducto() { 
        return idProducto; 
    }
    
    public void setIdProducto(int idProducto) { 
        this.idProducto = idProducto; 
    }
    
    public int getIdcategoria() { 
        return idcategoria; 
    }
    
    public void setIdcategoria(int idcategoria) { 
        this.idcategoria = idcategoria; 
    }
    
    public String getNombre() { 
        return nombre; 
    }
    
    public void setNombre(String nombre) { 
        this.nombre = nombre; 
    }
    
    public int getCantidad() { 
        return cantidad; 
    }
    
    public void setCantidad(int cantidad) { 
        this.cantidad = cantidad; 
    }
    
    public double getPrecioUnitario() { 
        return precioUnitario; 
    }
    
    public void setPrecioUnitario(double precioUnitario) { 
        this.precioUnitario = precioUnitario; 
    }
    
    public int getEstado() { 
        return estado; 
    }
    
    public void setEstado(int estado) { 
        this.estado = estado; 
    }
    
    public String getNombreCategoria() { 
        return nombreCategoria; 
    }
    
    public void setNombreCategoria(String nombreCategoria) { 
        this.nombreCategoria = nombreCategoria; 
    }
}