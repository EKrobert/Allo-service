@extends('layout.master')
@section('content')
    <section class="section">

        <div class="row">
            <div class="card">
                <div class="col-sm-12">
                    <div class="iq-card">
                        <div class="iq-card-header d-flex justify-content-between align-items-center">
                            <div class="iq-header-title">
                                <h4 class="card-title">Liste des services</h4>
                            </div>
                            <div>
                                <a href="{{ route('services.create') }}">
                                    <button type="submit" class="btn"
                                        style="background-color: #012960; color: white;">Ajouter</button>
                                </a>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div class="table-responsive">
                                <table id="user-list-table" class="table table-striped table-bordered mt-4" role="grid"
                                    aria-describedby="user-list-page-info">
                                    <thead>
                                        <tr>
                                            <th>Nom du service</th>
                                            {{-- <th>Actions</th> --}}
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($services as $service)
                                            <tr>
                                                <td>{{ $service->name }}</td>
                                                {{-- <td>
                                                    <div class="flex align-items-center">
                                                        <!-- <a class="iq-bg-primary" data-toggle="tooltip" data-placement="top" title="" data-original-title="Add" href="#"><i class="ri-user-add-line"></i></a> -->
                                                        <a class="btn btn-outline-info btn-sm" data-toggle="tooltip"
                                                            data-placement="top" title="Modifier" data-original-title="Edit"
                                                            href="{{ route('services.edit', $service->id) }}"><i
                                                                class="far fa-edit"></i></a>
                                                        <a class="btn btn-outline-success btn-sm" data-toggle="tooltip"
                                                            data-placement="top" title="Voir" data-original-title="View"
                                                            href="{{ route('services.show', $service->id) }}"><i
                                                                class="fa fa-eye" aria-hidden="true"></i></a>
                                                    
                                                            <form class="d-inline"
                                                                action="{{ route('services.destroy', $service->id) }}"
                                                                method="post">
                                                                @csrf
                                                                @method('DELETE')
                                                                <button class="btn btn-outline-danger btn-sm delete-button" title="Supprimer"
                                                                    style="display:inline" data-toggle="tooltip" 
                                                                    data-placement="top" data-original-title="Delete"
                                                                    type="submit"><i class="ri-delete-bin-line"></i></button>
                                                            </form>
                                                    </div>

                            </div>
                            </td> --}}
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
        <script>
            $('.delete-button').on('click', function(event) {
                event.preventDefault();
                var form = $(this).closest('form');
                Swal.fire({
                    text: 'Êtes-vous sûr de vouloir supprimer ?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Oui',
                    cancelButtonText: 'Annuler'
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });
        </script>
    </section>
@endsection
