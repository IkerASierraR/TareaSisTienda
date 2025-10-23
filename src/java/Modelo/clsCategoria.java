package Modelo;

public class clsCategoria {
    private int idcategoria;
    private String categoria;
    private int estado;

    public clsCategoria() {
    }

    public clsCategoria(int idcategoria, String categoria, int estado) {
        this.idcategoria = idcategoria;
        this.categoria = categoria;
        this.estado = estado;
    }

    public int getIdcategoria() {
        return idcategoria;
    }

    public void setIdcategoria(int idcategoria) {
        this.idcategoria = idcategoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
}