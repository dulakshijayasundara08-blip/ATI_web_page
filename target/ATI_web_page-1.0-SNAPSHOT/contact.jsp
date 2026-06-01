<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | ATI Badulla</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f8f9fa; }
        .navbar-custom { background-color: #0d1b52; }
        .contact-card { border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .icon-box { width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; background: rgba(13, 27, 82, 0.1); color: #0d1b52; font-size: 20px; }
        .form-control { border-radius: 10px; padding: 12px; }
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
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="courses.jsp">Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="results.jsp">Results</a></li>
                    <li class="nav-item"><a class="nav-link active text-warning" href="contact.jsp">Contact</a></li>
                    <li class="nav-item">
                        <a class="btn btn-warning btn-sm text-dark ms-2 px-3 fw-bold rounded-pill" href="login.jsp">
                            <i class="fa-solid fa-user-lock me-1"></i> Admin
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold" style="color: #0d1b52;">Contact Us</h1>
            <p class="text-muted">We'd love to hear from you. Get in touch with us!</p>
        </div>

        <div class="row g-4">
            <div class="col-md-5">
                <div class="card contact-card p-4 h-100">
                    <h4 class="mb-4 fw-bold" style="color: #0d1b52;">Get In Touch</h4>
                    <div class="d-flex mb-4">
                        <div class="icon-box"><i class="fas fa-map-marker-alt"></i></div>
                        <div class="ms-3">
                            <h6 class="mb-0 fw-bold">Our Location</h6>
                            <small class="text-muted">ATI Badulla, Badulla, Sri Lanka</small>
                        </div>
                    </div>
                    <div class="d-flex mb-4">
                        <div class="icon-box"><i class="fas fa-envelope"></i></div>
                        <div class="ms-3">
                            <h6 class="mb-0 fw-bold">Email Us</h6>
                            <small class="text-muted">info@atibadulla.lk</small>
                        </div>
                    </div>
                    <div class="d-flex mb-4">
                        <div class="icon-box"><i class="fas fa-phone-alt"></i></div>
                        <div class="ms-3">
                            <h6 class="mb-0 fw-bold">Call Us</h6>
                            <small class="text-muted">+94 55 222 3344</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-7">
                <div class="card contact-card p-4">
                    <h4 class="mb-4 fw-bold" style="color: #0d1b52;">Send Message</h4>
                    <form>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <input type="text" class="form-control" placeholder="Your Name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <input type="email" class="form-control" placeholder="Your Email" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <input type="text" class="form-control" placeholder="Subject" required>
                        </div>
                        <div class="mb-3">
                            <textarea class="form-control" rows="5" placeholder="Your Message" required></textarea>
                        </div>
                        <button type="submit" class="btn text-white w-100 py-3 rounded-pill fw-bold" style="background-color: #0d1b52;">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-5">
        <div class="card contact-card overflow-hidden">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.551694263445!2d81.055!3d6.99!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNsKwNTknMjQuMCJOIDgxwrAwMycxOC4wIkU!5e0!3m2!1sen!2slk!4v1600000000000" 
            width="100%" height="300" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
        </div>
    </div>

    <footer class="py-4 text-center mt-5" style="background-color: #0d1b52; color: #c2c7d0;">
        <p class="m-0">&copy; 2026 ATI Badulla. All Rights Reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>