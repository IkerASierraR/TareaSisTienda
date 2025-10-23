package Interfaces;

import Modelo.clsUsuario;

public interface CRUDUsuario {
    public clsUsuario validar(String usuario, String clave);
}