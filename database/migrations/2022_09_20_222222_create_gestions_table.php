<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGestionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('gestiones', function (Blueprint $table) {
            $table->id();
            $table->date('fecha');
            $table->foreignId('serie_id')->constrained('series');
            $table->foreignId('origen')->constrained('sucursales');
            $table->foreignId('destino')->constrained('sucursales');
            $table->foreignId('socio_id')->constrained('socios');
            $table->foreignId('tipo_pago_id')->constrained('tipo_pagos');
            $table->foreignId('user_id')->constrained('users');
            $table->string('estado');
            $table->string('observaciones')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('gestiones');
    }
}
