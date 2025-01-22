@can('admin')
    @extends('layout.master')
    @section('content')
        <!-- Page Content -->
        <section class="section">
            <!-- Default Card -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Informations administrateur</h5>
                    <div class="iq-card-body">
                        <div class="new-user-info">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label for="fname">Prénom:</label>
                                    <h5>{{ $admin->firstname }}</h5>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lname">Nom:</label>
                                    <h5>{{ $admin->lastname }}</h5>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label for="uname">Nom utilisateur:</label>
                                    <h5>{{ $admin->username }}</h5>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="uname">Role:</label>
                                    @if ($admin->role == 0)
                                        <h5>Super Admin</h5>
                                    @elseif ($admin->role == 1)
                                        <h5>Admin</h5>
                                    @else
                                        <h5>Role inconnu pour le moment</h5>
                                    @endif
                                </div>
                                <div class="form-group col-md-6">
                                    <a href="{{ route('admins.index') }}">
                                        <button type="submit" class="btn btn-primary">Retour</button>
                                    </a>
                                    <a class="btn btn-outline-info btn-sm" data-toggle="tooltip" data-placement="top"
                                        title="Modifier" data-original-title="Edit"
                                        href="{{ route('admins.edit', $admin->id) }}"><i class="far fa-edit"></i></a>
                                    @can('admin')
                                        <form class="d-inline" action="{{ route('admins.destroy', $admin->id) }}" method="post">
                                            @csrf
                                            @method('DELETE')
                                            <button class="btn btn-outline-danger btn-sm delete-button" style="display:inline" title="Supprimrer"
                                                data-original-title="Delete" type="submit"><i
                                                    class="ri-delete-bin-line"></i></button>
                                        </form>
                                    @endcan
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
@endcan
