<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAscensosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ascensos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cue')->constrained('empleados', 'cue');
            $table->foreignId('puesto_id')->constrained('puestos');
            $table->foreignId('sueldo_id')->constrained('sueldos');
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
        Schema::dropIfExists('ascensos');
    }
}
