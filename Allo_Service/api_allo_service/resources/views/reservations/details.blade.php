@extends('layout.master')

@section('content')
    <section class="section">
        <div class="row">
            <div class="card">
                <div class="col-lg-12">
                    <div class="iq-card">
                        <div class="iq-card-header d-flex justify-content-between align-items-center">
                            <div class="iq-header-title">
                                <h4 class="card-title">Détails de la réservation #{{ $reservation->id }}</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div class="row">
                                <!-- Informations du client -->
                                <div class="col-md-6">
                                    <h5>Informations du client</h5>
                                    <ul class="list-group">
                                        <li class="list-group-item"><strong>Nom :</strong> {{ $client->user->firstname }} {{ $client->user->lastname }}</li>
                                        <li class="list-group-item"><strong>Email :</strong> {{ $client->user->email }}</li>
                                        <li class="list-group-item"><strong>Téléphone :</strong> {{ $client->user->phone }}</li>
                                    </ul>
                                </div>

                                <!-- Informations du prestataire -->
                                <div class="col-md-6">
                                    <h5>Informations du prestataire</h5>
                                    <ul class="list-group">
                                        <li class="list-group-item"><strong>Nom :</strong> {{ $prestataire->user->firstname }} {{ $prestataire->user->lastname }}</li>
                                        <li class="list-group-item"><strong>Email :</strong> {{ $prestataire->user->email }}</li>
                                        <li class="list-group-item"><strong>Téléphone :</strong> {{ $prestataire->user->phone }}</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <!-- Informations du service -->
                                <div class="col-md-6">
                                    <h5>Informations du service</h5>
                                    <ul class="list-group">
                                        <li class="list-group-item"><strong>Nom :</strong> {{ $service->name }}</li>
                                        <li class="list-group-item"><strong>Description :</strong> {{ $service->description }}</li>
                                        <li class="list-group-item"><strong>Prix :</strong> {{ $price }} MAD</li>
                                    </ul>
                                </div>

                                <!-- Informations de la réservation -->
                                <div class="col-md-6">
                                    <h5>Informations de la réservation</h5>
                                    <ul class="list-group">
                                        <li class="list-group-item"><strong>Statut :</strong> 
                                            @if ($reservation->statut === 'en_attente')
                                            <span class="badge badge-warning">En attente</span>
                                        @elseif ($reservation->statut === 'validé')
                                            <span class="badge badge-success">Validé</span>
                                        @else
                                            <span class="badge badge-secondary">{{ $reservation->statut }}</span>
                                        @endif
                                        </li>
                                        <li class="list-group-item"><strong>Date de réservation :</strong> {{ $reservation->reservation_date }}</li>
                                        <li class="list-group-item"><strong>Adresse :</strong> {{ $reservation->adresse }}</li>
                                    </ul>
                                </div>
                            </div>

                            <!-- Bouton de retour -->
                            <div class="mt-4">
                                <a href="{{ route('reservations.index') }}" class="btn btn-primary">
                                    <i class="fa fa-arrow-left"></i> Retour à la liste
                                </a>
                            </div>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection