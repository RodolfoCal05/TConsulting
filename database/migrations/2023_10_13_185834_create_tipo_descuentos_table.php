<?php

use App\Models\TConsulting\TipoDescuento;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTipoDescuentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tipo_descuentos', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->boolean('activo');
            $table->timestamps();
        });

        TipoDescuento::truncate();
        TipoDescuento::insert([
            ['descripcion' => 'abarroteria', 'activo' =>1],
            ['descripcion' => 'ausencia', 'activo' =>1],
            ['descripcion' => 'prestamo', 'activo' =>1],
            ['descripcion' => 'cooperativa', 'activo' =>1],
        ]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tipo_descuentos');
    }
}
