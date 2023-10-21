<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlanesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('planes', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->date('fecha_desde');
            $table->date('fecha_hasta');
            $table->integer('serie_dias');
            $table->foreignId('periodo_id')->constrained('periodos');
            $table->integer('numero_plan');
            $table->bigInteger('user_id');
            $table->timestamps();

            $table->index(['fecha_desde', 'fecha_hasta', 'periodo_id']);
            $table->index(['periodo_id', 'numero_plan']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('planes');
    }
}
