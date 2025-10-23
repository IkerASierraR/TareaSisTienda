<%@page import="java.util.List"%>
<%@page import="Modelo.clsProducto"%>
<%@page import="Modelo.clsCategoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f4f4;
            font-family: Arial, sans-serif;
        }
        .container-custom {
            max-width: 1100px;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<!-- NAVBAR SUPERIOR -->
<nav class="navbar navbar-dark bg-primary">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h1">Tiendita de Don Pepe - Administración</span>
    </div>
</nav>

<div class="container container-custom">

    <!-- CARD FORMULARIO -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Agregar Nuevo Producto</h5>
        </div>

        <div class="card-body">
            <form class="row g-3" action="${pageContext.request.contextPath}/ProductoControlador" method="post">
                <input type="hidden" name="accion" value="Agregar">

                <div class="col-md-6">
                    <label class="form-label">Categoría:</label>
                    <select name="txtCategoria" class="form-select" required>
                        <option value="">Seleccionar Categoría</option>
                        <%
                            List<clsCategoria> listaCategorias = (List<clsCategoria>) request.getAttribute("listaCategorias");
                            if (listaCategorias != null) {
                                for (clsCategoria cat : listaCategorias) {
                        %>
                        <option value="<%= cat.getIdcategoria() %>"><%= cat.getCategoria() %></option>
                        <% } } %>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Nombre:</label>
                    <input type="text" name="txtNombre" class="form-control" placeholder="Nombre del Producto" required maxlength="50">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Cantidad:</label>
                    <input type="number" name="txtCantidad" class="form-control" placeholder="Cantidad" required min="0">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Precio Unitario:</label>
                    <input type="number" name="txtPrecio" class="form-control" placeholder="Precio" required min="0" step="0.01">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Estado:</label>
                    <select name="txtEstado" class="form-select" required>
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>

                <div class="col-12 d-flex justify-content-end mt-3">
                    <button class="btn btn-primary">Agregar Producto</button>
                </div>
            </form>
        </div>
    </div>

    <!-- CARD TABLA -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Lista de Productos Registrados</h5>
        </div>

        <div class="card-body p-0">
            <table class="table table-bordered table-hover text-center mb-0">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Categoría</th>
                        <th>Nombre</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<clsProducto> listaProductos = (List<clsProducto>) request.getAttribute("listaProductos");
                    if (listaProductos != null) {
                        for (clsProducto p : listaProductos) {
                %>
                    <tr>
                        <td><%= p.getIdProducto() %></td>
                        <td><%= p.getNombreCategoria() %></td>
                        <td><%= p.getNombre() %></td>
                        <td><%= p.getCantidad() %></td>
                        <td>S/. <%= String.format("%.2f", p.getPrecioUnitario()) %></td>
                        <td>
                            <span class="badge <%= (p.getEstado()==1)?"bg-success":"bg-danger" %>">
                                <%= (p.getEstado()==1)?"Activo":"Inactivo" %>
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-success"
                                    onclick="abrirModalEditar(<%= p.getIdProducto() %>, <%= p.getIdcategoria() %>,
                                    '<%= p.getNombre() %>', <%= p.getCantidad() %>, <%= p.getPrecioUnitario() %>,
                                    <%= p.getEstado() %>)">
                                Editar
                            </button>
                            <a class="btn btn-sm btn-danger"
                               href="${pageContext.request.contextPath}/ProductoControlador?accion=eliminar&idProducto=<%= p.getIdProducto() %>"
                               onclick="return confirm('¿Deseas eliminar este producto?');">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- MODAL EDITAR -->
<div class="modal fade" id="modalEditar" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Editar Producto</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="${pageContext.request.contextPath}/ProductoControlador" method="post">
                <div class="modal-body row g-3">
                    <input type="hidden" name="accion" value="Actualizar">
                    <input type="hidden" name="txtIdProducto" id="txtIdProducto">

                    <div class="col-md-6">
                        <label class="form-label">Categoría:</label>
                        <select class="form-select" id="txtCategoriaEdit" name="txtCategoriaEdit" required>
                            <option value="">Seleccionar Categoría</option>
                            <% if (listaCategorias != null) {
                                   for (clsCategoria cat : listaCategorias) { %>
                                <option value="<%= cat.getIdcategoria() %>"><%= cat.getCategoria() %></option>
                            <% } } %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Nombre:</label>
                        <input type="text" class="form-control" id="txtNombreEdit" name="txtNombreEdit" required maxlength="50">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Cantidad:</label>
                        <input type="number" class="form-control" id="txtCantidadEdit" name="txtCantidadEdit" required min="0">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Precio Unitario:</label>
                        <input type="number" class="form-control" id="txtPrecioEdit" name="txtPrecioEdit" required min="0" step="0.01">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Estado:</label>
                        <select class="form-select" id="txtEstadoEdit" name="txtEstadoEdit" required>
                            <option value="1">Activo</option>
                            <option value="0">Inactivo</option>
                        </select>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button class="btn btn-primary">Actualizar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function abrirModalEditar(id, idcategoria, nombre, cantidad, precio, estado) {
    document.getElementById('txtIdProducto').value = id;
    document.getElementById('txtCategoriaEdit').value = idcategoria;
    document.getElementById('txtNombreEdit').value = nombre;
    document.getElementById('txtCantidadEdit').value = cantidad;
    document.getElementById('txtPrecioEdit').value = precio;
    document.getElementById('txtEstadoEdit').value = estado;

    new bootstrap.Modal(document.getElementById('modalEditar')).show();
}
</script>

</body>
</html>
