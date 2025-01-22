<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Prestataire extends Model
{
    // Relation avec la table `users`
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    // Relation many-to-many avec les services
    public function services()
    {
        return $this->belongsToMany(Service::class, 'prestataire_service', 'prestataire_id', 'service_id')->withPivot('prix');
    }
    // Relation avec les réservations
    public function reservations(): HasMany
    {
        return $this->hasMany(Reservation::class);
    }
}
