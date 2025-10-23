<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.clsCarritoItem"%>
<%
    List<clsCarritoItem> carrito = (List<clsCarritoItem>) request.getAttribute("carrito");
    if (carrito == null) {
        carrito = (List<clsCarritoItem>) session.getAttribute("carrito");
    }
    if (carrito == null) {
        carrito = java.util.Collections.emptyList();
    }
    Double totalCarrito = (Double) request.getAttribute("totalCarrito");
    if (totalCarrito == null) {
        totalCarrito = carrito.stream().mapToDouble(clsCarritoItem::getSubtotal).sum();
    }
    Integer cantidadCarrito = (Integer) request.getAttribute("cantidadCarrito");
    if (cantidadCarrito == null) {
        cantidadCarrito = carrito.stream().mapToInt(clsCarritoItem::getCantidad).sum();
    }
    String mensajeCarrito = (String) request.getAttribute("mensajeCarrito");
    String nombreUsuario = (String) session.getAttribute("usuario");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
    <head>
<meta charset="UTF-8">
        <title>Mi Carrito</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                background-color: #f5f7fa;
                color: #333;
            }
            header {
                background: linear-gradient(135deg, #1a73e8, #2196f3);
                color: #fff;
                padding: 20px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }
            header h1 {
                margin: 0;
                font-size: 24px;
            }
            .actions {
                display: flex;
                gap: 15px;
                align-items: center;
            }
            .actions a {
                color: #fff;
                text-decoration: none;
                font-weight: bold;
                background: rgba(255, 255, 255, 0.2);
                padding: 8px 16px;
                border-radius: 20px;
                transition: background 0.3s ease;
            }
            .actions a:hover {
                background: rgba(0, 0, 0, 0.2);
            }
            .container {
                padding: 30px 40px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            }
            th, td {
                padding: 16px;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
            }
            th {
                background-color: #f1f8ff;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #1a237e;
            }
            td form {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            input[type="number"] {
                width: 80px;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }
            .btn {
                padding: 8px 14px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
            }
            .btn-actualizar {
                background-color: #1a73e8;
                color: #fff;
            }
            .btn-eliminar {
                background-color: #e53935;
                color: #fff;
            }
            .btn-comprar {
                background-color: #43a047;
                color: #fff;
                padding: 12px 20px;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }
            .btn-comprar:disabled {
                background-color: #9e9e9e;
                cursor: not-allowed;
            }
            .total {
                margin-top: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
            }
            .total span {
                font-size: 20px;
                font-weight: bold;
                color: #1a237e;
            }
            .mensaje {
                padding: 12px 16px;
                background-color: #fff3cd;
                border-left: 4px solid #ff9800;
                border-radius: 6px;
                color: #795548;
                margin-bottom: 20px;
            }
            .sin-productos {
                background-color: #fff;
                padding: 40px;
                border-radius: 12px;
                text-align: center;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
                font-size: 18px;
                color: #607d8b;
            }
            @media (max-width: 768px) {
                header {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                }
                table, thead, tbody, th, td, tr {
                    display: block;
                }
                thead tr {
                    display: none;
                }
                tr {
                    margin-bottom: 15px;
                    border: 1px solid #e0e0e0;
                    border-radius: 12px;
                    background-color: #fff;
                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
                }
                td {
                    border: none;
                    display: flex;
                    justify-content: space-between;
                    padding: 12px 16px;
                }
                td::before {
                    content: attr(data-label);
                    font-weight: bold;
                    color: #1a237e;
                }
                td form {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 6px;
                }
                input[type="number"] {
                    width: 100%;
                }
                .total {
                    flex-direction: column;
                    align-items: flex-start;
                }
            }
        </style>
    </head>
    <body>
<header>
            <h1>Mi Carrito</h1>
            <div class="actions">
                <span>Hola, <strong><%= nombreUsuario != null ? nombreUsuario : "Cliente" %></strong></span>
                <a href="<%= contextPath %>/TiendaControlador">Seguir comprando</a>
                <a href="<%= contextPath %>/UsuarioControlador?accion=logout">Cerrar sesión</a>
            </div>
        </header>
        <div class="container">
            <% if (mensajeCarrito != null) { %>
                <div class="mensaje"><%= mensajeCarrito %></div>
            <% } %>

            <% if (carrito.isEmpty()) { %>
                <div class="sin-productos">
                    Tu carrito está vacío. <a href="<%= contextPath %>/TiendaControlador">Explora la tienda</a> para agregar productos.
                </div>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (clsCarritoItem item : carrito) { %>
                            <tr>
                                <td data-label="Producto"><%= item.getNombreProducto() %></td>
                                <td data-label="Precio">S/ <%= String.format(java.util.Locale.US, "%.2f", item.getPrecioUnitario()) %></td>
                                <td data-label="Cantidad">
                                    <form action="<%= contextPath %>/TiendaControlador" method="post">
                                        <input type="hidden" name="accion" value="actualizarCantidad">
                                        <input type="hidden" name="idProducto" value="<%= item.getIdProducto() %>">
                                        <input type="number" name="cantidad" value="<%= item.getCantidad() %>" min="1">
                                        <button type="submit" class="btn btn-actualizar">Actualizar</button>
                                    </form>
                                </td>
                                <td data-label="Subtotal">S/ <%= String.format(java.util.Locale.US, "%.2f", item.getSubtotal()) %></td>
                                <td data-label="Acciones">
                                    <form action="<%= contextPath %>/TiendaControlador" method="post" onsubmit="return confirm('¿Deseas eliminar este producto del carrito?');">
                                        <input type="hidden" name="accion" value="eliminarItem">
                                        <input type="hidden" name="idProducto" value="<%= item.getIdProducto() %>">
                                        <button type="submit" class="btn btn-eliminar">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="total">
                    <span>Total (<%= cantidadCarrito %> productos): S/ <%= String.format(java.util.Locale.US, "%.2f", totalCarrito) %></span>
                    <form action="<%= contextPath %>/TiendaControlador" method="post">
                        <input type="hidden" name="accion" value="finalizarCompra">
                        <button type="submit" class="btn-comprar">Comprar</button>
                    </form>
                </div>
            <% } %>
        </div>
    </body>
</html>