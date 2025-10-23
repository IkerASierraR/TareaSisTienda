package Controlador;

import Modelo.clsProducto;
import ModeloDAO.ProductoDAO;
import ModeloDAO.CategoriaDAO;
import Modelo.clsCategoria;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductoControlador", urlPatterns = {"/ProductoControlador"})
public class ProductoControlador extends HttpServlet {

    ProductoDAO dao = new ProductoDAO();
    CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            cargarDatosLista(request, response);
            return;
        }

        switch (accion) {
            case "listar":
                cargarDatosLista(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("idProducto"));
                dao.eliminar(idEliminar);
                response.sendRedirect("ProductoControlador?accion=listar");
                break;

            default:
                cargarDatosLista(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("ProductoControlador?accion=listar");
            return;
        }

        switch (accion) {
            case "Agregar":
                agregarProducto(request, response);
                break;

            case "Actualizar":
                actualizarProducto(request, response);
                break;

            default:
                response.sendRedirect("ProductoControlador?accion=listar");
                break;
        }
    }

    private void cargarDatosLista(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<clsProducto> listaProductos = dao.lista();
        List<clsCategoria> listaCategorias = categoriaDAO.lista();
        
        request.setAttribute("listaProductos", listaProductos);
        request.setAttribute("listaCategorias", listaCategorias);
        request.getRequestDispatcher("/VistaAdministrador/VistaProducto/addProducto.jsp").forward(request, response);
    }

    private void agregarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        clsProducto nuevoProd = new clsProducto();
        nuevoProd.setIdcategoria(Integer.parseInt(request.getParameter("txtCategoria")));
        nuevoProd.setNombre(request.getParameter("txtNombre"));
        nuevoProd.setCantidad(Integer.parseInt(request.getParameter("txtCantidad")));
        nuevoProd.setPrecioUnitario(Double.parseDouble(request.getParameter("txtPrecio")));
        nuevoProd.setEstado(Integer.parseInt(request.getParameter("txtEstado")));
        
        dao.add(nuevoProd);
        response.sendRedirect("ProductoControlador?accion=listar");
    }

    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        clsProducto prodEditado = new clsProducto();
        prodEditado.setIdProducto(Integer.parseInt(request.getParameter("txtIdProducto")));
        prodEditado.setIdcategoria(Integer.parseInt(request.getParameter("txtCategoriaEdit")));
        prodEditado.setNombre(request.getParameter("txtNombreEdit"));
        prodEditado.setCantidad(Integer.parseInt(request.getParameter("txtCantidadEdit")));
        prodEditado.setPrecioUnitario(Double.parseDouble(request.getParameter("txtPrecioEdit")));
        prodEditado.setEstado(Integer.parseInt(request.getParameter("txtEstadoEdit")));
        
        dao.edit(prodEditado);
        response.sendRedirect("ProductoControlador?accion=listar");
    }

    @Override
    public String getServletInfo() {
        return "Controlador de productos";
    }
}