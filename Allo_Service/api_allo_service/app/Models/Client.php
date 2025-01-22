<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Client extends User
{
    
    // Relation avec la table `users`
    public function user()
    {
        return $this->belongsTo(User::class);
    }

     // Relation avec les réservations
     public function reservations(): HasMany
     {
         return $this->hasMany(Reservation::class);
     }

}
