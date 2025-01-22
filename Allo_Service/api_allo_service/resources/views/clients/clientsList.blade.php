@extends('layout.master')
@section('content')
    <section class="section">
        <div class="row">
            <div class="card">
                <div class="col-lg-12">
                    <div class="iq-card">
                        <div class="iq-card-header d-flex justify-content-between align-items-center">
                            <div class="iq-header-title">
                                <h4 class="card-title">Liste des clients</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div class="table-responsive">
                                <table id="user-list-table" class="table table-striped mt-4" role="grid"
                                    aria-describedby="user-list-page-info">
                                    <thead>
                                        <tr>
                                            <th>Nom</th>
                                            <th>Phone</th>
                                            <th>Email</th>
                                            {{-- <th>Statut</th> --}}
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($users as $user)
                                            <tr>
                                                <td>{{ $user->firstname }}  {{ $user->lastname }}</td>
                                                <td>{{ $user->phone }}</td>
                                                <td>{{ $user->email }}</td>
                                               
                                                <td>
                                                    <div class="flex align-items-center">
                                                        <a class="btn btn-outline-success btn-sm"
                                                            href="clients/{{ $user->id }}" data-toggle="tooltip"
                                                            title="Voir" data-original-title="View"><i
                                                                class="fa fa-eye"></i></a>
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
    </section>
@endsection
