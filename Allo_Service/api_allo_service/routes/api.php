<?php

use App\Http\Controllers\Api\AuthenticationController;
use App\Http\Controllers\Api\Client\EvaluationController;
use App\Http\Controllers\Api\Client\ReservationController;
use App\Http\Controllers\Api\Client\ServiceController as ClientServiceController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\Provider\ReservationController as ProviderReservationController;
use App\Http\Controllers\Api\Provider\ServiceController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/register', [AuthenticationController::class, 'register']);
Route::post('/login', [AuthenticationController::class, 'login']);

//Client route
Route::middleware(['auth:sanctum', 'role:client'])
    ->prefix('client')
    ->name('client.')
    ->group(function () {
        //Reservations
        Route::get('/reservations', [ReservationController::class, 'index'])->name('reservations.index');
        Route::post('/reservation', [ReservationController::class, 'store'])->name('reservations.store');
        Route::get('/reservation/{id}', [ReservationController::class, 'details'])->name('reservations.details');
        Route::get('/services', [ClientServiceController::class, 'index']);
        Route::get('/services/{prestataire_id}', [ServiceController::class, 'index']);
        Route::post('/evaluations', [EvaluationController::class, 'store']);
});

//provider route
Route::middleware(['auth:sanctum', 'role:provider'])
    ->prefix('provider')
    ->name('provider.')
    ->group(function () {
        // Routes pour les providers
        Route::get('/reservations', [ProviderReservationController::class, 'index'])->name('reservations.index');
        Route::get('/reservation/{id}', [ProviderReservationController::class, 'details'])->name('reservations.details');
        Route::post('/reservations', [ProviderReservationController::class, 'store'])->name('reservations.store');
        Route::post('/reservation/{reservationId}/validate', [ProviderReservationController::class, 'validateReservation']);
        //services
        Route::get('/services', [ServiceController::class, 'index'])->name('services.index');
        Route::post('/create/service', [ServiceController::class, 'store']);
        Route::post('/add/service', [ServiceController::class, 'providerService']);
        Route::get('/recuperer/services', [ServiceController::class, 'getPrestataireServices']);
        // Récupérer les services auxquels le prestataire s'est abonné
        Route::get('/my/services', [ServiceController::class, 'getSubscribedServices']);
        // Mettre à jour le prix d'un service
        Route::put('/services/{serviceId}/update-price', [ServiceController::class, 'updateServicePrice']);
    });

//Route commune
Route::middleware('auth:sanctum')->prefix('user')->group(function () {
    //Profil
    Route::get('/profile', [ProfileController::class, 'show']);
    Route::put('/profile/update', [ProfileController::class, 'updateProfile']);
    Route::get('/services', [ServiceController::class, 'index'])->name('services.index');
    Route::post('/logout', [AuthenticationController::class, 'logout']);
});
