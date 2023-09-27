<?php

use App\Models\Tconsulting\Empresa;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmpresasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('empresas', function (Blueprint $table) {
            $table->id();
            $table->string('nombre');
            $table->string('direccion');
            $table->boolean('activo');
            $table->timestamps();
        });
        Empresa::insert([
            ['nombre' => 'Distribuidora RJ', 'direccion' => 'zona 1 Mazatenango, suchitepequez', 'activo' => 1],
            ['nombre' => 'GYM Planet', 'direccion' => 'zona 0, Mazatenango, suchitepequez', 'activo' => 1],
        ]);

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('empresas');
    }
}
