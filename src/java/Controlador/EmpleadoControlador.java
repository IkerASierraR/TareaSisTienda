package Controlador;

import Modelo.clsEmpleado;
import ModeloDAO.EmpleadoDAO;
import ModeloDAO.CargoDAO;
import ModeloDAO.TipoDocumentoDAO;
import Modelo.clsCargo;
import Modelo.clsTipoDocumento;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EmpleadoControlador", urlPatterns = {"/EmpleadoControlador"})
public class EmpleadoControlador extends HttpServlet {

    EmpleadoDAO dao = new EmpleadoDAO();
    CargoDAO cargoDAO = new CargoDAO();
    TipoDocumentoDAO tipoDocDAO = new TipoDocumentoDAO();

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
                int idEliminar = Integer.parseInt(request.getParameter("idEmpleado"));
                boolean eliminado = dao.eliminar(idEliminar);
                if (eliminado) {
                    request.getSession().setAttribute("mensaje", "Empleado eliminado correctamente");
                } else {
                    request.getSession().setAttribute("error", "Error al eliminar empleado");
                }
                response.sendRedirect("EmpleadoControlador?accion=listar");
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
            response.sendRedirect("EmpleadoControlador?accion=listar");
            return;
        }

        switch (accion) {
            case "Agregar":
                agregarEmpleado(request, response);
                break;

            case "Actualizar":
                actualizarEmpleado(request, response);
                break;

            default:
                response.sendRedirect("EmpleadoControlador?accion=listar");
                break;
        }
    }

    private void cargarDatosLista(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<clsEmpleado> listaEmpleados = dao.lista();
        List<clsCargo> listaCargos = cargoDAO.lista();
        List<clsTipoDocumento> listaTiposDoc = tipoDocDAO.lista();
        
        request.setAttribute("listaEmpleados", listaEmpleados);
        request.setAttribute("listaCargos", listaCargos);
        request.setAttribute("listaTiposDoc", listaTiposDoc);
        request.getRequestDispatcher("/VistaAdministrador/VistaEmpleado/addEmpleado.jsp").forward(request, response);
    }

    private void agregarEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            clsEmpleado nuevoEmp = new clsEmpleado();
            nuevoEmp.setNombre(request.getParameter("txtNombre"));
            nuevoEmp.setApellido(request.getParameter("txtApellido"));
            nuevoEmp.setIdcargo(Integer.parseInt(request.getParameter("txtCargo")));
            nuevoEmp.setUsuario(request.getParameter("txtUsuario"));
            nuevoEmp.setClave(request.getParameter("txtClave"));
            nuevoEmp.setIdTipoDocumento(Integer.parseInt(request.getParameter("txtTipoDocumento")));
            nuevoEmp.setNumeroDocumento(request.getParameter("txtNumeroDocumento"));
            nuevoEmp.setTelefono(request.getParameter("txtTelefono"));
            nuevoEmp.setEstado(Integer.parseInt(request.getParameter("txtEstado")));
            
            boolean agregado = dao.add(nuevoEmp);
            if (agregado) {
                request.getSession().setAttribute("mensaje", "Empleado agregado correctamente");
            } else {
                request.getSession().setAttribute("error", "Error al agregar empleado");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error en los datos: " + e.getMessage());
        }
        response.sendRedirect("EmpleadoControlador?accion=listar");
    }

    private void actualizarEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            clsEmpleado empEditado = new clsEmpleado();
            empEditado.setIdEmpleado(Integer.parseInt(request.getParameter("txtIdEmpleado")));
            empEditado.setNombre(request.getParameter("txtNombreEdit"));
            empEditado.setApellido(request.getParameter("txtApellidoEdit"));
            empEditado.setIdcargo(Integer.parseInt(request.getParameter("txtCargoEdit")));
            empEditado.setUsuario(request.getParameter("txtUsuarioEdit"));
            empEditado.setClave(request.getParameter("txtClaveEdit"));
            empEditado.setIdTipoDocumento(Integer.parseInt(request.getParameter("txtTipoDocumentoEdit")));
            empEditado.setNumeroDocumento(request.getParameter("txtNumeroDocumentoEdit"));
            empEditado.setTelefono(request.getParameter("txtTelefonoEdit"));
            empEditado.setEstado(Integer.parseInt(request.getParameter("txtEstadoEdit")));
            
            boolean actualizado = dao.edit(empEditado);
            if (actualizado) {
                request.getSession().setAttribute("mensaje", "Empleado actualizado correctamente");
            } else {
                request.getSession().setAttribute("error", "Error al actualizar empleado");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error en los datos: " + e.getMessage());
        }
        response.sendRedirect("EmpleadoControlador?accion=listar");
    }

    @Override
    public String getServletInfo() {
        return "Controlador de empleados";
    }
}