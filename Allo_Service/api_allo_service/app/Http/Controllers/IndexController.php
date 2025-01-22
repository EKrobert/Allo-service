<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Prestataire;
use App\Models\Reservation;
use App\Models\Service;
use Illuminate\Http\Request;

class IndexController extends Controller
{

    public function index()
    {
        $clients = Client::count();
        $prestataires = Prestataire::count();
        $services =Service::count();
        $reservations = Reservation::count();
        return view('index', compact('clients', 'prestataires', 'services', 'reservations'));
    }
}
