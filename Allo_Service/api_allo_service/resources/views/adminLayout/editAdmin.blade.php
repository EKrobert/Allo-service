@can('admin')
    @extends('layout.master')
    @section('content')
        <!-- Page Content  -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">
                    Modification des informations de l'administrateur</h5>

                <!-- Bordered Tabs Justified -->
                <ul class="nav nav-tabs nav-tabs-bordered d-flex" id="borderedTabJustified" role="tablist">
                    <li class="nav-item flex-fill" role="presentation">
                        <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab"
                            data-bs-target="#bordered-justified-home" type="button" role="tab" aria-controls="home"
                            aria-selected="true">Information personnel</button>
                    </li>
                    <li class="nav-item flex-fill" role="presentation">
                        <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab"
                            data-bs-target="#bordered-justified-profile" type="button" role="tab" aria-controls="profile"
                            aria-selected="false">Changer de mot de passe</button>
                    </li>

                </ul>
                <div class="tab-content pt-4" id="borderedTabJustifiedContent">
                    <div class="tab-pane fade show active" id="bordered-justified-home" role="tabpanel"
                        aria-labelledby="home-tab">
                        <div class="iq-card">
                            <div class="iq-card-body">
                                <form action="{{ route('admins.update', $admin->id) }}" method="post">
                                    @csrf
                                    @method('put')
                                    <div class="form-group col-md-12">
                                        <label for="lname">Nom:</label>
                                        <input type="text" class="form-control" id="lname" value="{{ $admin->lastname }}"
                                            name="lastname" required>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="fname">Prénom:</label>
                                        <input type="text" class="form-control" id="fname"
                                            value="{{ $admin->firstname }}" name="firstname" required>
                                        @error('firstname')
                                            <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="uname">Nom utilisateur:</label>
                                        <input type="text" class="form-control" id="uname" value="{{ $admin->username }}"
                                            required name="username">
                                        @error('username')
                                            <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="rpass">Role:</label>
                                        <select class="form-control" type="select" name="role">
                                            <!-- <option value="{{ $admin->role }}"></option> -->
                                            <option value="1" {{ $admin->role == '1' ? 'selected' : '' }}> Admin
                                            </option>
                                            <option value="0" {{ $admin->role == '0' ? 'selected' : '' }}> Super admin
                                            </option>
                                        </select>
                                    </div>
                                    <br>
                                    <div class="form-group col-md-12">
                                        <button type="submit" class="btn btn-primary mr-3">Modifier</button>
                                        <button type="reset" class="btn btn-secondary"
                                            onclick="window.location.href='{{ route('admins.index') }}'">Annuler</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="bordered-justified-profile" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="iq-card">
                            <div class="iq-card-body">
                                <form action="{{ route('updatepassword', $admin->id) }}" method="post">
                                    @csrf
                                    <div class="form-group">
                                        <label for="npass">Nouveau mot de passe:</label>
                                        <input type="Password" class="form-control" id="npass" value=""
                                            name="newpassword" required>
                                        @error('newpassword')
                                            <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <div class="form-group">
                                        <label for="vpass">Cofirmation:</label>
                                        <input type="Password" class="form-control" id="vpass" value=""
                                            name="verifypassword" required>
                                        @error('verifypassword')
                                            <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <br>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary mr-3">Modifier</button>
                                        <button type="reset" class="btn btn-secondary"
                                            onclick="window.location.href='{{ route('admins.index') }}'">Annuler</button>
                                    </div>

                                </form>
                            </div>

                        </div>

                    </div><!-- End Bordered Tabs Justified -->
                </div>
            </div>
        </div>
    @endsection
@endcan
