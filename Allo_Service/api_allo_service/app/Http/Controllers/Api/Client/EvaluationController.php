<?php

namespace App\Http\Controllers\Api\Client;

use App\Http\Controllers\Controller;
use App\Models\Evaluation;
use Illuminate\Http\Request;


class EvaluationController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'reservation_id' => 'required|exists:reservations,id',
            'prestataire_id' => 'required|exists:prestataires,id',
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'nullable|string',
        ]);

        $evaluation = Evaluation::create($request->all());
        
        return response()->json([
            'message' => 'Évaluation enregistrée avec succès',
            'data' => $evaluation,
        ], 201);
    }
}
