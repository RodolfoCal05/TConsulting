<?php

use App\Models\TConsulting\EstadoCivil;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEstadoCivilsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('estado_civils', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->boolean('activo');
            $table->timestamps();
        });

        EstadoCivil::truncate();
        EstadoCivil::insert([['descripcion' => 'Casado', 'activo' => 1], ['descripcion' => 'Soltero', 'activo' => 1]]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('estado_civils');
    }
}
