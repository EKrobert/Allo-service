<?php

namespace App\Http\Controllers;

use App\Models\Reservation;
use Illuminate\Http\Request;

class ReservationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        $reservations = Reservation::getAllReservations();
        return view('reservations.index', compact('reservations'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Reservation $reservation)
    {
        // Charge les relations nécessaires
        $reservation->load(['client', 'prestataire', 'service']);
    
        // Extrait les données nécessaires
        $client = $reservation->client; // Détails du client
        $prestataire = $reservation->prestataire; // Détails du prestataire
        $service = $reservation->service; // Détails du service
    
        // Récupère le prix du service pour ce prestataire
        $price = $prestataire->services->find($service->id)->pivot->prix;
    
        // Passe les données à la vue
        return view('reservations.details', compact('reservation', 'client', 'prestataire', 'service', 'price'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
