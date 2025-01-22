<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{

    public function show()
    {
        $user = Auth::user();
        if($user->role=='client'){
            return response()->json([
                'success' => true,
                'message' => 'Profil récupéré avec succès.',
                'data' => ['user' => $user, 'client' => $user->client,],
            ], 200);
        }else{
            return response()->json([
                'success' => true,
                'message' => 'Profil récupéré avec succès.',
                'data' => ['user' => $user, 'prestataire' => $user->prestataire,],
            ], 200);
        }
        
    }

    public function updateProfile(Request $request)
    {
        // Récupérer l'utilisateur authentifié
        $user = Auth::user();

        // Valider les données entrantes pour l'utilisateur
        $userValidator = Validator::make($request->all(), [
            'firstname' => 'sometimes|string|max:255',
            'lastname' => 'sometimes|string|max:255',
            'phone' => 'sometimes|string|max:20',
            'email' => 'sometimes|email|unique:users,email,' . $user->id,
            'username' => 'sometimes|string|unique:users,username,' . $user->id,
        ]);

        // Si la validation échoue, retourner une réponse d'erreur
        if ($userValidator->fails()) {
            return response()->json(['errors' => $userValidator->errors()], 422);
        }

        // Mettre à jour les informations de l'utilisateur
        $user->update($userValidator->validated());

        // Retourner une réponse de succès
        return response()->json([
            'success' => true,
            'message' => 'Profil mis à jour avec succès.',
            'data' => [
                'user' => $user,
                // 'token'=> $user->token,
                'prestataire' => $user->prestataire,
            ],
        ], 200);
    }

}
