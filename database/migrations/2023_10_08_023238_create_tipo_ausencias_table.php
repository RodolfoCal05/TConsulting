<?php

use App\Models\TConsulting\TipoAusencia;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTipoAusenciasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tipo_ausencias', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->boolean('activo');
            $table->timestamps();
        });

        TipoAusencia::truncate();
        TipoAusencia::insert([['descripcion' => 'Descuento', 'activo' =>1],['descripcion' => 'Pagar', 'activo' =>1]]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tipo_ausencias');
    }
}
