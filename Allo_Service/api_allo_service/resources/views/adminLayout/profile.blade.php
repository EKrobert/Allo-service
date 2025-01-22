@extends('layout.master')
@section('content')
    <!-- Page Content  -->
    <section class="section">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Profil</h5>

                    <!-- Bordered Tabs Justified -->
                    <ul class="nav nav-tabs nav-tabs-bordered d-flex" id="borderedTabJustified" role="tablist">
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab"
                                data-bs-target="#bordered-justified-home" type="button" role="tab" aria-controls="home"
                                aria-selected="true">Profil</button>
                        </li>
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab"
                                data-bs-target="#bordered-justified-profile" type="button" role="tab"
                                aria-controls="profile" aria-selected="false">Modifier</button>
                        </li>
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100" id="contact-tab" data-bs-toggle="tab"
                                data-bs-target="#bordered-justified-contact" type="button" role="tab"
                                aria-controls="contact" aria-selected="false">Changer de mot de passe</button>
                        </li>
                    </ul>
                    <div class="tab-content pt-4" id="borderedTabJustifiedContent">
                        <div class="tab-pane fade show active" id="bordered-justified-home" role="tabpanel"
                            aria-labelledby="home-tab">
                            <div class="new-user-info">
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="fname">Prénom:</label>
                                        <h5>{{ $admin->firstname }}</h5>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="lname">Nom:</label>
                                        <h5>{{ $admin->lastname }}</h5>
                                    </div>
                                </div>
                                <hr class="badge-primary mt-0">
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="uname">Nom d'utilisateur:</label>
                                        <h5>{{ $admin->username }}</h5>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="uname">Role:</label>
                                        @if ($admin->role == 0)
                                            <h5>Super admin</h5>
                                        @elseif ($admin->role == 1)
                                            <h5>Admin</h5>
                                        @else
                                            <h5>Role inconnu pour le moment</h5>
                                        @endif
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="bordered-justified-profile" role="tabpanel"
                            aria-labelledby="profile-tab">
                            <form action="{{ route('profile.update', $admin->id) }}" method="post">
                                @csrf
                                @method('put')
                                <div class="form-group col-md-12">
                                    <label for="fname">Prénom:</label>
                                    <input type="text" class="form-control" id="fname"
                                        value="{{ $admin->firstname }}" name="firstname" require>
                                    @error('firstname')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group col-md-12">
                                    <label for="lname">Nom:</label>
                                    <input type="text" class="form-control" id="lname" value="{{ $admin->lastname }}"
                                        name="lastname" required>
                                    @error('lastname')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group col-md-12">
                                    <label for="uname">Nom d'utilisateur:</label>
                                    <input type="text" class="form-control" id="uname" value="{{ $admin->username }}"
                                        require name="username">
                                    @error('username')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group col-md-12">
                                    <button type="submit" class="btn btn-primary">Modifier </button>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="bordered-justified-contact" role="tabpanel"
                            aria-labelledby="contact-tab">
                            <form action="{{ route('changepassword') }}" method="post">
                                @csrf
                                <div class="form-group">
                                    <label for="npass">Nouveau mot de passe:</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="npass" required
                                            name="newpassword">
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <span class="text-danger" id="password-error"></span>
                                    @error('newpassword')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                {{-- <div class="form-group">
                                    <label for="npass">Nouveau mot de passe:</label>
                                    <input type="Password" class="form-control" id="npass" required name="newpassword">
                                    @error('newpassword')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div> --}}
                                <div class="form-group">
                                    <label for="vpass">Confirmation :</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="vpass" required
                                            name="verifypassword">
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="button"
                                                id="toggleVerifyPassword">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <span class="text-danger" id="verify-password-error"></span>
                                    @error('verifypassword')
                                        <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary mr-2">Modifier</button>
                                </div>
                            </form>
                        </div>
                    </div><!-- End Bordered Tabs Justified -->
                </div>
            </div>
        </div>


        <script>
            const passwordInput = document.getElementById('npass');
            const passwordError = document.getElementById('password-error');
            const passwordErrorMessage =
                'Le mot de passe doit contenir une lettre majuscule,\n' +
                'une lettre minuscule,\n' +
                'un caractère spécial,\n' +
                'et avoir une longueur minimale de 8 caractères.';

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

            // Toggle password visibility
            const togglePasswordBtn = document.getElementById('togglePassword');
            togglePasswordBtn.addEventListener('click', function() {
                const passwordInput = document.getElementById('npass');
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
        <script>
            const verifyPasswordInput = document.getElementById('vpass');
            const verifyPasswordError = document.getElementById('verify-password-error');
            const newPasswordInput = document.getElementById('npass');

            verifyPasswordInput.addEventListener('input', function() {
                const verifyPassword = this.value;
                const newPassword = newPasswordInput.value;

                if (verifyPassword === newPassword) {
                    verifyPasswordError.innerHTML = '';
                } else {
                    verifyPasswordError.innerHTML = 'Les mots de passe ne correspondent pas.';
                }
            });

            // Toggle password visibility
            const toggleVerifyPasswordBtn = document.getElementById('toggleVerifyPassword');
            toggleVerifyPasswordBtn.addEventListener('click', function() {
                const verifyPasswordInput = document.getElementById('vpass');
                const eyeIcon = this.querySelector('i');

                if (verifyPasswordInput.type === 'password') {
                    verifyPasswordInput.type = 'text';
                    eyeIcon.classList.remove('fa-eye');
                    eyeIcon.classList.add('fa-eye-slash');
                } else {
                    verifyPasswordInput.type = 'password';
                    eyeIcon.classList.remove('fa-eye-slash');
                    eyeIcon.classList.add('fa-eye');
                }
            });
        </script>

    </section>
@endsection
