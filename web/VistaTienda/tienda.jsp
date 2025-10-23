<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.clsProducto"%>
<%@page import="Modelo.clsCategoria"%>
<%
    List<clsProducto> productos = (List<clsProducto>) request.getAttribute("productos");
    List<clsCategoria> categorias = (List<clsCategoria>) request.getAttribute("categorias");
    Integer categoriaSeleccionada = (Integer) request.getAttribute("categoriaSeleccionada");
    Integer cantidadCarrito = (Integer) request.getAttribute("cantidadCarrito");
    String mensajeTienda = (String) request.getAttribute("mensajeTienda");
    if (productos == null) {
        productos = java.util.Collections.emptyList();
    }
    if (categorias == null) {
        categorias = java.util.Collections.emptyList();
    }
    if (cantidadCarrito == null) {
        cantidadCarrito = 0;
    }
    String nombreUsuario = (String) session.getAttribute("usuario");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
    <head>
<meta charset="UTF-8">
        <title>Tienda en Línea</title>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                background-color: #f5f7fa;
                color: #333;
            }
            header {
                background: linear-gradient(135deg, #ff6f00, #ff9100);
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
            .user-info {
                font-size: 16px;
            }
            .user-info span {
                font-weight: bold;
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
                background: rgba(255,255,255,0.2);
                padding: 8px 16px;
                border-radius: 20px;
                transition: background 0.3s ease;
            }
            .actions a:hover {
                background: rgba(0,0,0,0.2);
            }
            .container {
                padding: 30px 40px;
            }
            .filters {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 25px;
            }
            .filters form {
                display: flex;
                gap: 10px;
                align-items: center;
            }
            select {
                padding: 10px 15px;
                border: 1px solid #ccc;
                border-radius: 8px;
                background-color: #fff;
                font-size: 14px;
            }
            .mensaje {
                padding: 12px 16px;
                background-color: #e8f5e9;
                border-left: 4px solid #2e7d32;
                border-radius: 6px;
                color: #1b5e20;
                margin-bottom: 20px;
            }
            .productos {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
                gap: 20px;
            }
            .producto {
                background-color: #fff;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .producto:hover {
                transform: translateY(-4px);
                box-shadow: 0 14px 30px rgba(0, 0, 0, 0.12);
            }
            .producto h3 {
                margin: 0 0 10px 0;
                font-size: 18px;
                color: #1a237e;
            }
            .producto .categoria {
                font-size: 12px;
                color: #607d8b;
                margin-bottom: 12px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .producto .precio {
                font-size: 20px;
                font-weight: bold;
                color: #ff6f00;
                margin-bottom: 6px;
            }
            .producto .stock {
                font-size: 13px;
                color: #2e7d32;
                margin-bottom: 16px;
            }
            .producto button {
                padding: 12px 15px;
                border: none;
                border-radius: 8px;
                background-color: #1a73e8;
                color: #fff;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s ease;
            }
            .producto button:hover {
                background-color: #0c47a1;
            }
            .sin-productos {
                text-align: center;
                padding: 60px 20px;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
                font-size: 18px;
                color: #607d8b;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }
            .modal-content {
                background-color: #fff;
                margin: 10% auto;
                padding: 25px;
                border-radius: 12px;
                width: 90%;
                max-width: 420px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            }
            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }
            .modal-header h2 {
                margin: 0;
                font-size: 20px;
                color: #1a237e;
            }
            .close {
                font-size: 24px;
                cursor: pointer;
            }
            .modal-body p {
                margin: 8px 0;
            }
            .modal-body input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin-top: 10px;
                font-size: 16px;
            }
            .modal-footer {
                margin-top: 20px;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }
            .modal-footer button {
                padding: 10px 18px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                cursor: pointer;
            }
            .btn-cancelar {
                background-color: #cfd8dc;
                color: #37474f;
            }
            .btn-confirmar {
                background-color: #1a73e8;
                color: #fff;
            }
            @media (max-width: 768px) {
                header {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                }
                .filters {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .filters form {
                    width: 100%;
                }
                select {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
<header>
            <h1>Tienda Virtual</h1>
            <div class="actions">
                <div class="user-info">Hola, <span><%= nombreUsuario != null ? nombreUsuario : "Cliente" %></span></div>
                <a href="<%= contextPath %>/TiendaControlador?accion=verCarrito">Carrito (<%= cantidadCarrito %>)</a>
                <a href="<%= contextPath %>/UsuarioControlador?accion=logout">Cerrar sesión</a>
            </div>
        </header>

        <div class="container">
            <div class="filters">
                <form action="<%= contextPath %>/TiendaControlador" method="get">
                    <input type="hidden" name="accion" value="tienda">
                    <label for="categoria">Filtrar por categoría:</label>
                    <select name="categoria" id="categoria" onchange="this.form.submit()">
                        <option value="">Todas</option>
                        <% for (clsCategoria categoria : categorias) { %>
                            <option value="<%= categoria.getIdcategoria() %>" <%= (categoriaSeleccionada != null && categoriaSeleccionada.equals(categoria.getIdcategoria())) ? "selected" : "" %>>
                                <%= categoria.getCategoria() %>
                            </option>
                        <% } %>
                    </select>
                </form>
            </div>

            <% if (mensajeTienda != null) { %>
                <div class="mensaje"><%= mensajeTienda %></div>
            <% } %>

            <% if (productos.isEmpty()) { %>
                <div class="sin-productos">No hay productos disponibles en este momento.</div>
            <% } else { %>
                <div class="productos">
                    <% for (clsProducto producto : productos) { %>
                        <div class="producto" data-id="<%= producto.getIdProducto() %>"
                             data-nombre="<%= producto.getNombre() %>"
                             data-precio="<%= producto.getPrecioUnitario() %>"
                             data-stock="<%= producto.getCantidad() %>">
                            <div>
                                <div class="categoria"><%= producto.getNombreCategoria() %></div>
                                <h3><%= producto.getNombre() %></h3>
                                <div class="precio">S/ <%= String.format(java.util.Locale.US, "%.2f", producto.getPrecioUnitario()) %></div>
                                <div class="stock">Stock disponible: <%= producto.getCantidad() %></div>
                            </div>
                            <button type="button" class="btn-agregar">Agregar al carrito</button>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>

        <div id="modalAgregar" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modalNombre">Producto</h2>
                    <span class="close" id="cerrarModal">&times;</span>
                </div>
                <form id="formAgregar" action="<%= contextPath %>/TiendaControlador" method="post">
                    <input type="hidden" name="accion" value="agregarCarrito">
                    <input type="hidden" name="idProducto" id="modalIdProducto">
                    <div class="modal-body">
                        <p>Precio unitario: S/ <span id="modalPrecio">0.00</span></p>
                        <p>Stock disponible: <span id="modalStock">0</span></p>
                        <label for="modalCantidad">Cantidad:</label>
                        <input type="number" name="cantidad" id="modalCantidad" min="1" value="1">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-cancelar" id="btnCancelar">Cancelar</button>
                        <button type="submit" class="btn-confirmar">Agregar</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            const modal = document.getElementById('modalAgregar');
            const cerrarModal = document.getElementById('cerrarModal');
            const btnCancelar = document.getElementById('btnCancelar');
            const modalNombre = document.getElementById('modalNombre');
            const modalPrecio = document.getElementById('modalPrecio');
            const modalStock = document.getElementById('modalStock');
            const modalIdProducto = document.getElementById('modalIdProducto');
            const modalCantidad = document.getElementById('modalCantidad');

            function abrirModal(productoElemento) {
                modalNombre.textContent = productoElemento.dataset.nombre;
                modalPrecio.textContent = parseFloat(productoElemento.dataset.precio).toFixed(2);
                modalStock.textContent = productoElemento.dataset.stock;
                modalIdProducto.value = productoElemento.dataset.id;
                modalCantidad.max = productoElemento.dataset.stock;
                modalCantidad.value = 1;
                modal.style.display = 'block';
            }

            function cerrarModalFuncion() {
                modal.style.display = 'none';
            }

            document.querySelectorAll('.btn-agregar').forEach(btn => {
                btn.addEventListener('click', (event) => {
                    const productoElemento = event.target.closest('.producto');
                    abrirModal(productoElemento);
                });
            });

            cerrarModal.addEventListener('click', cerrarModalFuncion);
            btnCancelar.addEventListener('click', cerrarModalFuncion);
            window.addEventListener('click', (event) => {
                if (event.target === modal) {
                    cerrarModalFuncion();
                }
            });
        </script>
    </body>
</html>