@can('admin')
    @extends('layout.master')
    @section('content')
        <!-- Page Content  -->
        <section class="section">
            <div class="row">
                <div class="card">
                    <div class="col-sm-12">
                        <div class="iq-card">
                            <div class="iq-card-header d-flex justify-content-between align-items-center">
                                <div class="iq-header-title">
                                    <h4 class="card-title">Liste des administrateurs</h4>
                                </div>
                                <a href="{{ route('admins.create') }}">
                                    <button type="submit" class="btn"
                                        style="background-color: #012960; color: white;">Ajouter</button></a>
                            </div>
                            <div class="iq-card-body">
                                <table id="user-list-table" class="table table-striped table-bordered mt-4" role="grid"
                                    aria-describedby="user-list-page-info">
                                    <thead>
                                        <tr>
                                            <th>Prénom</th>
                                            <th>Nom</th>
                                            <th>Nom Utilisateur</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @if ($admins->count() > 0)
                                            @foreach ($admins as $admin)
                                                <tr>
                                                    <td>{{ $admin->firstname }}</td>
                                                    <td>{{ $admin->lastname }}</td>
                                                    <td>{{ $admin->username }}</td>
                                                    <td>
                                                        <div class="flex align-items-center">
                                                            <a class="btn btn-outline-info btn-sm" data-toggle="tooltip"
                                                                data-placement="top" title="Modifier" data-original-title="Edit"
                                                                href="{{ route('admins.edit', $admin->id) }}"><i
                                                                    class="far fa-edit"></i></a>
                                                            <a class="btn btn-outline-success btn-sm" data-toggle="tooltip"
                                                                data-placement="top" title="Voir" data-original-title="View"
                                                                href="{{ route('admins.show', $admin->id) }}"><i
                                                                    class="fa fa-eye" aria-hidden="true"></i></a>
                                                            @if ($admin->state == 1)
                                                                <form class="d-inline" method="post"
                                                                    action="{{ route('admins.disable', $admin->id) }}">
                                                                    @csrf
                                                                    <input type="hidden" name="state" id="state-input"
                                                                        value="0">
                                                                    <button class="btn btn-outline-danger btn-sm disable-admin"
                                                                        data-admin-id="{{ $admin->id }}" title="Desactivé"
                                                                        data-toggle="tooltip" data-placement="top"
                                                                        data-original-title="Disable">
                                                                        <i class="fas fa-stop"></i>
                                                                    </button>
                                                                </form>
                                                            @else
                                                                <form class="d-inline" method="post"
                                                                    action="{{ route('admins.enable', $admin->id) }}">
                                                                    @csrf
                                                                    <input type="hidden" name="state" id="state-input-enable"
                                                                        value="1">
                                                                    <button type="submit"
                                                                        class="btn btn-outline-primary btn-sm enable-admin"
                                                                        data-admin-id="{{ $admin->id }}"
                                                                        data-toggle="tooltip" data-placement="top" title="Activé"
                                                                        data-original-title="Enable">
                                                                        <i class="fas fa-play"></i>
                                                                    </button>
                                                                </form>
                                                            @endif
                                                        </div>
                                                    </td>
                                                </tr>
                                            @endforeach
                                        @endif
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Script de désactivation -->
            <script>
                $(document).on('click', '.disable-admin', function(e) {
                    e.preventDefault();
                    var button = $(this);
                    var adminId = button.data('admin-id');

                    Swal.fire({
                        title: 'Are you sure?',
                        text: 'Do you want to disable this admin?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                type: 'POST',
                                url: '{{ route('admins.disable', ':id') }}'.replace(':id', adminId),
                                data: {
                                    _token: '{{ csrf_token() }}',
                                    id: adminId,
                                    state: $('#state-input').val()
                                },
                                success: function(response) {
                                    Swal.fire({
                                        title: 'Success',
                                        text: response.message,
                                        icon: 'success',
                                        timer: 2000,
                                        showConfirmButton: false,
                                    });
                                    
                                    location.reload();
                                },
                                error: function(xhr) {
                                    Swal.fire({
                                        title: 'Error',
                                        text: 'An error occurred while disabling the admin.',
                                        icon: 'error'
                                    });
                                }
                            });
                        }
                    });
                });
            </script>
            <!-- Script d'activation -->
            <script>
                $(document).on('click', '.enable-admin', function(e) {
                    e.preventDefault();
                    var button = $(this);
                    var adminId = button.data('admin-id');

                    Swal.fire({
                        title: 'Are you sure?',
                        text: 'Do you want to enable this admin?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                type: 'POST',
                                url: '{{ route('admins.enable', ':id') }}'.replace(':id', adminId),
                                data: {
                                    _token: '{{ csrf_token() }}',
                                    id: adminId,
                                    state: $('#state-input-enable').val()
                                },
                                success: function(response) {
                                    Swal.fire({
                                        title: 'Success',
                                        text: response.message,
                                        icon: 'success',
                                        timer: 2000,
                                        showConfirmButton: false,
                                    });

                                    // actualiser le tableau avec ajax
                                    // $('#admin-list-table').load(window.location.href + ' #admin-list-table');
                                    location.reload();
                                },
                                error: function(xhr) {
                                    Swal.fire({
                                        title: 'Error',
                                        text: 'An error occurred while enabling the admin.',
                                        icon: 'error'
                                    });
                                }
                            });
                        }
                    });
                });
            </script>
        </section>
    @endsection
@endcan
