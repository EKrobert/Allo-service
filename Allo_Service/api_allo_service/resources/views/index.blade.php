@extends('layout.master')
@section('content')
    <section class="section dashboard">
        <!-- Page Conten
                                                                                                                        <t  -->
        <div class="col-lg-12">
            <div class="row">

                <div class="col-xxl-4 col-md-6">
                    <a href="" class="card info-card sales-card">
                        <div class="card-body">
                            <h5 class="card-title">Nombre total de clients</h5>
                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-person-lines-fill"></i> <!-- Icône pour clients -->
                                </div>
                                <div class="ps-3">
                                    <h6>{{ $clients }}</h6>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-xxl-4 col-md-6">
                    <a href="" class="card info-card customers-card">
                        <div class="card-body">
                            <h5 class="card-title">Nombre total de prestataires</h5>
                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-person-badge"></i> <!-- Icône pour prestataires -->
                                </div>
                                <div class="ps-3">
                                    <h6>{{ $prestataires }}</h6>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-xxl-4 col-md-6">
                    <a href="" class="card info-card revenue-card">
                        <div class="card-body">
                            <h5 class="card-title">Nombre total de réservations</h5>
                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-calendar-check"></i> <!-- Icône pour réservations -->
                                </div>
                                <div class="ps-3">
                                    <h6>{{ $reservations }}</h6>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-xxl-4 col-md-6">
                    <a href="" class="card info-card sales-card">
                        <div class="card-body">
                            <h5 class="card-title">Nombre total de services</h5>
                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-tools"></i> <!-- Icône pour services -->
                                </div>
                                <div class="ps-3">
                                    <h6>{{ $services }}</h6>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>

            </div>
        </div>

    </section>
@endsection
