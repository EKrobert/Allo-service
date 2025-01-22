<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Service extends Model
{
    //
    protected $fillable = ['id','name', 'description'];

    // Relation many-to-many avec les prestataires
    public function prestataires()
    {
        return $this->belongsToMany(Prestataire::class, 'prestataire_service', 'service_id', 'prestataire_id')->withPivot('prix');
    }
}
