<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProduccionDiariasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('produccion_diaria', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cue')->constrained('empleados', 'cue');
            $table->foreignId('bodega_id')->constrained('bodegas');
            $table->foreignId('producto_id')->constrained('productos');
            $table->bigInteger('cantidad');
            $table->integer('user_id');
            $table->date('fecha');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('produccion_diaria');
    }
}
