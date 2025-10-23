<%@page import="java.util.List"%>
<%@page import="Modelo.clsEmpleado"%>
<%@page import="Modelo.clsCargo"%>
<%@page import="Modelo.clsTipoDocumento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Empleados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f4f4;
            font-family: Arial, sans-serif;
        }
        .container-custom {
            max-width: 1200px;
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

    <!-- ALERTAS -->
    <%
        String mensaje = (String) session.getAttribute("mensaje");
        String error = (String) session.getAttribute("error");
    %>
    <% if (mensaje != null) { %>
        <div class="alert alert-success"><%= mensaje %></div>
        <% session.removeAttribute("mensaje"); %>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
        <% session.removeAttribute("error"); %>
    <% } %>

    <!-- CARD FORMULARIO -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Agregar Nuevo Empleado</h5>
        </div>
        <div class="card-body">
            <form class="row g-3" action="${pageContext.request.contextPath}/EmpleadoControlador" method="post">
                <input type="hidden" name="accion" value="Agregar">

                <div class="col-md-6">
                    <label class="form-label">Nombre:</label>
                    <input type="text" name="txtNombre" class="form-control" required maxlength="100">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Apellido:</label>
                    <input type="text" name="txtApellido" class="form-control" required maxlength="200">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Cargo:</label>
                    <select name="txtCargo" class="form-select" required>
                        <option value="">Seleccionar Cargo</option>
                        <% 
                            List<clsCargo> listaCargos = (List<clsCargo>) request.getAttribute("listaCargos");
                            if (listaCargos != null) {
                                for (clsCargo c : listaCargos) {
                        %>
                        <option value="<%= c.getIdcargo() %>"><%= c.getNombre() %></option>
                        <% } } %>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Usuario:</label>
                    <input type="text" name="txtUsuario" class="form-control" required maxlength="12">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Clave:</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="txtClave" name="txtClave" required maxlength="15">
                        <button type="button" class="btn btn-secondary" onclick="togglePassword('txtClave')">👁️</button>
                    </div>
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
                    <input type="text" name="txtNumeroDocumento" class="form-control" required maxlength="10">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Teléfono:</label>
                    <input type="text" name="txtTelefono" class="form-control" required maxlength="9">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Estado:</label>
                    <select name="txtEstado" class="form-select" required>
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>

                <div class="col-md-12 d-flex justify-content-end mt-3">
                    <button class="btn btn-primary">Agregar Empleado</button>
                </div>
            </form>
        </div>
    </div>

    <!-- CARD TABLA -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Lista de Empleados Registrados</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-bordered table-hover text-center mb-0">
                <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Cargo</th>
                    <th>Usuario</th>
                    <th>Tipo Documento</th>
                    <th>N° Documento</th>
                    <th>Teléfono</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<clsEmpleado> listaEmpleados = (List<clsEmpleado>) request.getAttribute("listaEmpleados");
                    if (listaEmpleados != null && !listaEmpleados.isEmpty()) {
                        for (clsEmpleado e : listaEmpleados) {
                %>
                <tr>
                    <td><%= e.getIdEmpleado() %></td>
                    <td><%= e.getNombre() %></td>
                    <td><%= e.getApellido() %></td>
                    <td><%= e.getNombreCargo() %></td>
                    <td><%= e.getUsuario() %></td>
                    <td><%= e.getNombreDocumento() %></td>
                    <td><%= e.getNumeroDocumento() %></td>
                    <td><%= e.getTelefono() %></td>
                    <td>
                        <span class="badge <%= (e.getEstado()==1)?"bg-success":"bg-danger" %>">
                            <%= (e.getEstado()==1)?"Activo":"Inactivo" %>
                        </span>
                    </td>
                    <td>
                        <button class="btn btn-sm btn-success"
                                onclick="abrirModalEditar(<%= e.getIdEmpleado() %>, '<%= e.getNombre() %>', '<%= e.getApellido() %>',
                                <%= e.getIdcargo() %>, '<%= e.getUsuario() %>', '<%= e.getClave() %>',
                                <%= e.getIdTipoDocumento() %>, '<%= e.getNumeroDocumento() %>', '<%= e.getTelefono() %>',
                                <%= e.getEstado() %>)">
                            Editar
                        </button>
                        <a class="btn btn-sm btn-danger"
                           href="${pageContext.request.contextPath}/EmpleadoControlador?accion=eliminar&idEmpleado=<%= e.getIdEmpleado() %>"
                           onclick="return confirm('¿Estás seguro de eliminar este empleado?');">
                            Eliminar
                        </a>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="10">No hay empleados registrados</td>
                </tr>
                <% } %>
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
                <h5 class="modal-title">Editar Empleado</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/EmpleadoControlador" method="post">
                <div class="modal-body">
                    <input type="hidden" name="accion" value="Actualizar">
                    <input type="hidden" name="txtIdEmpleado" id="txtIdEmpleado">

                    <div class="row g-3">

                        <div class="col-md-6">
                            <label class="form-label">Nombre:</label>
                            <input type="text" class="form-control" id="txtNombreEdit" name="txtNombreEdit" required maxlength="100">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Apellido:</label>
                            <input type="text" class="form-control" id="txtApellidoEdit" name="txtApellidoEdit" required maxlength="200">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Cargo:</label>
                            <select class="form-select" id="txtCargoEdit" name="txtCargoEdit" required>
                                <option value="">Seleccionar Cargo</option>
                                <% if (listaCargos != null) {
                                       for (clsCargo c : listaCargos) { %>
                                    <option value="<%= c.getIdcargo() %>"><%= c.getNombre() %></option>
                                <% } } %>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Usuario:</label>
                            <input type="text" class="form-control" id="txtUsuarioEdit" name="txtUsuarioEdit" required maxlength="12">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Clave:</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="txtClaveEdit" name="txtClaveEdit" required maxlength="15">
                                <button type="button" class="btn btn-secondary" onclick="togglePassword('txtClaveEdit')">👁️</button>
                            </div>
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
                            <input type="text" class="form-control" id="txtNumeroDocumentoEdit" name="txtNumeroDocumentoEdit" required maxlength="10">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Teléfono:</label>
                            <input type="text" class="form-control" id="txtTelefonoEdit" name="txtTelefonoEdit" required maxlength="9">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Estado:</label>
                            <select class="form-select" id="txtEstadoEdit" name="txtEstadoEdit" required>
                                <option value="1">Activo</option>
                                <option value="0">Inactivo</option>
                            </select>
                        </div>

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

function abrirModalEditar(id, nombre, apellido, idcargo, usuario, clave, idTipoDoc, numDoc, telefono, estado) {
    document.getElementById('txtIdEmpleado').value = id;
    document.getElementById('txtNombreEdit').value = nombre;
    document.getElementById('txtApellidoEdit').value = apellido;
    document.getElementById('txtCargoEdit').value = idcargo;
    document.getElementById('txtUsuarioEdit').value = usuario;
    document.getElementById('txtClaveEdit').value = clave;
    document.getElementById('txtTipoDocumentoEdit').value = idTipoDoc;
    document.getElementById('txtNumeroDocumentoEdit').value = numDoc;
    document.getElementById('txtTelefonoEdit').value = telefono;
    document.getElementById('txtEstadoEdit').value = estado;

    new bootstrap.Modal(document.getElementById('modalEditar')).show();
}
</script>

</body>
</html>
