<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tiendita de Don Pepe - Acceso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6">
                <div class="text-center mb-4">
                    <h1 class="fw-bold text-primary">Tiendita de Don Pepe</h1>
                    <p class="text-muted mb-0">Inicia sesión para administrar tus compras y pedidos.</p>
                </div>
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h2 class="h4 text-center mb-4">Iniciar sesión</h2>

                        <div class="alert alert-danger d-none" id="errorMessage" role="alert">
                            Usuario o contraseña incorrectos
                        </div>
                        <div class="alert alert-success d-none" id="successMessage" role="alert">
                            ¡Registro exitoso! Ya puede iniciar sesión.
                        </div>

                        <form action="UsuarioControlador" method="POST" class="needs-validation" novalidate>
                            <input type="hidden" name="accion" value="login">
                            <div class="mb-3">
                                <label for="usuario" class="form-label">Usuario o Email</label>
                                <input type="text" class="form-control" id="usuario" name="usuario" required>
                                <div class="invalid-feedback">Ingrese su usuario o correo.</div>
                            </div>
                            <div class="mb-3">
                                <label for="clave" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="clave" name="clave" required>
                                <div class="invalid-feedback">Ingrese su contraseña.</div>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Ingresar</button>
                            </div>
                        </form>

                        <p class="text-center mt-4 mb-0">
                            ¿No tienes cuenta?
                            <a href="RegistroControlador" class="fw-semibold">Regístrate aquí</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script>
        (function () {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });

            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('error')) {
                document.getElementById('errorMessage').classList.remove('d-none');
            }
            if (urlParams.get('registro') === 'exitoso') {
                document.getElementById('successMessage').classList.remove('d-none');
                document.getElementById('errorMessage').classList.add('d-none');
            }
        })();
    </script>
</body>
</html>