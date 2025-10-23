<%@page import="java.util.List"%>
<%@page import="Modelo.clsTipoDocumento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registro - Tiendita de Don Pepe</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="text-center mb-4">
                <h1 class="fw-bold text-primary">Crear Cuenta</h1>
                <p class="text-muted mb-0">Regístrate para continuar con tus compras.</p>
            </div>

            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h2 class="h4 text-center mb-4">Registro de Cliente</h2>

                    <!-- Mensaje de error -->
                    <div class="alert alert-danger d-none" id="errorMessage" role="alert">
                        Error en el registro. Intente nuevamente.
                    </div>

                    <!-- Mensaje de éxito -->
                    <div class="alert alert-success d-none" id="successMessage" role="alert">
                        ¡Registro exitoso! Ya puede iniciar sesión.
                    </div>

                    <form action="RegistroControlador" method="POST" onsubmit="return validarFormulario()">
                        <input type="hidden" name="accion" value="registrar">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtNombre" class="form-label">Nombre</label>
                                <input type="text" id="txtNombre" name="txtNombre" class="form-control" placeholder="Ingrese su nombre" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="txtApellido" class="form-label">Apellido</label>
                                <input type="text" id="txtApellido" name="txtApellido" class="form-control" placeholder="Ingrese su apellido" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtTipoDocumento" class="form-label">Tipo Documento</label>
                                <select id="txtTipoDocumento" name="txtTipoDocumento" class="form-select" required>
                                    <option value="">Seleccione tipo</option>
                                    <%
                                        List<clsTipoDocumento> listaTiposDoc = (List<clsTipoDocumento>) request.getAttribute("listaTiposDoc");
                                        if (listaTiposDoc != null) {
                                            for (clsTipoDocumento td : listaTiposDoc) {
                                    %>
                                    <option value="<%= td.getIdtipodocumento() %>"><%= td.getNombre() %></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="txtNumeroDocumento" class="form-label">N° Documento</label>
                                <input type="text" id="txtNumeroDocumento" name="txtNumeroDocumento" class="form-control" placeholder="Número" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="txtEmail" class="form-label">Email</label>
                            <input type="email" id="txtEmail" name="txtEmail" class="form-control" placeholder="ejemplo@correo.com" required>
                        </div>

                        <div class="mb-3">
                            <label for="txtClave" class="form-label">Contraseña</label>
                            <input type="password" id="txtClave" name="txtClave" class="form-control" placeholder="Ingrese su contraseña" required minlength="4">
                        </div>

                        <div class="mb-3">
                            <label for="txtTelefono" class="form-label">Teléfono</label>
                            <input type="text" id="txtTelefono" name="txtTelefono" class="form-control" placeholder="Ingrese su teléfono" maxlength="9">
                        </div>

                        <div class="mb-3">
                            <label for="txtDireccion" class="form-label">Dirección</label>
                            <input type="text" id="txtDireccion" name="txtDireccion" class="form-control" placeholder="Ingrese su dirección">
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Registrarse</button>
                    </form>

                    <p class="text-center mt-4 mb-2">
                        ¿Ya tienes cuenta?
                        <a href="${pageContext.request.contextPath}/index.jsp" class="fw-semibold">Inicia sesión aquí</a>
                    </p>

                    <p class="text-center mb-0">
                        <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none">← Volver al inicio</a>
                    </p>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- BOOTSTRAP JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // (TU MISMO SCRIPT, SIN CAMBIOS)
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('error')) {
        document.getElementById('errorMessage').classList.remove('d-none');
        let errorType = urlParams.get('error');
        if (errorType === 'campos_vacios') {
            document.getElementById('errorMessage').textContent = 'Por favor, complete todos los campos obligatorios.';
        } else if (errorType === 'registro_fallido') {
            document.getElementById('errorMessage').textContent = 'Error al registrar. El email o documento ya pueden estar en uso.';
        }
    }
    if (urlParams.has('registro') && urlParams.get('registro') === 'exitoso') {
        document.getElementById('successMessage').classList.remove('d-none');
        document.getElementById('errorMessage').classList.add('d-none');
    }

    function validarFormulario() {
        const clave = document.getElementById('txtClave').value;
        const tipoDoc = document.getElementById('txtTipoDocumento').value;
        const numeroDoc = document.getElementById('txtNumeroDocumento').value;

        if (clave.length < 4) {
            alert('La contraseña debe tener al menos 4 caracteres.');
            return false;
        }
        if (tipoDoc === "") {
            alert('Por favor seleccione un tipo de documento.');
            return false;
        }
        if (tipoDoc === "1") {
            if (numeroDoc.length !== 8 || isNaN(numeroDoc)) {
                alert('El DNI debe tener 8 dígitos numéricos.');
                return false;
            }
        }
        return true;
    }

    document.getElementById('txtTipoDocumento').addEventListener('change', function() {
        const tipoDoc = this.value;
        const numeroDocInput = document.getElementById('txtNumeroDocumento');

        if (tipoDoc === "1") {
            numeroDocInput.placeholder = "8 dígitos";
            numeroDocInput.maxLength = 8;
        } else if (tipoDoc === "2") {
            numeroDocInput.placeholder = "Número de pasaporte";
            numeroDocInput.maxLength = 12;
        } else {
            numeroDocInput.placeholder = "Número";
            numeroDocInput.maxLength = 20;
        }
    });

    document.getElementById('txtNumeroDocumento').addEventListener('input', function(e) {
        const tipoDoc = document.getElementById('txtTipoDocumento').value;
        if (tipoDoc === "1") {
            this.value = this.value.replace(/[^0-9]/g, '');
        }
    });

    document.getElementById('txtTelefono').addEventListener('input', function(e) {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
</script>

</body>
</html>
