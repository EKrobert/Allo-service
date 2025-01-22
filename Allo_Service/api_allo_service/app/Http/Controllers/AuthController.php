<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{

    //VUE DE LOGIN
    public function loginVue()
    {
        return view('login');
    }

    public function login(Request $request)
{
    // Validation des champs
    $validator = Validator::make($request->all(), [
        'username' => 'required|string|max:50',
        'password' => 'required',
    ]);

    // Si la validation échoue, rediriger avec les erreurs
    if ($validator->fails()) {
        return back()
            ->withErrors($validator)
            ->withInput()
            ->with('error', 'The credentials are incorrect. Try Again.');
    }

    // Récupérer les données du formulaire
    $check = $request->only('username', 'password');

    // Tenter l'authentification avec le guard 'web' (table `users`)
    if (Auth::guard('web')->attempt($check)) {
        $user = Auth::guard('web')->user(); // Récupérer l'utilisateur authentifié

        // Vérifier si l'utilisateur existe
        if ($user) {
            return redirect('/')->with('success', 'Connexion réussie !');
        }

        // Déconnecter l'utilisateur en cas de problème
        Auth::guard('web')->logout();
        return redirect()->route('login')->with('error', 'Votre compte a été désactivé');
    }

    // Si l'authentification échoue, rediriger avec un message d'erreur
    return back()->with('fail', 'Wrong username or password')->withInput();
}

    // FONCTION DE DECONNEXION    
    public function deconnexion() //logout
    {
        Auth::guard('admin')->logout();
        return redirect()->route('login');
    }
}
