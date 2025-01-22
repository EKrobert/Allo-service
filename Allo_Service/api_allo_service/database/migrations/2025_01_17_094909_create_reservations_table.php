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
        Schema::create('reservations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('client_id')->constrained()->onDelete('cascade'); // Clé étrangère vers users (clients)
            $table->foreignId('prestataire_id')->constrained()->onDelete('cascade'); // Clé étrangère vers users (prestataires)
            $table->foreignId('service_id')->constrained('services')->onDelete('cascade'); // Clé étrangère vers services
            $table->string('statut')->default('en_attente'); // Statut de la réservation
            $table->string('adresse');
            $table->string('commentaire')->nullable();
            $table->date('reservation_date'); // Date de la réservation
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reservations');
    }
};
