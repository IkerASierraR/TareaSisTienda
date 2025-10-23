package Controlador;

import Modelo.clsCliente;
import ModeloDAO.ClienteDAO;
import ModeloDAO.TipoDocumentoDAO;
import Modelo.clsTipoDocumento;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroControlador", urlPatterns = {"/RegistroControlador"})
public class RegistroControlador extends HttpServlet {

    ClienteDAO dao = new ClienteDAO();
    TipoDocumentoDAO tipoDocDAO = new TipoDocumentoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cargar tipos de documento para el formulario de registro
        cargarTiposDocumento(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if (accion != null && accion.equals("registrar")) {
            registrarCliente(request, response);
        } else {
            // Si no es registrar, cargar el formulario con tipos de documento
            cargarTiposDocumento(request, response);
        }
    }

    private void cargarTiposDocumento(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<clsTipoDocumento> listaTiposDoc = tipoDocDAO.lista();
        request.setAttribute("listaTiposDoc", listaTiposDoc);
        request.getRequestDispatcher("/VistaLogin/registro.jsp").forward(request, response);
    }

    private void registrarCliente(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        try {
            // Crear nuevo cliente
            clsCliente nuevoCliente = new clsCliente();
            nuevoCliente.setNombre(request.getParameter("txtNombre"));
            nuevoCliente.setApellido(request.getParameter("txtApellido"));
            nuevoCliente.setIdTipoDocumento(Integer.parseInt(request.getParameter("txtTipoDocumento")));
            nuevoCliente.setNumeroDocumento(request.getParameter("txtNumeroDocumento"));
            nuevoCliente.setTelefono(request.getParameter("txtTelefono"));
            nuevoCliente.setDireccion(request.getParameter("txtDireccion"));
            nuevoCliente.setEmail(request.getParameter("txtEmail"));
            nuevoCliente.setClave(request.getParameter("txtClave"));
            nuevoCliente.setEstado(1); // Activo por defecto

            // Validaciones básicas
            if (nuevoCliente.getNombre() == null || nuevoCliente.getNombre().trim().isEmpty() ||
                nuevoCliente.getApellido() == null || nuevoCliente.getApellido().trim().isEmpty() ||
                nuevoCliente.getEmail() == null || nuevoCliente.getEmail().trim().isEmpty() ||
                nuevoCliente.getClave() == null || nuevoCliente.getClave().trim().isEmpty()) {
                
                // Recargar con error y tipos de documento
                List<clsTipoDocumento> listaTiposDoc = tipoDocDAO.lista();
                request.setAttribute("listaTiposDoc", listaTiposDoc);
                request.setAttribute("error", "campos_vacios");
                request.getRequestDispatcher("/VistaLogin/registro.jsp").forward(request, response);
                return;
            }

            // Intentar registrar
            boolean registrado = dao.add(nuevoCliente);
            
            if (registrado) {
                // Éxito - redirigir al login
                response.sendRedirect("../VistaLogin/login.jsp?registro=exitoso");
            } else {
                // Error en el registro - recargar con tipos de documento
                List<clsTipoDocumento> listaTiposDoc = tipoDocDAO.lista();
                request.setAttribute("listaTiposDoc", listaTiposDoc);
                request.setAttribute("error", "registro_fallido");
                request.getRequestDispatcher("/VistaLogin/registro.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Error - recargar con tipos de documento
            List<clsTipoDocumento> listaTiposDoc = tipoDocDAO.lista();
            request.setAttribute("listaTiposDoc", listaTiposDoc);
            request.setAttribute("error", "exception");
            request.getRequestDispatcher("/VistaLogin/registro.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Controlador para registro de clientes";
    }
}