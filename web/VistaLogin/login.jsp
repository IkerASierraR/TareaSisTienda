<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Sistema de Tienda</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #007bff, #00bcd4);
            color: white;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .login-container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: center;
        }
        h1 {
            margin-bottom: 20px;
            font-size: 2em;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: white;
            color: #007bff;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            transition: all 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
            color: white;
        }
        .register-link {
            margin-top: 15px;
        }
        .register-link a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .error {
            color: #ff6b6b;
            background: rgba(255, 255, 255, 0.2);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            display: none;
        }
        .success {
            color: #28a745;
            background: rgba(255, 255, 255, 0.2);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            display: none;
        }
        .back-link {
            margin-top: 10px;
        }
        .back-link a {
            color: white;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Iniciar Sesión</h1>
    <div class="login-container">
        <h3>Acceso al Sistema</h3>
        
        <!-- Mensaje de error -->
        <div class="error" id="errorMessage">
            Usuario o contraseña incorrectos
        </div>
        
        <!-- Mensaje de éxito por registro -->
        <div class="success" id="successMessage">
            ¡Registro exitoso! Ya puede iniciar sesión.
        </div>
        
        <form action="../UsuarioControlador" method="POST">
            <input type="hidden" name="accion" value="login">
            <input type="text" name="usuario" placeholder="Usuario o Email" required>
            <input type="password" name="clave" placeholder="Contraseña" required>
            <button type="submit">Ingresar</button>
        </form>
        
        <div class="register-link">
            <p>¿No tienes cuenta? 
                <a href="RegistroControlador">Regístrate aquí</a>
            </p>
        </div>
        
        <div class="back-link">
            <a href="../index.jsp">← Volver al inicio</a>
        </div>
    </div>

    <script>
        // Mostrar mensaje de error si existe en la URL
        const urlParams = new URLSearchParams(window.location.search);
        
        if (urlParams.has('error')) {
            document.getElementById('errorMessage').style.display = 'block';
        }
        
        if (urlParams.has('registro') && urlParams.get('registro') === 'exitoso') {
            document.getElementById('successMessage').style.display = 'block';
            document.getElementById('errorMessage').style.display = 'none';
        }
    </script>
</body>
</html>