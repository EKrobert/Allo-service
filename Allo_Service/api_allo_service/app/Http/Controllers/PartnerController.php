<?php

namespace App\Http\Controllers;

use App\Models\Prestataire;
use App\Models\User;
use Illuminate\Http\Request;

class PartnerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $users = User::where('role', 'provider')->get();
        return view('partners.partnersList', compact('users'));
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
    public function show(User $user)
    {
        // Charge les relations nécessaires
        $user->load('prestataire.services');

        // Extrait les données nécessaires
        $prestataire = $user->prestataire;
        $services = $prestataire ? $prestataire->services : collect(); // Utilise une collection vide si pas de prestataire

        // Passe les données à la vue
        return view('partners.profile', [
            'user' => $user,
            'prestataire' => $prestataire,
            'services' => $services,
        ]);
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
