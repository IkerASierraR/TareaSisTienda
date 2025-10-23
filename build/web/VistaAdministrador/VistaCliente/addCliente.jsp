<%@page import="java.util.List"%>
<%@page import="Modelo.clsCliente"%>
<%@page import="Modelo.clsTipoDocumento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Clientes</title>
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
            <h5 class="mb-0">Agregar Nuevo Cliente</h5>
        </div>

        <div class="card-body">
            <form class="row g-3" action="${pageContext.request.contextPath}/ClienteControlador" method="post">
                <input type="hidden" name="accion" value="Agregar">

                <div class="col-md-6">
                    <label class="form-label">Nombre:</label>
                    <input type="text" name="txtNombre" class="form-control" required maxlength="50">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Apellido:</label>
                    <input type="text" name="txtApellido" class="form-control" required maxlength="50">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Tipo Documento:</label>
                    <select name="txtTipoDocumento" class="form-select" required>
                        <option value="">Seleccionar Tipo</option>
                        <% 
                            List<clsTipoDocumento> listaTiposDoc = (List<clsTipoDocumento>) request.getAttribute("listaTiposDoc");
                            if (listaTiposDoc != null) {
                                for (clsTipoDocumento td : listaTiposDoc) {
                        %>
                        <option value="<%= td.getIdtipodocumento() %>"><%= td.getNombre() %></option>
                        <% } } %>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label">N° Documento:</label>
                    <input type="text" name="txtNumeroDocumento" class="form-control" required maxlength="50">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Teléfono:</label>
                    <input type="text" name="txtTelefono" class="form-control" maxlength="50">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Dirección:</label>
                    <input type="text" name="txtDireccion" class="form-control" maxlength="50">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Email:</label>
                    <input type="email" name="txtEmail" class="form-control" maxlength="50">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Clave:</label>
                    <div class="input-group">
                        <input type="password" name="txtClave" id="txtClave" class="form-control" maxlength="50">
                        <button type="button" class="btn btn-secondary" onclick="togglePassword('txtClave')">👁️</button>
                    </div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Estado:</label>
                    <select name="txtEstado" class="form-select" required>
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>

                <div class="col-12 d-flex justify-content-end mt-3">
                    <button class="btn btn-primary">Agregar Cliente</button>
                </div>
            </form>
        </div>
    </div>

    <!-- CARD TABLA -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Lista de Clientes Registrados</h5>
        </div>

        <div class="card-body p-0">
            <table class="table table-bordered table-hover text-center mb-0">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Tipo Documento</th>
                        <th>N° Documento</th>
                        <th>Teléfono</th>
                        <th>Dirección</th>
                        <th>Email</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<clsCliente> listaClientes = (List<clsCliente>) request.getAttribute("listaClientes");
                    if (listaClientes != null) {
                        for (clsCliente c : listaClientes) {
                %>
                    <tr>
                        <td><%= c.getIdcliente() %></td>
                        <td><%= c.getNombre() %></td>
                        <td><%= c.getApellido() %></td>
                        <td><%= c.getNombreDocumento() %></td>
                        <td><%= c.getNumeroDocumento() %></td>
                        <td><%= c.getTelefono() %></td>
                        <td><%= c.getDireccion() %></td>
                        <td><%= c.getEmail() %></td>
                        <td>
                            <span class="badge <%= (c.getEstado()==1)?"bg-success":"bg-danger" %>">
                                <%= (c.getEstado()==1)?"Activo":"Inactivo" %>
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-success"
                                    onclick="abrirModalEditar(<%= c.getIdcliente() %>, '<%= c.getNombre() %>', '<%= c.getApellido() %>',
                                    <%= c.getIdTipoDocumento() %>, '<%= c.getNumeroDocumento() %>', '<%= c.getTelefono() %>',
                                    '<%= c.getDireccion() %>', '<%= c.getEmail() %>', '<%= c.getClave() %>', <%= c.getEstado() %>)">
                                Editar
                            </button>
                            <a class="btn btn-sm btn-danger"
                               href="${pageContext.request.contextPath}/ClienteControlador?accion=eliminar&idcliente=<%= c.getIdcliente() %>"
                               onclick="return confirm('¿Deseas eliminar este cliente?');">Eliminar
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
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Editar Cliente</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="${pageContext.request.contextPath}/ClienteControlador" method="post">
                <div class="modal-body row g-3">
                    <input type="hidden" name="accion" value="Actualizar">
                    <input type="hidden" name="txtIdcliente" id="txtIdcliente">

                    <div class="col-md-6">
                        <label class="form-label">Nombre:</label>
                        <input type="text" class="form-control" id="txtNombreEdit" name="txtNombreEdit" required maxlength="50">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Apellido:</label>
                        <input type="text" class="form-control" id="txtApellidoEdit" name="txtApellidoEdit" required maxlength="50">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Tipo Documento:</label>
                        <select class="form-select" id="txtTipoDocumentoEdit" name="txtTipoDocumentoEdit" required>
                            <option value="">Seleccionar Tipo</option>
                            <% if (listaTiposDoc != null) {
                                   for (clsTipoDocumento td : listaTiposDoc) { %>
                                <option value="<%= td.getIdtipodocumento() %>"><%= td.getNombre() %></option>
                            <% } } %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">N° Documento:</label>
                        <input type="text" class="form-control" id="txtNumeroDocumentoEdit" name="txtNumeroDocumentoEdit" required maxlength="50">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Teléfono:</label>
                        <input type="text" class="form-control" id="txtTelefonoEdit" name="txtTelefonoEdit" maxlength="50">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Dirección:</label>
                        <input type="text" class="form-control" id="txtDireccionEdit" name="txtDireccionEdit" maxlength="50">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email:</label>
                        <input type="email" class="form-control" id="txtEmailEdit" name="txtEmailEdit" maxlength="50">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Clave:</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="txtClaveEdit" name="txtClaveEdit" maxlength="50">
                            <button type="button" class="btn btn-secondary" onclick="togglePassword('txtClaveEdit')">👁️</button>
                        </div>
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
function togglePassword(inputId) {
    const input = document.getElementById(inputId);
    input.type = (input.type === "password") ? "text" : "password";
}

function abrirModalEditar(id, nombre, apellido, idTipoDoc, numDoc, telefono, direccion, email, clave, estado) {
    document.getElementById('txtIdcliente').value = id;
    document.getElementById('txtNombreEdit').value = nombre;
    document.getElementById('txtApellidoEdit').value = apellido;
    document.getElementById('txtTipoDocumentoEdit').value = idTipoDoc;
    document.getElementById('txtNumeroDocumentoEdit').value = numDoc;
    document.getElementById('txtTelefonoEdit').value = telefono;
    document.getElementById('txtDireccionEdit').value = direccion;
    document.getElementById('txtEmailEdit').value = email;
    document.getElementById('txtClaveEdit').value = clave;
    document.getElementById('txtEstadoEdit').value = estado;

    new bootstrap.Modal(document.getElementById('modalEditar')).show();
}
</script>

</body>
</html>
