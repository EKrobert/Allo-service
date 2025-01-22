<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Client;
use App\Models\Prestataire;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AuthenticationController extends Controller
{
    public function register(Request $request)
    {
        // Règles de validation
        $validator = Validator::make($request->all(), [
            'firstname' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'phone' => 'required|string|max:15',
            'email' => 'required|email|unique:users,email',
            'username' => 'required|string|unique:users,username|min:5|max:15',
            'password' => 'required',
        ]);

        // Vérification des erreurs de validation
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation errors',
                'errors' => $validator->errors(),
            ], 400);
        }

        try {
            $data = $request->all();
            $data['password'] =  bcrypt($request->password); // Hachage du mot de passe
            // Création de l'utilisateur
            $user = User::create($data);
            // Vérification du rôle et enregistrement dans la table correspondante
            if ($request->role === 'client') {
                // Création du client avec `status=1`
                $client = new Client();
                $client->status = 1; // Client actif par défaut
                $client->user()->associate($user);
                $client->save();
            } elseif ($request->role === 'provider') {
                // Création du prestataire avec `status=0`
                $provider = new Prestataire();
                $provider->status = 0; // Prestataire inactif par défaut
                $provider->user()->associate($user);
                $provider->save();
            }

            // Réponse en cas de succès
            return response()->json([
                'success' => true,
                'message' => 'User registered successfully',
                'data' => [
                    'user' => $user,
                    'role' => $request->role,
                ],
            ], 200);
        } catch (\Exception $e) {
            // Gestion des erreurs inattendues
            return response()->json([
                'success' => false,
                'message' => 'Registration failed',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function login(Request $request)
    {
        // Validation des champs
        $validator = Validator::make($request->all(), [
            'email' => 'required|string',
            'password' => 'required|string',
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation errors',
                'errors' => $validator->errors(),
            ], 400);
        }
    
        // Authentification avec le username
        $credentials = $request->only('email', 'password');
    
        if (Auth::attempt($credentials)) {
            $user = Auth::user();
    
            return response()->json([
                'success' => true,
                'message' => 'Login successful',
                'data' => [
                    'user' => $user,
                    'token' => $user->createToken('authToken')->plainTextToken,
                ],
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Invalid username or password',
            ], 401);
        }
    }

    public function logout()
    {
        $user = Auth::user();
        $user->tokens()->delete();
        return response()->json([
            'success' => true,
            'message' => 'Logout successful',
        ], 200);
    }
    
}
