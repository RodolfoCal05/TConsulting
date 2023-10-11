<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSolicitudAusenciasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('solicitud_ausencias', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cue')->constrained('empleados', 'cue');
            $table->foreignId('tipo_solicitud_id')->constrained('tipo_solicitudes', 'id');
            $table->foreignId('motivo_ausencia_id')->constrained('motivo_ausencias', 'id');
            $table->date('fecha_desde');
            $table->date('fecha_hasta');
            $table->string('estado');
            $table->foreignId('tipo_ausencia_id')->nullable()->constrained('tipo_ausencias', 'id');
            $table->string('observacion')->nullable();
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
        Schema::dropIfExists('solicitud_ausencias');
    }
}
