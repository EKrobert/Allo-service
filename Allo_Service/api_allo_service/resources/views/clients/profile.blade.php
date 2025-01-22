@extends('layout.master')
@section('content')
    <!-- Page Content  -->
    <section class="section profile">


        <div class="row">

            <div class="col-xl-12">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <div class="tab-content pt-2">

                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
        
                                <h5 class="card-title">Détails du client</h5>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">Nom complet</div>
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
                            </div>

                            <div>
                               <button type="reset" class="btn btn-primary"
                                    onclick="window.location.href='{{ route('clients.index') }}'">Retour</button>
                            </div>

                        </div><!-- End Bordered Tabs -->

                    </div>
                </div>

            </div>

            <div class="col-lg-8">



            </div>

        </div>


        </div>
    </section>
@endsection
