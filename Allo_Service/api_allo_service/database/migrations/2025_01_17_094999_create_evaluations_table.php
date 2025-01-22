<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('evaluations', function (Blueprint $table) {
            $table->id();
            $table->integer('rating')->nullable(); // Note de 1 à 5
            $table->text('comment')->nullable(); // Commentaire optionnel
            $table->foreignId('reservation_id')->constrained()->onDelete('cascade'); 
            $table->foreignId('prestataire_id')->constrained()->onDelete('cascade'); 
            $table->timestamps();
        });
    }
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('evaluations');
    }
};
