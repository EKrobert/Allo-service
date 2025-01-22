<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>ALLO SERVICE</title>
        <meta content="" name="description">
        <meta content="" name="keywords">
        
        @include('layout._css');
        @stack('css')
    </head>

    <body>
        @include('layout.header')
        @include('layout.sidebar')

        <main id="main" class="main">
            @yield('content')
        </main>

        @stack('scripts')
    </body>

    @include('layout._scripts')
</html>