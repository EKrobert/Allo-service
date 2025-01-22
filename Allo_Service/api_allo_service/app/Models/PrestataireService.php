<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PrestataireService extends Model
{
    protected $table = 'prestataire_service';

    protected $fillable = [
        'prestataire_id',
        'service_id',
        'prix',
    ];
}
