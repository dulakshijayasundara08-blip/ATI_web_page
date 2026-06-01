<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal Login - ATI Badulla</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(rgba(13, 27, 82, 0.85), rgba(15, 32, 95, 0.9)), url('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1920') no-repeat center center/cover; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar-custom { background-color: #0d1b52; }
        .login-card { background: rgba(255, 255, 255, 0.95); border: none; border-radius: 20px; box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3); }
        .login-header { background-color: #0d1b52; color: white; padding: 30px; text-align: center; border-bottom: 4px solid #ffc107; }
        .form-control { border-radius: 10px; padding: 12px 15px 12px 45px; }
        .input-group-text-custom { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); z-index: 10; color: #6c757d; }
    </style>
</head>
<body>

<div class="container mt-5 pt-5 flex-grow-1 d-flex align-items-center justify-content-center">
    <div class="row justify-content-center w-100">
        <div class="col-md-6 col-lg-4">
            <div class="card login-card">
                <div class="login-header">
                    <i class="fa-solid fa-graduation-cap fa-3x mb-2 text-warning"></i>
                    <h3 class="fw-bold m-0">CAMPUS PORTAL</h3>
                    <small class="text-white-50">Advanced Technological Institute, Badulla</small>
                </div>
                <div class="card-body p-4 p-sm-5">
                    <% String error = request.getParameter("error");
                       if (error != null) { %>
                        <div class="alert alert-danger small p-2">
                            <% if (error.equals("wrongpassword")) { %> ඇතුළත් කළ මුරපදය වැරදියි!
                            <% } else if (error.equals("usernotfound")) { %> මෙවැනි පරිශීලක නාමයක් නැත!
                            <% } else if (error.equals("servererror")) { %> සර්වර් දෝෂයකි! 
                            <% } %>
                        </div>
                    <% } %>

                    <form action="LoginServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Username</label>
                            <div class="position-relative">
                                <span class="input-group-text-custom"><i class="fa-solid fa-user"></i></span>
                                <input type="text" name="username" class="form-control" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary small">Password</label>
                            <div class="position-relative">
                                <span class="input-group-text-custom"><i class="fa-solid fa-lock"></i></span>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-2.5 fw-bold rounded-pill" style="background-color: #0d1b52;">
                            <i class="fa-solid fa-right-to-bracket me-2"></i>Secure Login
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>