<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="Modelo.clsCarritoItem"%>
<%
    Map<String, Object> resumenCompra = (Map<String, Object>) request.getAttribute("resumenCompra");
    List<clsCarritoItem> items = java.util.Collections.emptyList();
    double total = 0;
    if (resumenCompra != null) {
        items = (List<clsCarritoItem>) resumenCompra.get("items");
        if (items == null) {
            items = java.util.Collections.emptyList();
        }
        Object totalObj = resumenCompra.get("total");
        if (totalObj instanceof Double) {
            total = (Double) totalObj;
        } else if (totalObj instanceof Number) {
            total = ((Number) totalObj).doubleValue();
        }
    }
    String nombreUsuario = (String) session.getAttribute("usuario");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
    <head>
<meta charset="UTF-8">
        <title>Compra realizada</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                background-color: #f5f7fa;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }
            .comprobante {
                background-color: #fff;
                padding: 30px 40px;
                border-radius: 16px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
                width: 100%;
                max-width: 640px;
            }
            .comprobante h1 {
                margin-top: 0;
                color: #1b5e20;
                text-align: center;
            }
            .detalle {
                margin-top: 30px;
            }
            .detalle h2 {
                font-size: 18px;
                color: #1a237e;
                margin-bottom: 15px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
            }
            th {
                background-color: #f1f8ff;
                text-transform: uppercase;
                font-size: 12px;
                letter-spacing: 1px;
            }
            .total {
                text-align: right;
                margin-top: 20px;
                font-size: 20px;
                font-weight: bold;
                color: #1a237e;
            }
            .acciones {
                margin-top: 30px;
                display: flex;
                justify-content: center;
            }
            .acciones a {
                background-color: #1a73e8;
                color: #fff;
                padding: 12px 24px;
                border-radius: 30px;
                text-decoration: none;
                font-weight: bold;
                transition: background 0.3s ease;
            }
            .acciones a:hover {
                background-color: #0c47a1;
            }
            .mensaje {
                text-align: center;
                font-size: 16px;
                margin-top: 10px;
                color: #607d8b;
            }
            .resumen-empty {
                text-align: center;
                color: #607d8b;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
<div class="comprobante">
            <h1>¡Compra realizada correctamente!</h1>
            <p class="mensaje">Gracias por tu compra <strong><%= nombreUsuario != null ? nombreUsuario : "Cliente" %></strong>. Hemos generado tu boleta electrónica.</p>

            <% if (!items.isEmpty()) { %>
                <div class="detalle">
                    <h2>Detalle de compra</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (clsCarritoItem item : items) { %>
                                <tr>
                                    <td><%= item.getNombreProducto() %></td>
                                    <td><%= item.getCantidad() %></td>
                                    <td>S/ <%= String.format(java.util.Locale.US, "%.2f", item.getPrecioUnitario()) %></td>
                                    <td>S/ <%= String.format(java.util.Locale.US, "%.2f", item.getSubtotal()) %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <div class="total">Total pagado: S/ <%= String.format(java.util.Locale.US, "%.2f", total) %></div>
                </div>
            <% } else { %>
                <div class="resumen-empty">No encontramos detalles recientes de compra. Vuelve a la tienda para seguir comprando.</div>
            <% } %>

            <div class="acciones">
                <a href="<%= contextPath %>/TiendaControlador">Volver a comprar</a>
            </div>
        </div>
    </body>
</html>
