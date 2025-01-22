@extends('layout.master')
@section('content')
    <section class="section">
        <div class="row">
            <div class="card">
                <div class="col-lg-12">
                    <div class="iq-card">
                        <div class="iq-card-header d-flex justify-content-between align-items-center">
                            <div class="iq-header-title">
                                <h4 class="card-title">Liste des réservations</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div class="table-responsive">
                                <table id="user-list-table" class="table table-striped mt-4" role="grid"
                                    aria-describedby="user-list-page-info">
                                    <thead>
                                        <tr>
                                            <th>Client</th>
                                            <th>Prestataire</th>
                                            <th>Service</th>
                                            <th>Statut</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($reservations as $reservation)
                                            <tr>
                                                <td>{{ $reservation->client->user->firstname }} {{ $reservation->client->user->lastname }}</td> 
                                                <td>{{ $reservation->prestataire->user->firstname }} {{ $reservation->prestataire->user->lastname }}</td> 
                                                <td>{{ $reservation->service->name }}</td> 
                                                @if ($reservation->statut == 'en_attente')
                                                <td><span class="badge badge-warning">en_attente</span></td>
                                            @else
                                                <td><span class="badge badge-success">validé</span></td>
                                            @endif
                                                <td>
                                                    <div class="flex align-items-center">
                                                        <!-- Bouton pour voir les détails de la réservation -->
                                                        <a class="btn btn-outline-success btn-sm"
                                                            href="{{ route('reservations.show', $reservation->id) }}" data-toggle="tooltip"
                                                            title="Voir" data-original-title="View">
                                                            <i class="fa fa-eye"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection