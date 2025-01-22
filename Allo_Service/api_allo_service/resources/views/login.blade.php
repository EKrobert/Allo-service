<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Login</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="{{ asset('assets/partnerassets/img/favicon.png') }}" rel="icon">
    <link href="{{ asset('assets/partnerassets/img/apple-touch-icon.png') }}" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link
        href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
        rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>

    <style>
        .input-group-text i {
            pointer-events: none;
        }
    </style>
    <!-- Vendor CSS Files -->
    <link href="{{ asset('assets/partnerassets/vendor/bootstrap/css/bootstrap.min.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/partnerassets/vendor/bootstrap-icons/bootstrap-icons.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/partnerassets/vendor/boxicons/css/boxicons.min.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/partnerassets/vendor/quill/quill.snow.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/partnerassets/vendor/quill/quill.bubble.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/partnerassets/vendor/remixicon/remixicon.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/partnerassets/vendor/simple-datatables/style.css') }}" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


    <!-- Template Main CSS File -->
    <link href="{{ asset('assets/partnerassets/css/style.css') }}" rel="stylesheet">

    <!-- =======================================================
  * Template Name: NiceAdmin - v2.5.0
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

    <main>
        <div class="container">

            <section
                class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                            <div class="d-flex justify-content-center py-4">
                                <a href="index.html" class="logo d-flex align-items-center w-auto">
                                    <img src="{{ asset('assets/partnerassets/img/logo.png') }}" alt="">
                                    <span class="d-none d-lg-block">Allo service</span>
                                </a>
                            </div><!-- End Logo -->

                            <div class="card mb-3">

                                <div class="card-body">

                                    <div class="pt-4 pb-2">
                                        <h5 class="card-title text-center pb-0 fs-4">Se connecter</h5>
                                        <p class="text-center small">Entrez votre nom d'utilisateur et votre mot de
                                            passe</p>
                                    </div>

                                    <form id="formAuthentication" class="row g-3" action="/login_admin" method="post">
                                        @if (Session::has('error'))
                                            <div class="alert alert-danger">{{ Session::get('error') }}</div>
                                        @endif
                                        @if (Session::has('fail'))
                                            <div class="alert alert-danger">"{{ Session::get('fail') }}"</div>
                                        @endif
                                        @csrf
                                        <div class="col-12">
                                            <label for="username" class="form-label">Nom d'utilisateur</label>
                                            <div class="input-group has-validation">
                                                <input type="text" name="username" class="form-control"
                                                    id="username" value="{{ old('username') }}"
                                                    placeholder="Enter your username" autofocus required
                                                    pattern="^[a-zA-Z0-9]{5,20}$">
                                                <div class="invalid-feedback">Nom d'utilisateur</div>
                                            </div>
                                        </div>

                                        <div class="col-12 mb-2">
                                            <label for="pass">Mot de passe:</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="pass"
                                                    placeholder="" name="password" value="{{ old('password') }}"
                                                    required>
                                                <div class="input-group-append">
                                                    <button class="btn btn-outline-secondary" type="button"
                                                        id="togglePassword">
                                                        <i id="eyeIcon" class="fa fa-eye"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="invalid-feedback">Entrez votre mot de passe</div>
                                        </div>

                                        <div class="col-12">
                                            <button class="btn btn-primary w-100" type="submit">Se connecter</button>
                                        </div>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
        </div>

        </section>

        </div>
    </main><!-- End #main -->

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
            class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <script src="{{ asset('assets/partnerassets/vendor/apexcharts/apexcharts.min.js') }}"></script>
    <script src="{{ asset('assets/partnerassets/vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
    <script src="{{ asset('assets/partnerassets/vendor/chart.js/chart.umd.js') }}"></script>
    <script src="{{ asset('assets/partnerassets/vendor/echarts/echarts.min.js') }}"></script>
    <script src="{{ asset('assets/partnerassets/vendor/quill/quill.min.js') }}"></script>
    <script src="{{ asset('assets/partnerassets/vendor/simple-datatables/simple-datatables.js') }}"></script>
    <script src="{{ asset('assets/partnerassets/vendor/tinymce/tinymce.min.js') }}"></script>
    <script src="{{ asset('assets/partnerassets/vendor/php-email-form/validate.js') }}"></script>


    <script>
        const passwordInput = document.getElementById('pass');
        const passwordError = document.getElementById('password-error');

        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const hasLowercaseLetter = /[a-z]/.test(password);
            const hasUppercaseLetter = /[A-Z]/.test(password);
            const hasSpecialCharacter = /[_\W]/.test(password);
            const isValidLength = password.length >= 8;

            if (password === '') {
                passwordError.innerHTML = '';
            } else {
                passwordError.innerHTML = '';

                if (!hasLowercaseLetter) passwordError.innerHTML +=
                    '<span>Le mot de passe doit contenir une lettre minuscule.</span><br>';
                if (!hasUppercaseLetter) passwordError.innerHTML +=
                    '<span>Le mot de passe doit contenir une lettre majuscule.</span><br>';
                if (!hasSpecialCharacter) passwordError.innerHTML +=
                    '<span>Le mot de passe doit contenir un caractère spécial.</span><br>';
                if (!isValidLength) passwordError.innerHTML +=
                    '<span>Le mot de passe doit avoir une longueur minimale de 8 caractères.</span><br>';
            }
        });

        const togglePasswordBtn = document.getElementById('togglePassword');
        togglePasswordBtn.addEventListener('click', function() {
            const passwordInput = document.getElementById('pass');
            const eyeIcon = document.getElementById('eyeIcon');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        });
    </script>

</body>

</html>
