<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link collapsed" href="{{ url('/') }}">
                <i class="bi bi-grid"></i>
                <span>Tableau de bord</span>
            </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#country" data-bs-toggle="collapse" href="#">
                <i class="bi bi-tools"></i><span>Services</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="country" class="nav-content collapse {{ request()->routeIs('services.*') ? 'show' : '' }}"
                data-bs-parent="#sidebar-nav">
                <li>
                    <a href="{{ route('services.index') }}"
                        class="{{ request()->routeIs('services.index') ? 'active' : '' }}">
                        <i class="bi bi-circle"></i><span>Liste des services</span>
                    </a>
                </li>
                <li>
                    <a href="{{ route('services.create') }}"
                        class="{{ request()->routeIs('services.create') ? 'active' : '' }}">
                        <i class="bi bi-circle"></i><span>Ajouter un service</span>
                    </a>
                </li>
            </ul>
        </li>


        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-person"></i><span>Clients</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="components-nav" class="nav-content collapse @if (request()->is('clients*')) show @endif"
                data-bs-parent="#sidebar-nav">
                <li>
                    <a href="{{ route('clients.index') }}"
                        class="{{ request()->routeIs('clients.index') ? 'active' : '' }}">
                        <i class="bi bi-circle"></i><span>Liste des Clients</span>
                    </a>
                </li>
            </ul>
        </li>
        <!--users-->
        <li class="nav-item">
            <a class="nav-link collapsed @if (request()->is('users*')) active @endif" data-bs-target="#users"
                data-bs-toggle="collapse" href="#">
                <i class="bi bi-people"></i><span>Prestataires</span><i
                    class="bi bi-chevron-down ms-auto @if (request()->is('users*')) rotate180 @endif"></i>
            </a>
            <ul id="users" class="nav-content collapse @if (request()->is('users*')) show @endif"
                data-bs-parent="#sidebar-nav">
                <li>
                    <a href="{{ route('users.index') }}"
                        class="{{ request()->routeIs('users.index') ? 'active' : '' }}">
                        <i class="bi bi-circle"></i><span>Liste des prestataires</span>
                    </a>
                </li>

            </ul>
        </li>
        <!--End users-->
        <!--Reservation-->
        <li class="nav-item">
            <a class="nav-link collapsed @if (request()->is('reservations*')) active @endif" data-bs-target="#reservations"
                data-bs-toggle="collapse" href="#">
                <i class="bi bi-calendar-check"></i><span>Reservaions</span><i
                    class="bi bi-chevron-down ms-auto @if (request()->is('reservations*')) rotate180 @endif"></i>
            </a>
            <ul id="reservations" class="nav-content collapse @if (request()->is('reservations*')) show @endif"
                data-bs-parent="#sidebar-nav">
                <li>
                    <a href="{{ route('reservations.index') }}"
                        class="{{ request()->routeIs('reservations.index') ? 'active' : '' }}">
                        <i class="bi bi-circle"></i><span>Liste des reservations</span>
                    </a>
                </li>

            </ul>
        </li>
        <!--End reservations-->

    </ul>

</aside><!-- End Sidebar-->
