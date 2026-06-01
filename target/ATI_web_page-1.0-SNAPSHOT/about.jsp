<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | ATI Badulla</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f8f9fa; }
        .navbar-custom { background-color: #0d1b52; }
        .hero-section { 
            background: linear-gradient(rgba(13, 27, 82, 0.95), rgba(13, 27, 82, 0.95)), url('background.jpg'); 
            color: white; padding: 80px 0; 
        }
        .about-card { 
            border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); 
            margin-top: -50px; background: white; padding: 40px; 
        }
        .vision-box { 
            border-left: 5px solid #ffc107 !important; 
            background: #f8f9fa; padding: 20px; border-radius: 5px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top shadow">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="index.jsp">
                <i class="fa-solid fa-graduation-cap me-2"></i>ATI BADULLA
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto fw-semibold align-items-center">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link active text-warning" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="courses.jsp">Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="results.jsp">Results</a></li>
                    <li class="nav-item"><a class="nav-link" href="gallery.jsp">Gallery</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <li class="nav-item">
                        <a class="btn btn-warning btn-sm text-dark ms-2 px-3 fw-bold rounded-pill" href="login.jsp">
                            <i class="fa-solid fa-user-lock me-1"></i> Admin
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="hero-section text-center">
        <h1 class="display-4 fw-bold">About Advanced Technological Institute</h1>
        <p class="lead">Empowering the future through technical excellence.</p>
    </div>

    <div class="container">
        <div class="card about-card">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="fw-bold mb-3" style="color: #0d1b52;"><i class="fas fa-info-circle me-2"></i>Who We Are</h2>
                    <p class="text-muted fs-5">ATI Badulla is a leading government technological institute in Sri Lanka, dedicated to providing high-quality diploma programs in Engineering, Business, and IT sectors.</p>
                    <p>We strive to produce industry-ready graduates with practical skills and innovative mindsets, ensuring a bright future for our students.</p>
                </div>
                <div class="col-md-6">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA5HyBAPabU-wWCXiJc_MA86Bwpnbb-olorQ&s" class="img-fluid rounded-4 shadow" alt="ATI Campus">
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-md-6 mb-4">
                    <div class="vision-box h-100 shadow-sm">
                        <h4 class="fw-bold" style="color: #0d1b52;"><i class="fas fa-eye text-warning me-2"></i>Our Vision</h4>
                        <p class="text-muted">To be the center of excellence in technological education, producing global citizens.</p>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="vision-box h-100 shadow-sm">
                        <h4 class="fw-bold" style="color: #0d1b52;"><i class="fas fa-rocket text-primary me-2"></i>Our Mission</h4>
                        <p class="text-muted">To empower students through advanced technical knowledge, research, and innovation.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="py-4 text-center mt-5" style="background-color: #0d1b52; color: #c2c7d0;">
        <p class="m-0">&copy; 2026 ATI Badulla. All Rights Reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>