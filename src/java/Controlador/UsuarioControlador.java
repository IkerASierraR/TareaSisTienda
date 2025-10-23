package Controlador;

import Modelo.clsUsuario;
import ModeloDAO.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UsuarioControlador")
public class UsuarioControlador extends HttpServlet {
    
    UsuarioDAO dao = new UsuarioDAO();
    clsUsuario user = new clsUsuario();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion != null && accion.equals("login")) {
            String usuario = request.getParameter("usuario");
            String clave = request.getParameter("clave");
            
            user = dao.validar(usuario, clave);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", user.getNombre());
                session.setAttribute("tipo", user.gettipo());
                session.setAttribute("idUsuario", user.getidUsuario());
                
                // Redirección según tipo de usuario
                if (user.gettipo().equals("empleado")) {
                    response.sendRedirect("VistaAdministrador/administrador.jsp");
                } else if (user.gettipo().equals("cliente")) {
                    response.sendRedirect("TiendaControlador");
                }
            } else {
                // Login fallido
                response.sendRedirect("index.jsp?error=true");
            }
        } else if (accion != null && accion.equals("logout")) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("index.jsp");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}