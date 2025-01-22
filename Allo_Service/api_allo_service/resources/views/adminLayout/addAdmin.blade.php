@can('admin')
    @extends('layout.master')
    @section('content')
        <!-- Page Content  -->
        <section class="section">
            <div id="content-page" class="content-page">
                <div class="container-fluid">
                    <div class="row">
                        <div class="card">
                            <div class="col-lg-12">
                                <div class="iq-card">
                                    <div class="iq-card-header d-flex justify-content-between">
                                        <div class="iq-header-title">
                                            <h4 class="card-title">
                                                Informations sur l'administarteur</h4>
                                        </div>
                                    </div>
                                    <div class="iq-card-body">
                                        <div class="new-user-info">
                                            <form action="{{ route('admins.store') }}" method="post">
                                                @csrf
                                                <div class="form-group col-md-12">
                                                    <label for="lname">Nom:</label>
                                                    <input type="text" class="form-control" id="lname" placeholder="Nom"
                                                        name="lastname" value="{{ old('lastname') }}"
                                                        pattern="^[A-Za-zÀ-ÖØ-öø-ÿ][A-Za-zÀ-ÖØ-öø-ÿ'’\- ]*$" required>
                                                    <span id="name-error" class="text-danger"></span>
                                                    @error('lastname')
                                                        <span class="text-danger">{{ $message }}</span>
                                                    @enderror
                                                </div>
                                                <div class="form-group col-md-12">
                                                    <label for="fname">Prénom:</label>
                                                    <input type="text" class="form-control" id="fname"
                                                        placeholder="Prénom" name="firstname" value="{{ old('firstname') }}"
                                                        pattern="^[A-Za-zÀ-ÖØ-öø-ÿ][A-Za-zÀ-ÖØ-öø-ÿ'’\- ]*$" required>
                                                    <span id="firstname-error" class="text-danger"></span>
                                                    @error('firstname')
                                                        <span class="text-danger">{{ $message }}</span>
                                                    @enderror
                                                </div>
                                                <div class="form-group col-md-12">
                                                    <label for="uname">Nom d'utilisateur:</label>
                                                    <input type="text" class="form-control" id="uname"
                                                        placeholder="nom utilisateur" name="username"
                                                        value="{{ old('username') }}" pattern="^[a-zA-Z0-9]{3,20}$" required>
                                                    @error('username')
                                                        <span class="text-danger">{{ $message }}</span>
                                                    @enderror
                                                    <span id="username-error" class="text-danger"></span>
                                                </div>
                                                <div class="form-group col-md-12">
                                                    <label for="rname">Role:</label>
                                                    <select class="form-control" type="select" id="rname" name="role"
                                                        required>
                                                        <option selected disabled value="">Selectionner</option>
                                                        <option value="1" {{ old('role') == '1' ? 'selected' : '' }}>
                                                            Admin
                                                        </option>
                                                        <option value="0" {{ old('role') == '0' ? 'selected' : '' }}>
                                                            Super admin
                                                        </option>
                                                    </select>
                                                    @error('role')
                                                        <span class="text-danger">{{ $message }}</span>
                                                    @enderror
                                                </div>
                                                <div class="form-group col-md-12">
                                                    <label for="pass">Mot de passe:</label>
                                                    <div class="input-group">
                                                        <input type="password" class="form-control" id="pass"
                                                            placeholder="" name="password" value="{{ old('password') }}"
                                                            required 
                                                            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).{8,}$">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-outline-secondary" type="button"
                                                                id="togglePassword">
                                                                <i id="eyeIcon" class="fa fa-eye"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    @error('password')
                                                        <span class="text-danger">{{ $message }}</span>
                                                    @enderror
                                                    <span class="text-danger" id="password-error"></span>
                                                </div> <br>
                                                <div class="form-group col-md-12">
                                                    <button type="submit" class="btn btn-primary mr-3">Enregistrer</button>
                                                    <button type="reset" class="btn btn-secondary"
                                                        onclick="window.location.href='{{ route('admins.index') }}'">Annuler</button>
                                                </div>
                                            </form>
                                            <br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    const passwordInput = document.getElementById('pass');
                    const passwordError = document.getElementById('password-error');
                    const passwordErrorMessage =
                        'Le mot de passe doit contenir une lettre majuscule,\n' +
                        'une lettre minuscule,\n' +
                        'un chiffre,\n' +
                        'un caractère spécial,\n' +
                        'et avoir une longueur minimale de 8 caractères.';
                
                    passwordInput.addEventListener('input', function() {
                        const password = this.value;
                        const hasLowercaseLetter = /[a-z]/.test(password);
                        const hasUppercaseLetter = /[A-Z]/.test(password);
                        const hasNumber = /\d/.test(password);
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
                            if (!hasNumber) passwordError.innerHTML +=
                                '<span>Le mot de passe doit contenir un chiffre.</span><br>';
                            if (!hasSpecialCharacter) passwordError.innerHTML +=
                                '<span>Le mot de passe doit contenir un caractère spécial.</span><br>';
                            if (!isValidLength) passwordError.innerHTML +=
                                '<span>Le mot de passe doit avoir une longueur minimale de 8 caractères.</span><br>';
                        }
                    });
                
                    // Toggle password visibility
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
                <script>
                    const usernameInput = document.getElementById('uname');
                    const usernameError = document.getElementById('username-error');
                    const usernameErrorMessage = 'Le nom d\'utilisateur doit contenir entre 3 et 20 caractères alphanumériques.';

                    usernameInput.addEventListener('input', function() {
                        const username = this.value;
                        const isValidUsername = /^[a-zA-Z0-9]{3,20}$/.test(username);

                        if (username === '') {
                            usernameError.innerHTML = '';
                        } else {
                            if (isValidUsername) {
                                usernameError.innerHTML = '';
                            } else {
                                usernameError.innerHTML = usernameErrorMessage;
                            }
                        }
                    });
                </script>
                <script>
                    const firstNameInput = document.getElementById('fname');
                    const firstNameError = document.getElementById('firstname-error');
                    const firstNameErrorMessage =
                        'Le prénom doit commencer par une lettre et peut contenir des lettres, des espaces, des tirets, des apostrophes et des caractères accentués.';

                    firstNameInput.addEventListener('input', function() {
                        const firstName = this.value;
                        const isValidFirstName = /^[A-Za-zÀ-ÖØ-öø-ÿ][A-Za-zÀ-ÖØ-öø-ÿ'’\- ]*$/.test(firstName);

                        if (firstName === '') {
                            firstNameError.innerHTML = '';
                        } else {
                            if (isValidFirstName) {
                                firstNameError.innerHTML = '';
                            } else {
                                firstNameError.innerHTML = firstNameErrorMessage;
                            }
                        }
                    });
                </script>
                <script>
                    const lastNameInput = document.getElementById('lname');
                    const lastNameError = document.getElementById('name-error');
                    const lastNameErrorMessage =
                        'Le nom doit commencer par une lettre et peut contenir des lettres, des espaces, des tirets, des apostrophes et des caractères accentués.';

                    lastNameInput.addEventListener('input', function() {
                        const lastName = this.value;
                        const isValidLastName = /^[A-Za-zÀ-ÖØ-öø-ÿ][A-Za-zÀ-ÖØ-öø-ÿ'’\- ]*$/.test(lastName);

                        if (lastName === '') {
                            lastNameError.innerHTML = '';
                        } else {
                            if (isValidLastName) {
                                lastNameError.innerHTML = '';
                            } else {
                                lastNameError.innerHTML = lastNameErrorMessage;
                            }
                        }
                    });
                </script>
            </div>
        </section>
    @endsection
@endcan
