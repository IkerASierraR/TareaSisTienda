<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tiendita de Don Pepe - Panel administrativo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <span class="navbar-brand fw-semibold">Tiendita de Don Pepe</span>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="../index.jsp">Cerrar sesión</a>
                    </li>
                </ul>
            </div>
        </div>
        </nav>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-xl-8 col-lg-9">
                <div class="card shadow-sm">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <h1 class="h3 fw-bold text-primary">Panel administrativo</h1>
                            <p class="text-muted mb-0">Gestiona cada módulo del sistema de la Tiendita de Don Pepe desde un mismo lugar.</p>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <a class="btn btn-outline-primary w-100 py-3" href="../CargoControlador?accion=listar">
                                    Gestión de cargos
                                </a>
                            </div>
                            <div class="col-md-6">
                                <a class="btn btn-outline-primary w-100 py-3" href="../CategoriaControlador?accion=listar">
                                    Gestión de categorías
                                </a>
                            </div>
                            <div class="col-md-6">
                                <a class="btn btn-outline-primary w-100 py-3" href="../EmpleadoControlador?accion=listar">
                                    Gestión de empleados
                                </a>
                            </div>
                            <div class="col-md-6">
                                <a class="btn btn-outline-primary w-100 py-3" href="../ClienteControlador?accion=listar">
                                    Gestión de clientes
                                </a>
                            </div>
                            <div class="col-md-12">
                                <a class="btn btn-outline-primary w-100 py-3" href="../ProductoControlador?accion=listar">
                                    Gestión de productos
                                </a>
                            </div>
                        </div>
                        <div class="d-grid mt-4">
                            <a class="btn btn-danger" href="../index.jsp">Cerrar sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>