<?php

namespace App\Http\Controllers\Api\Provider;

use App\Http\Controllers\Controller;
use App\Models\Prestataire;
use App\Models\PrestataireService;
use App\Models\Service;
use Exception;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use NunoMaduro\Collision\Provider;

class ServiceController extends Controller
{
    // public function index()
    // {
    //     try {
    //         // Récupérer l'utilisateur connecté
    //         $user = Auth::user();

    //         // Vérifier si l'utilisateur est un prestataire
    //         if (!$user || !$user->prestataire) {
    //             return response()->json([
    //                 'success' => false,
    //                 'message' => 'Utilisateur non trouvé ou non prestataire.',
    //             ], 404);
    //         }

    //         // Récupérer le prestataire associé à l'utilisateur
    //         $prestataire = $user->prestataire;

    //         // Récupérer les IDs des services auxquels le prestataire est déjà abonné
    //         $subscribedServiceIds = $prestataire->services()->pluck('services.id');

    //         // Récupérer tous les services disponibles
    //         $allServices = Service::all();

    //         // Filtrer les services non abonnés
    //         $unsubscribedServices = $allServices->reject(function ($service) use ($subscribedServiceIds) {
    //             return $subscribedServiceIds->contains($service->id);
    //         });

    //         // Vérifier s'il y a des services non abonnés
    //         if ($unsubscribedServices->isEmpty()) {
    //             return response()->json([
    //                 'success' => true,
    //                 'message' => 'Le prestataire est abonné à tous les services disponibles.',
    //                 'data' => [],
    //             ], 200);
    //         }

    //         // Retourner les services non abonnés
    //         return response()->json([
    //             'success' => true,
    //             'message' => 'Services non abonnés récupérés avec succès.',
    //             'data' => $unsubscribedServices,
    //         ], 200);
    //     } catch (ModelNotFoundException $e) {
    //         // Gestion spécifique pour les erreurs de modèle (si un service est introuvable)
    //         return response()->json([
    //             'error' => 'Aucun service trouvé.',
    //             'message' => $e->getMessage(),
    //         ], 404);
    //     } catch (Exception $e) {
    //         // Gestion des erreurs générales
    //         return response()->json([
    //             'error' => 'Une erreur est survenue lors de la récupération des services.',
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }


    public function index()
    {
        try {
            // Récupérer l'utilisateur connecté
            $user = Auth::user();

            // Vérifier si l'utilisateur est un prestataire
            if (!$user || !$user->prestataire) {
                return response()->json([
                    'success' => false,
                    'message' => 'Utilisateur non trouvé ou non prestataire.',
                ], 404);
            }

            // Récupérer le prestataire associé à l'utilisateur
            $prestataire = $user->prestataire;

            // Récupérer les IDs des services auxquels le prestataire est déjà abonné
            $subscribedServiceIds = $prestataire->services()->pluck('services.id');

            // Récupérer tous les services disponibles non abonnés en une seule requête
            $unsubscribedServices = Service::whereNotIn('id', $subscribedServiceIds)->get();

            // Vérifier s'il y a des services non abonnés
            if ($unsubscribedServices->isEmpty()) {
                return response()->json([
                    'success' => true,
                    'message' => 'Le prestataire est abonné à tous les services disponibles.',
                    'data' => [],
                ], 200);
            }

            // Retourner les services non abonnés
            return response()->json([
                'success' => true,
                'message' => 'Services non abonnés récupérés avec succès.',
                'data' => $unsubscribedServices,
            ], 200);
        } catch (ModelNotFoundException $e) {
            // Gestion spécifique pour les erreurs de modèle (si un service est introuvable)
            return response()->json([
                'success' => false,
                'error' => 'Aucun service trouvé.',
                'message' => $e->getMessage(),
            ], 404);
        } catch (Exception $e) {
            // Gestion des erreurs générales
            return response()->json([
                'success' => false,
                'error' => 'Une erreur est survenue lors de la récupération des services.',
                'message' => $e->getMessage(),
            ], 500);
        }
    }



    public function providerService(Request $request)
    {
        // Validation des données entrantes
        $validator = Validator::make($request->all(), [
            'service_id' => 'required|exists:services,id',
            'prix' => 'required|numeric|min:0',
        ]);

        // Si la validation échoue, retourner une réponse d'erreur
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $data = $validator->validated();
        $prestataire = Auth::user()->prestataire;
        // Attacher le service au prestataire avec le prix
        $prestataire->services()->attach($data['service_id'], ['prix' => $data['prix']]);
        // Retourner une réponse de succès
        return response()->json(['message' => 'Service ajouté avec succès'], 200);
    }

    public function getSubscribedServices()
    {
        // Récupérer le prestataire authentifié
        $prestataire = Auth::user()->prestataire;

        // Récupérer les services auxquels le prestataire s'est abonné avec le prix
        $services = $prestataire->services()->withPivot('prix')->get();

        // Retourner la réponse JSON
        return response()->json(['services' => $services], 200);
    }


    public function updateServicePrice(Request $request, $serviceId)
    {

        $validator = Validator::make($request->all(), [
            'prix' => 'required|numeric|min:0',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = $validator->validated();
        $prestataire = Auth::user()->prestataire;
        $prestataire->services()->updateExistingPivot($serviceId, ['prix' => $data['prix']]);
        return response()->json(['message' => 'Prix mis à jour avec succès'], 200);
    }

   public function store(Request $request)
{
    // Validation des données avec messages personnalisés
    $validator = Validator::make($request->all(), [
        'name' => 'required|string|unique:services',
        'description' => 'nullable|string',
    ], [
        'name.required' => 'Le nom du service est obligatoire.',
        'name.unique' => 'Ce nom de service est déjà utilisé.',
    ]);

    // Si la validation échoue, retourner une réponse JSON avec les erreurs
    if ($validator->fails()) {
        return response()->json([
            'success' => false,
            'message' => 'Erreurs de validation',
            'errors' => $validator->errors(),
        ], 422); // Code HTTP 422 : Unprocessable Entity
    }

    try {
        // Créer le service avec les données reçues
        $data = $request->only(['name', 'description']);
        $service = Service::create($data);

        // Retourner une réponse JSON de succès
        return response()->json([
            'success' => true,
            'message' => 'Service créé avec succès',
            'data' => $service,
        ], 201); // Code HTTP 201 : Created
    } catch (\Illuminate\Database\QueryException $e) {
        // Gestion spécifique des erreurs de base de données
        return response()->json([
            'success' => false,
            'message' => 'Erreur de base de données',
            'error' => $e->getMessage(),
        ], 500); // Code HTTP 500 : Internal Server Error
    } catch (\Throwable $th) {
        // Gestion des erreurs générales
        return response()->json([
            'success' => false,
            'message' => 'Erreur lors de la création du service',
            'error' => $th->getMessage(),
        ], 500); // Code HTTP 500 : Internal Server Error
    }
}
}
