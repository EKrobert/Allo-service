<?php

namespace App\Http\Controllers\Api\Provider;

use App\Http\Controllers\Controller;
use App\Models\Reservation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReservationController extends Controller
{
    public function index()
    {
        $provider = Auth::user()->prestataire;


        // Vérifier si le prestataire existe
        if (!$provider) {
            return response()->json([
                'success' => false,
                'message' => 'Prestataire non trouvé pour cet utilisateur.',
            ], 404);
        }

        // Récupérer toutes les réservations du prestataire
        $reservations = Reservation::with(['client', 'client.user', 'prestataire', 'prestataire.user', 'service'])
            ->where('prestataire_id', $provider->id) // Filtrer par l'ID du prestataire
            ->get();

        // Vérifier si le prestataire a des réservations
        if ($reservations->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Aucune réservation trouvée pour ce prestataire.',
            ], 404);
        }

        // Retourner les réservations du prestataire
        return response()->json([
            'success' => true,
            'data' => $reservations,
        ], 200);
    }

    public function details($id)
    {
        // Récupérer le prestataire authentifié
        $prestataire = Auth::user()->prestataire;

        // Vérifier si le prestataire est bien authentifié
        if (!$prestataire) {
            return response()->json(['message' => 'Prestataire non trouvé'], 404);
        }

        // Récupérer la réservation en fonction de l'ID et vérifier qu'elle appartient au prestataire
        $reservation = Reservation::where('id', $id)
            ->where('prestataire_id', $prestataire->id)
            ->with(['service', 'client.user', 'evaluation']) // Charger l'évaluation
            ->first();

        // Vérifier si la réservation existe
        if (!$reservation) {
            return response()->json(['message' => 'Réservation non trouvée'], 404);
        }

        // Retourner les détails de la réservation, y compris l'évaluation
        return response()->json([
            'reservation' => $reservation,
            'service' => $reservation->service,
            'client' => $reservation->client->user,
            'evaluation' => $reservation->evaluation, // Ajouter l'évaluation
        ], 200);
    }
    public function validateReservation($reservationId)
    {
        // Récupérer le prestataire authentifié
        $prestataire = Auth::user()->prestataire;

        // Trouver la réservation
        $reservation = Reservation::find($reservationId);

        // Vérifier si la réservation existe et appartient au prestataire
        if (!$reservation || $reservation->prestataire_id !== $prestataire->id) {
            return response()->json(['message' => 'Réservation non trouvée ou non autorisée'], 404);
        }

        // Vérifier si la réservation est déjà validée
        if ($reservation->statut === 'validé') {
            return response()->json(['message' => 'La réservation est déjà validée'], 400);
        }

        // Mettre à jour le statut de la réservation
        $reservation->statut = 'validé';
        $reservation->save();

        // Retourner une réponse de succès
        return response()->json(['message' => 'Réservation validée avec succès'], 200);
    }
}
