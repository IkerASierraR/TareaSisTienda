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

@WebServlet(name = "ClienteControlador", urlPatterns = {"/ClienteControlador"})
public class ClienteControlador extends HttpServlet {

    ClienteDAO dao = new ClienteDAO();
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
                int idEliminar = Integer.parseInt(request.getParameter("idcliente"));
                dao.eliminar(idEliminar);
                response.sendRedirect("ClienteControlador?accion=listar");
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
            response.sendRedirect("ClienteControlador?accion=listar");
            return;
        }

        switch (accion) {
            case "Agregar":
                agregarCliente(request, response);
                break;

            case "Actualizar":
                actualizarCliente(request, response);
                break;

            default:
                response.sendRedirect("ClienteControlador?accion=listar");
                break;
        }
    }

    private void cargarDatosLista(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<clsCliente> listaClientes = dao.lista();
        List<clsTipoDocumento> listaTiposDoc = tipoDocDAO.lista();
        
        request.setAttribute("listaClientes", listaClientes);
        request.setAttribute("listaTiposDoc", listaTiposDoc);
        request.getRequestDispatcher("/VistaAdministrador/VistaCliente/addCliente.jsp").forward(request, response);
    }

    private void agregarCliente(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        clsCliente nuevoCli = new clsCliente();
        nuevoCli.setNombre(request.getParameter("txtNombre"));
        nuevoCli.setApellido(request.getParameter("txtApellido"));
        nuevoCli.setIdTipoDocumento(Integer.parseInt(request.getParameter("txtTipoDocumento")));
        nuevoCli.setNumeroDocumento(request.getParameter("txtNumeroDocumento"));
        nuevoCli.setTelefono(request.getParameter("txtTelefono"));
        nuevoCli.setDireccion(request.getParameter("txtDireccion"));
        nuevoCli.setEmail(request.getParameter("txtEmail"));
        nuevoCli.setClave(request.getParameter("txtClave"));
        nuevoCli.setEstado(Integer.parseInt(request.getParameter("txtEstado")));
        
        dao.add(nuevoCli);
        response.sendRedirect("ClienteControlador?accion=listar");
    }

    private void actualizarCliente(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        clsCliente cliEditado = new clsCliente();
        cliEditado.setIdcliente(Integer.parseInt(request.getParameter("txtIdcliente")));
        cliEditado.setNombre(request.getParameter("txtNombreEdit"));
        cliEditado.setApellido(request.getParameter("txtApellidoEdit"));
        cliEditado.setIdTipoDocumento(Integer.parseInt(request.getParameter("txtTipoDocumentoEdit")));
        cliEditado.setNumeroDocumento(request.getParameter("txtNumeroDocumentoEdit"));
        cliEditado.setTelefono(request.getParameter("txtTelefonoEdit"));
        cliEditado.setDireccion(request.getParameter("txtDireccionEdit"));
        cliEditado.setEmail(request.getParameter("txtEmailEdit"));
        cliEditado.setClave(request.getParameter("txtClaveEdit"));
        cliEditado.setEstado(Integer.parseInt(request.getParameter("txtEstadoEdit")));
        
        dao.edit(cliEditado);
        response.sendRedirect("ClienteControlador?accion=listar");
    }

    @Override
    public String getServletInfo() {
        return "Controlador de clientes";
    }
}