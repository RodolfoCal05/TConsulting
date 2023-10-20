<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDescuentoEmpleadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('descuento_empleados', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cue')->constrained('empleados', 'cue');
            $table->string('estado');
            $table->decimal('monto', 10,6);
            $table->foreignId('tipo_descuento_id')->constrained('tipo_descuentos');
            $table->date('fecha');
            $table->bigInteger('user_id');
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
        Schema::dropIfExists('descuento_empleados');
    }
}
