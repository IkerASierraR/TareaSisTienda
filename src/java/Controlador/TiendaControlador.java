package Controlador;

import Modelo.clsCarritoItem;
import Modelo.clsCategoria;
import Modelo.clsProducto;
import ModeloDAO.CategoriaDAO;
import ModeloDAO.ProductoDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "TiendaControlador", urlPatterns = {"/TiendaControlador"})
public class TiendaControlador extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();
    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!validarSesionCliente(session)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null || accion.equals("tienda")) {
            cargarTienda(request, response, session);
        } else if (accion.equals("verCarrito")) {
            mostrarCarrito(request, response, session);
        } else if (accion.equals("checkout")) {
            mostrarCheckout(request, response, session);
        } else {
            cargarTienda(request, response, session);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!validarSesionCliente(session)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendRedirect("TiendaControlador");
            return;
        }

        switch (accion) {
            case "agregarCarrito":
                agregarAlCarrito(request, response, session);
                break;
            case "actualizarCantidad":
                actualizarCantidad(request, response, session);
                break;
            case "eliminarItem":
                eliminarItem(request, response, session);
                break;
            case "finalizarCompra":
                finalizarCompra(request, response, session);
                break;
            default:
                response.sendRedirect("TiendaControlador");
                break;
        }
    }

    private boolean validarSesionCliente(HttpSession session) {
        if (session == null) {
            return false;
        }
        Object tipo = session.getAttribute("tipo");
        return tipo != null && "cliente".equals(tipo.toString());
    }

    private void cargarTienda(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String categoriaParam = request.getParameter("categoria");
        Integer idCategoria = null;
        if (categoriaParam != null && !categoriaParam.isEmpty()) {
            try {
                idCategoria = Integer.parseInt(categoriaParam);
            } catch (NumberFormatException ex) {
                idCategoria = null;
            }
        }

        List<clsProducto> productos = productoDAO.listarActivosPorCategoria(idCategoria);
        List<clsCategoria> categorias = categoriaDAO.listarActivas();
        List<clsCarritoItem> carrito = obtenerCarrito(session);

        request.setAttribute("productos", productos);
        request.setAttribute("categorias", categorias);
        request.setAttribute("categoriaSeleccionada", idCategoria);
        request.setAttribute("cantidadCarrito", obtenerCantidadCarrito(carrito));

        String mensaje = obtenerMensajeTemporal(session, "mensajeTienda");
        if (mensaje != null) {
            request.setAttribute("mensajeTienda", mensaje);
        }

        request.getRequestDispatcher("/VistaTienda/tienda.jsp").forward(request, response);
    }

    private void mostrarCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        List<clsCarritoItem> carrito = obtenerCarrito(session);
        double total = carrito.stream()
                .mapToDouble(clsCarritoItem::getSubtotal)
                .sum();

        request.setAttribute("carrito", carrito);
        request.setAttribute("totalCarrito", total);
        request.setAttribute("cantidadCarrito", obtenerCantidadCarrito(carrito));

        String mensaje = obtenerMensajeTemporal(session, "mensajeCarrito");
        if (mensaje != null) {
            request.setAttribute("mensajeCarrito", mensaje);
        }

        request.getRequestDispatcher("/VistaTienda/carrito.jsp").forward(request, response);
    }

    private void mostrarCheckout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        @SuppressWarnings("unchecked")
        Map<String, Object> resumen = (Map<String, Object>) session.getAttribute("resumenCompra");
        if (resumen != null) {
            request.setAttribute("resumenCompra", resumen);
            session.removeAttribute("resumenCompra");
        }

        request.getRequestDispatcher("/VistaTienda/checkout.jsp").forward(request, response);
    }

    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String idProductoParam = request.getParameter("idProducto");
        String cantidadParam = request.getParameter("cantidad");

        if (idProductoParam == null || cantidadParam == null) {
            response.sendRedirect("TiendaControlador");
            return;
        }

        int idProducto;
        int cantidad;
        try {
            idProducto = Integer.parseInt(idProductoParam);
            cantidad = Integer.parseInt(cantidadParam);
        } catch (NumberFormatException ex) {
            response.sendRedirect("TiendaControlador");
            return;
        }

        if (cantidad <= 0) {
            establecerMensajeTemporal(session, "mensajeTienda", "La cantidad debe ser mayor a cero.");
            response.sendRedirect("TiendaControlador");
            return;
        }

        clsProducto producto = productoDAO.list(idProducto);
        if (producto == null || producto.getEstado() != 1) {
            establecerMensajeTemporal(session, "mensajeTienda", "El producto seleccionado no está disponible.");
            response.sendRedirect("TiendaControlador");
            return;
        }

        if (producto.getCantidad() < cantidad) {
            establecerMensajeTemporal(session, "mensajeTienda", "No hay stock suficiente para el producto seleccionado.");
            response.sendRedirect("TiendaControlador");
            return;
        }

        List<clsCarritoItem> carrito = obtenerCarrito(session);
        boolean existente = false;
        for (clsCarritoItem item : carrito) {
            if (item.getIdProducto() == idProducto) {
                int nuevaCantidad = item.getCantidad() + cantidad;
                if (nuevaCantidad > producto.getCantidad()) {
                    establecerMensajeTemporal(session, "mensajeTienda", "No hay stock suficiente para agregar más unidades.");
                    response.sendRedirect("TiendaControlador");
                    return;
                }
                item.setCantidad(nuevaCantidad);
                existente = true;
                break;
            }
        }

        if (!existente) {
            clsCarritoItem nuevo = new clsCarritoItem(producto.getIdProducto(), producto.getNombre(), producto.getPrecioUnitario(), cantidad);
            carrito.add(nuevo);
        }

        session.setAttribute("carrito", carrito);
        establecerMensajeTemporal(session, "mensajeTienda", "Producto agregado al carrito correctamente.");
        response.sendRedirect("TiendaControlador");
    }

    private void actualizarCantidad(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String idProductoParam = request.getParameter("idProducto");
        String cantidadParam = request.getParameter("cantidad");

        if (idProductoParam == null || cantidadParam == null) {
            response.sendRedirect("TiendaControlador?accion=verCarrito");
            return;
        }

        int idProducto;
        int cantidad;
        try {
            idProducto = Integer.parseInt(idProductoParam);
            cantidad = Integer.parseInt(cantidadParam);
        } catch (NumberFormatException ex) {
            response.sendRedirect("TiendaControlador?accion=verCarrito");
            return;
        }

        if (cantidad <= 0) {
            establecerMensajeTemporal(session, "mensajeCarrito", "La cantidad debe ser mayor a cero.");
            response.sendRedirect("TiendaControlador?accion=verCarrito");
            return;
        }

        clsProducto producto = productoDAO.list(idProducto);
        if (producto == null || producto.getEstado() != 1) {
            establecerMensajeTemporal(session, "mensajeCarrito", "El producto ya no está disponible.");
            eliminarItemDelCarrito(session, idProducto);
            response.sendRedirect("TiendaControlador?accion=verCarrito");
            return;
        }

        if (producto.getCantidad() < cantidad) {
            establecerMensajeTemporal(session, "mensajeCarrito", "Solo hay " + producto.getCantidad() + " unidades disponibles.");
            response.sendRedirect("TiendaControlador?accion=verCarrito");
            return;
        }

        List<clsCarritoItem> carrito = obtenerCarrito(session);
        for (clsCarritoItem item : carrito) {
            if (item.getIdProducto() == idProducto) {
                item.setCantidad(cantidad);
                break;
            }
        }

        session.setAttribute("carrito", carrito);
        establecerMensajeTemporal(session, "mensajeCarrito", "Cantidad actualizada correctamente.");
        response.sendRedirect("TiendaControlador?accion=verCarrito");
    }

    private void eliminarItem(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String idProductoParam = request.getParameter("idProducto");
        if (idProductoParam == null) {
            response.sendRedirect("TiendaControlador?accion=verCarrito");
            return;
        }

        try {
            int idProducto = Integer.parseInt(idProductoParam);
            eliminarItemDelCarrito(session, idProducto);
            establecerMensajeTemporal(session, "mensajeCarrito", "Producto eliminado del carrito.");
        } catch (NumberFormatException ex) {
            establecerMensajeTemporal(session, "mensajeCarrito", "No fue posible eliminar el producto.");
        }

        response.sendRedirect("TiendaControlador?accion=verCarrito");
    }

    private void finalizarCompra(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        List<clsCarritoItem> carrito = obtenerCarrito(session);
        if (carrito.isEmpty()) {
            establecerMensajeTemporal(session, "mensajeCarrito", "No tienes productos en el carrito.");
            response.sendRedirect("TiendaControlador?accion=verCarrito");
            return;
        }

        // Verificar stock antes de descontar
        for (clsCarritoItem item : carrito) {
            clsProducto producto = productoDAO.list(item.getIdProducto());
            if (producto == null || producto.getEstado() != 1) {
                establecerMensajeTemporal(session, "mensajeCarrito", "El producto " + item.getNombreProducto()
                        + " ya no está disponible.");
                response.sendRedirect("TiendaControlador?accion=verCarrito");
                return;
            }
            if (producto.getCantidad() < item.getCantidad()) {
                establecerMensajeTemporal(session, "mensajeCarrito", "Stock insuficiente para " + producto.getNombre()
                        + ". Disponible: " + producto.getCantidad() + ".");
                response.sendRedirect("TiendaControlador?accion=verCarrito");
                return;
            }
        }

        double total = 0;
        for (clsCarritoItem item : carrito) {
            boolean actualizado = productoDAO.restarStock(item.getIdProducto(), item.getCantidad());
            if (!actualizado) {
                establecerMensajeTemporal(session, "mensajeCarrito", "No se pudo completar la compra. Inténtalo nuevamente.");
                response.sendRedirect("TiendaControlador?accion=verCarrito");
                return;
            }
            total += item.getSubtotal();
        }

        Map<String, Object> resumen = new HashMap<>();
        resumen.put("items", new ArrayList<>(carrito));
        resumen.put("total", total);
        session.setAttribute("resumenCompra", resumen);

        carrito.clear();
        session.setAttribute("carrito", carrito);

        response.sendRedirect("TiendaControlador?accion=checkout");
    }

    @SuppressWarnings("unchecked")
    private List<clsCarritoItem> obtenerCarrito(HttpSession session) {
        List<clsCarritoItem> carrito = (List<clsCarritoItem>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        }
        return carrito;
    }

    private int obtenerCantidadCarrito(List<clsCarritoItem> carrito) {
        return carrito.stream()
                .mapToInt(clsCarritoItem::getCantidad)
                .sum();
    }

    private void eliminarItemDelCarrito(HttpSession session, int idProducto) {
        List<clsCarritoItem> carrito = obtenerCarrito(session);
        carrito.removeIf(item -> item.getIdProducto() == idProducto);
        session.setAttribute("carrito", carrito);
    }

    private void establecerMensajeTemporal(HttpSession session, String clave, String mensaje) {
        session.setAttribute(clave, mensaje);
    }

    private String obtenerMensajeTemporal(HttpSession session, String clave) {
        String mensaje = (String) session.getAttribute(clave);
        if (mensaje != null) {
            session.removeAttribute(clave);
        }
        return mensaje;
    }
}
