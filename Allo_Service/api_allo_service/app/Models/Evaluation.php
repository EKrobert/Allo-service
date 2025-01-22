<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Evaluation extends Model
{
    protected $fillable = ['reservation_id', 'prestataire_id', 'rating', 'comment'];

    public function reservation()
    {
        return $this->belongsTo(Reservation::class);
    }
    
}
