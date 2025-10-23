<%@page import="java.util.List"%>
<%@page import="Modelo.clsCategoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Categorías</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f4f4;
            font-family: Arial, sans-serif;
        }
        .container-custom {
            max-width: 900px;
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
            <h5 class="mb-0">Agregar Nueva Categoría</h5>
        </div>
        <div class="card-body">
            <form class="row g-3" action="${pageContext.request.contextPath}/CategoriaControlador" method="post">
                <input type="hidden" name="accion" value="Agregar">

                <div class="col-md-6">
                    <label class="form-label">Nombre de la Categoría</label>
                    <input type="text" name="txtCategoria" class="form-control" required maxlength="20">
                </div>

                <div class="col-md-4">
                    <label class="form-label">Estado</label>
                    <select name="txtEstado" class="form-select" required>
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>

                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-primary w-100">Agregar</button>
                </div>
            </form>
        </div>
    </div>

    <!-- CARD TABLA -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Lista de Categorías Registradas</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-bordered table-hover text-center mb-0">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Categoría</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<clsCategoria> lista = (List<clsCategoria>) request.getAttribute("listaCategorias");
                    if (lista != null) {
                        for (clsCategoria c : lista) {
                %>
                    <tr>
                        <td><%= c.getIdcategoria() %></td>
                        <td><%= c.getCategoria() %></td>
                        <td>
                            <span class="badge <%= (c.getEstado()==1)?"bg-success":"bg-danger" %>">
                                <%= (c.getEstado()==1)?"Activo":"Inactivo" %>
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-success"
                                    onclick="abrirModal(<%= c.getIdcategoria() %>, '<%= c.getCategoria() %>', <%= c.getEstado() %>)">
                                Editar
                            </button>
                            <a class="btn btn-sm btn-danger"
                               href="${pageContext.request.contextPath}/CategoriaControlador?accion=eliminar&idcategoria=<%= c.getIdcategoria() %>"
                               onclick="return confirm('¿Deseas eliminar esta categoría?');">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                <% }} %>
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
                <h5 class="modal-title">Editar Categoría</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/CategoriaControlador" method="post">
                <div class="modal-body">
                    <input type="hidden" name="accion" value="Actualizar">
                    <input type="hidden" name="txtIdcategoria" id="txtIdcategoria">

                    <label class="form-label">Nombre de la Categoría</label>
                    <input type="text" class="form-control mb-3" id="txtCategoriaEdit" name="txtCategoriaEdit" required maxlength="20">

                    <label class="form-label">Estado</label>
                    <select class="form-select" id="txtEstadoEdit" name="txtEstadoEdit" required>
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
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
function abrirModal(id, categoria, estado) {
    document.getElementById('txtIdcategoria').value = id;
    document.getElementById('txtCategoriaEdit').value = categoria;
    document.getElementById('txtEstadoEdit').value = estado;
    new bootstrap.Modal(document.getElementById('modalEditar')).show();
}
</script>

</body>
</html>
