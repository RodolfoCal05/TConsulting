<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmpleadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('empleados', function (Blueprint $table) {
            $table->id('cue');
            $table->string('nombre1');
            $table->string('nombre2')->nullable();
            $table->string('nombre3')->nullable();
            $table->string('apellido1');
            $table->string('apellido2');
            $table->string('apellido3')->nullable();
            $table->integer('dpi');
            $table->date('fecha_nacimiento');
            $table->string('direccion');
            $table->string('celular');
            $table->string('telefono')->nullable();
            $table->string('estado_civil');
            $table->foreignId('puesto_id')->constrained('puestos');
            $table->foreignId('sueldo_id')->constrained('sueldos');
            $table->boolean('activo');
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
        Schema::dropIfExists('empleados');
    }
}
