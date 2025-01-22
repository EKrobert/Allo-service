@extends('layout.master')
@section('content')
    <section class="section">
        <style>
            .upload-label {
                position: relative;
                display: inline-block;
                cursor: pointer;
            }

            .upload-text {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: white;
                font-weight: bold;
                text-align: center;
                background-color: rgba(0, 0, 0, 0.5);
                padding: 10px;
                pointer-events: none;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .upload-label:hover .upload-text {
                opacity: 1;
            }
        </style>
        <div class="card mb-3">
            <div class="row g-0">


                <form action="{{ route('services.store') }}" method="post">
                    @csrf
                    @method('post')

                    <div class="col-md-12">
                        <div class="card-body">
                            <h5 class="card-title">Ajouter un service</h5>
                            <div class="iq-card">
                                <div class="iq-card-body">
                                    <div class="form-group">
                                        <label for="name">Titre:</label>
                                        <input type="text" class="form-control" id="name" name="name"
                                            minlength="2" maxlength="50" pattern="^[A-Za-zÀ-ÿ\s'\-]+$"
                                            title="Caractères alphabétiques uniquement, y compris les caractères spéciaux tels que é, ï, à, ÿ, ', -, et espace"
                                            required>
                                    </div>

                                    <div class="form-group">
                                        <label for="des">Description:</label>
                                        <input type="text" class="form-control" id="des" name="description">
                                    </div>

                                    <div class="form-group col-md-12">
                                        <button type="submit" class="btn btn-primary mr-3">Enregistrer</button>
                                        <button type="reset" class="btn btn-secondary"
                                            onclick="window.location.href='{{ route('services.index') }}'">Annuler</button>
                                    </div>
                </form>
            </div>
        </div>
        </div>
        </div>

        <script>
            $(document).ready(function() {
                $('#image-upload').on('change', function(e) {
                    var file = e.target.files[0];
                    if (file) {
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            $('#flag-preview').attr('src', e.target.result);
                            $('#image-error').hide();
                        };
                        reader.readAsDataURL(file);
                    } else {
                        $('#flag-preview').attr('src', '{{ asset('assets/images/default-image.png') }}');
                        $('#image-error').show();
                    }
                });
            });
        </script>
        </div>
    </section>
@endsection

{{-- 
@extends('layout.master')
@section('content')
    <section class="section">
        <div class="card">
            <style>
                .upload-label {
                    position: relative;
                    display: inline-block;
                    cursor: pointer;
                }
    
                .upload-text {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    color: white;
                    font-weight: bold;
                    text-align: center;
                    background-color: rgba(0, 0, 0, 0.5);
                    padding: 10px;
                    pointer-events: none;
                    opacity: 0;
                    transition: opacity 0.3s ease;
                }
    
                .upload-label:hover .upload-text {
                    opacity: 1;
                }
            </style>
            <!-- Page Content  -->
            <div id="content-page" class="content-page">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <!-- debut -->
                            <div class="iq-card">
                                <div class="iq-card-header d-flex justify-content-between">
                                    <div class="iq-header-title">
                                        <h4 class="card-title">Ajouter une nouveau  service</h4>
                                    </div>
                                </div>
                                <div class="iq-card-body">
                                    <form action="{{ route('services.store') }}" method="post"
                                        enctype='multipart/form-data'>
                                        @csrf
                                        

                                        <div class="user-detail text-center">
                                            <div class="user-profile">
                                                <label for="image-upload" class="upload-label">
                                                    <img class="img-fluid justify-content-center mt-2 ml-2 border" id="gift-preview"
                                                        src="{{ asset('assets/defaultvideo/pagecategorie.jpg') }}"
                                                        style="height: 400px;" alt="Default Image">
                                                    <span class="upload-text">Télécharger une image</span>
                                                </label>
                                                <input type="file" accept="image/*" id="image-upload" name="picture" value="{{ old('image') }}" style="display: none;" required>
                                            </div>
                                        </div>

                                        <div class="form-group col-md-12">
                                            <label for="turl">Name:</label>
                                            <input type="text" class="form-control" id="turl"
                                                placeholder="name"name="name" value="{{ old('name') }}" required>
                                            @error('name')
                                                <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <div class="form-group col-md-12">
                                            <button type="submit" class="btn btn-primary mr-3">Enregistrer</button>
                                            <button type="reset" class="btn btn-secondary"
                                                onclick="window.location.href='{{ route('services.index') }}'">Annuler</button>
                                        </div>
                                    </form>
                                </div>

                                <script>
                                    $(document).ready(function() {
                                        $('#image-upload').on('change', function(e) {
                                            var file = e.target.files[0];
                                            if (file) {
                                                var reader = new FileReader();
                                                reader.onload = function(e) {
                                                    $('#gift-preview').attr('src', e.target.result);
                                                };
                                                reader.readAsDataURL(file);
                                            }
                                        });
                                    });
                                </script>

                                <!-- fin -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection --}}
