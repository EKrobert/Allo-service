<?php

namespace App\Http\Controllers\Api\Client;

use App\Http\Controllers\Controller;
use App\Models\Reservation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class ReservationController extends Controller
{

    public function index()
    {
        $client = Auth::user()->client;

        if (!$client) {
            return response()->json([
                'success' => false,
                'message' => 'Client non trouvé pour cet utilisateur.',
            ], 404);
        }

        // Récupérer toutes les réservations du client
        $reservations = Reservation::with(['client.user', 'client', 'prestataire', 'prestataire.user', 'service'])
            ->where('client_id', $client->id) // Filtrer par l'ID du client
            ->get();

        // Vérifier si le client a des réservations
        if ($reservations->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Aucune réservation trouvée pour ce client.',
            ], 404);
        }

        // Retourner les réservations du client
        return response()->json([
            'success' => true,
            'data' => $reservations,
        ], 200);
    }


    public function store(Request $request)
    {
        // Récupérer l'utilisateur authentifié
        $user = Auth::user();
        // Valider les données entrantes
        $validator = Validator::make($request->all(), [
            'prestataire_id' => 'required|exists:prestataires,id',
            'service_id' => 'required|exists:services,id',
            'reservation_date' => 'required|date|after_or_equal:today', // Date uniquement
            'commentaire' => 'nullable|string',
            'adresse' => 'required|string',
        ]);

        // Si la validation échoue, retourner une réponse d'erreur
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Créer la réservation
        $reservation = Reservation::create([
            'client_id' => $user->client->id,
            'prestataire_id' => $request->prestataire_id,
            'service_id' => $request->service_id,
            'reservation_date' => $request->reservation_date, // Format Y-m-d
            'statut' => 'en_attente', // Statut par défaut
            'commentaire' => $request->commentaire,
            'adresse' => $request->adresse,
        ]);

        // Retourner une réponse de succès
        return response()->json([
            'success' => true,
            'message' => 'Réservation créée avec succès.',
            'data' => $reservation,
        ], 201);
    }



    public function details($id)
    {
        // Récupérer le client authentifié
        $client = Auth::user()->client;

        // Vérifier si le client est bien authentifié
        if (!$client) {
            return response()->json(['message' => 'Client non trouvé'], 404);
        }

        // Récupérer la réservation en fonction de l'ID et vérifier qu'elle appartient au client
        $reservation = Reservation::where('id', $id)
            ->where('client_id', $client->id)
            ->with(['service', 'prestataire.user', 'evaluation']) // Charger l'évaluation
            ->first();

        // Vérifier si la réservation existe
        if (!$reservation) {
            return response()->json(['message' => 'Réservation non trouvée'], 404);
        }

        // Récupérer le prix du service pour ce prestataire
        $price = $reservation->prestataire->services()
            ->where('services.id', $reservation->service_id)
            ->first()
            ->pivot
            ->prix;

        // Retourner les détails de la réservation, y compris l'évaluation
        return response()->json([
            'reservation' => $reservation,
            'service' => $reservation->service,
            'prestataire' => $reservation->prestataire->user,
            'prix' => $price,
            'evaluation' => $reservation->evaluation, // Ajouter l'évaluation
        ], 200);
    }
}
