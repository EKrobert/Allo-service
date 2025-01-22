<?php

namespace App\Http\Controllers\Api\Client;

use App\Http\Controllers\Controller;
use App\Models\Service;
use Illuminate\Http\Request;

class ServiceController extends Controller
{
    public function index()
    {
        // Récupérer tous les services avec leurs prestataires et les utilisateurs associés
        $servicesPrestataires = Service::with(['prestataires.user'])->get();
        $services = Service::all(); //tous les services
        return response()->json([
            'success' => true,
            'message' => 'Services et prestataire récupérés avec succès',
            'data' =>[
                'services' => $services,
                'prestataire' => $servicesPrestataires,
            ] 
        ], 200);
        
    }
}
