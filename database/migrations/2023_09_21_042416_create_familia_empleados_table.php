<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFamiliaEmpleadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('familia_empleados', function (Blueprint $table) {
            $table->id();
            $table->string('nombre1');
            $table->string('nombre2')->nullable();
            $table->string('nombre3')->nullable();
            $table->string('apellido1');
            $table->string('apellido2');
            $table->string('apellido3')->nullable();
            $table->integer('dpi')->nullable();
            $table->date('fecha_nacimiento');
            $table->string('direccion');
            $table->string('celular');
            $table->string('telefono')->nullable();
            $table->string('estado_civil');
            $table->foreignId('tipo_familia_id')->constrained('tipo_familias');
            $table->foreignId('empleado_cue')->constrained('empleados','cue');
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
        Schema::dropIfExists('familia_empleados');
    }
}
