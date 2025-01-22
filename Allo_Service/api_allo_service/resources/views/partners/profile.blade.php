@extends('layout.master')
@section('content')
    <!-- Page Content  -->
    <section class="section profile">


        <div class="row">
            <div class="col-xl-12">
                <div class="card">
                    <div class="cover-container">
                        @if (isset($user) && $user->filename != null)
                            <img src="{{ asset('storage/cover/' . $user->filename) }}" alt="profile-bg" height="325"
                                class="rounded" width="990">
                        @else
                            <img src="{{ asset('assets/images/page-img/profile-bg.jpg') }}" alt="profile-bg"
                                class="rounded img-fluid">
                        @endif
                        <ul class="header-nav d-flex flex-wrap justify-end p-0 m-0">
                            <li><a href="javascript:void();"><i class="ri-settings-4-line"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">

            <div class="col-xl-8">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <div class="tab-content pt-2">

                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
        
                                <h5 class="card-title">Détails du prestataire</h5>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">Nom</div>
                                    <div class="col-lg-9 col-md-8">{{ $user->firstname }} {{ $user->lastname }}</div>
                                </div>

                            
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">Email</div>
                                    <div class="col-lg-9 col-md-8">{{ $user->email }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">Username</div>
                                    <div class="col-lg-9 col-md-8">{{ $user->username }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Phone</div>
                                    <div class="col-lg-9 col-md-8">{{ $user->phone }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Services</div>
                                    <div class="col-lg-9 col-md-8">
                                        @if ($prestataire && $services->isNotEmpty())
                                            <ul>
                                                @foreach ($services as $service)
                                                    <li>
                                                        {{ $service->name }} - {{ $service->pivot->prix }} MAD
                                                    </li>
                                                @endforeach
                                            </ul>
                                        @else
                                            <p>Aucun service disponible.</p>
                                        @endif
                                    </div>
                                </div>
                               
                               
                            </div>

                            <div>
                                <button type="reset" class="btn btn-primary"
                                    onclick="window.location.href='{{ route('users.index') }}'">Retour</button>
                            </div>

                        </div><!-- End Bordered Tabs -->

                    </div>
                </div>

            </div>

            <div class="col-lg-8">



            </div>

        </div>


        </div>
        <script>
            function previewImage(event) {
                const input = event.target;
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('preview-logo').setAttribute('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
       
       
    </section>
@endsection
