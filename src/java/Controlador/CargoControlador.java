package Controlador;

import Modelo.clsCargo;
import ModeloDAO.CargoDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CargoControlador", urlPatterns = {"/CargoControlador"})
public class CargoControlador extends HttpServlet {

    CargoDAO dao = new CargoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            List<clsCargo> lista = dao.lista();
            request.setAttribute("listaCargos", lista);
            request.getRequestDispatcher("/VistaAdministrador/VistaCargo/addCargo.jsp").forward(request, response);
            return;
        }

        switch (accion) {
            case "listar":
                List<clsCargo> lista = dao.lista();
                request.setAttribute("listaCargos", lista);
                request.getRequestDispatcher("/VistaAdministrador/VistaCargo/addCargo.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("idcargo"));
                dao.eliminar(idEliminar);
                response.sendRedirect("CargoControlador?accion=listar");
                break;

            default:
                // POR DEFECTO CARGAR LISTA
                List<clsCargo> listaDefault = dao.lista();
                request.setAttribute("listaCargos", listaDefault);
                request.getRequestDispatcher("/VistaAdministrador/VistaCargo/addCargo.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("CargoControlador?accion=listar");
            return;
        }

        switch (accion) {
            case "Agregar":
                String nombre = request.getParameter("txtNombre");
                int estado = Integer.parseInt(request.getParameter("txtEstado"));
                clsCargo nuevoCargo = new clsCargo();
                nuevoCargo.setNombre(nombre);
                nuevoCargo.setEstado(estado);
                dao.add(nuevoCargo);
                response.sendRedirect("CargoControlador?accion=listar");
                break;

            case "Actualizar":
                int idcargo = Integer.parseInt(request.getParameter("txtIdcargo"));
                String nombreEditado = request.getParameter("txtNombreEdit");
                int estadoEditado = Integer.parseInt(request.getParameter("txtEstadoEdit"));
                clsCargo cargoEditado = new clsCargo(idcargo, nombreEditado, estadoEditado);
                dao.edit(cargoEditado);
                response.sendRedirect("CargoControlador?accion=listar");
                break;

            default:
                response.sendRedirect("CargoControlador?accion=listar");
                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Controlador de cargos";
    }
}