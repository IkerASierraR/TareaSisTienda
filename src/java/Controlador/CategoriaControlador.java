package Controlador;

import Modelo.clsCategoria;
import ModeloDAO.CategoriaDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoriaControlador", urlPatterns = {"/CategoriaControlador"})
public class CategoriaControlador extends HttpServlet {

    CategoriaDAO dao = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            List<clsCategoria> lista = dao.lista();
            request.setAttribute("listaCategorias", lista);
            request.getRequestDispatcher("/VistaAdministrador/VistaCategoria/addCategoria.jsp").forward(request, response);
            return;
        }

        switch (accion) {
            case "listar":
                List<clsCategoria> lista = dao.lista();
                request.setAttribute("listaCategorias", lista);
                request.getRequestDispatcher("/VistaAdministrador/VistaCategoria/addCategoria.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("idcategoria"));
                dao.eliminar(idEliminar);
                response.sendRedirect("CategoriaControlador?accion=listar");
                break;

            default:
                List<clsCategoria> listaDefault = dao.lista();
                request.setAttribute("listaCategorias", listaDefault);
                request.getRequestDispatcher("/VistaAdministrador/VistaCategoria/addCategoria.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("CategoriaControlador?accion=listar");
            return;
        }

        switch (accion) {
            case "Agregar":
                String nombre = request.getParameter("txtCategoria");
                int estado = Integer.parseInt(request.getParameter("txtEstado"));
                clsCategoria nuevaCategoria = new clsCategoria();
                nuevaCategoria.setCategoria(nombre);
                nuevaCategoria.setEstado(estado);
                dao.add(nuevaCategoria);
                response.sendRedirect("CategoriaControlador?accion=listar");
                break;

            case "Actualizar":
                int idcategoria = Integer.parseInt(request.getParameter("txtIdcategoria"));
                String nombreEditado = request.getParameter("txtCategoriaEdit");
                int estadoEditado = Integer.parseInt(request.getParameter("txtEstadoEdit"));
                clsCategoria categoriaEditada = new clsCategoria(idcategoria, nombreEditado, estadoEditado);
                dao.edit(categoriaEditada);
                response.sendRedirect("CategoriaControlador?accion=listar");
                break;

            default:
                response.sendRedirect("CategoriaControlador?accion=listar");
                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Controlador de categorías";
    }
}