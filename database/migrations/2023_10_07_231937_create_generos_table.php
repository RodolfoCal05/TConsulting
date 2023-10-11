<?php

use App\Models\TConsulting\Genero;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGenerosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('generos', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->boolean('activo');
            $table->timestamps();
        });

        Genero::truncate();
        Genero::insert([['descripcion' => 'Masculino', 'activo' => 1], ['descripcion' => 'Femenino', 'activo' => 1]]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('generos');
    }
}
