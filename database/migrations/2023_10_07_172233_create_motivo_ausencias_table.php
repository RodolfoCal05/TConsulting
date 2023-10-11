<?php

use App\Models\TConsulting\MotivoAusencia;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMotivoAusenciasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('motivo_ausencias', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->foreignId('user_id')->constrained('users', 'id');
            $table->boolean('activo');
            $table->timestamps();
        });

        MotivoAusencia::truncate();
        MotivoAusencia::insert([
            ['descripcion' => 'Vacacion', 'user_id' => 1, 'activo' =>1], 
            ['descripcion' => 'Lluvia', 'user_id' => 1, 'activo' =>1],
            ['descripcion' => 'Asunto Familiar', 'user_id' => 1, 'activo' =>1],
            ['descripcion' => 'Enfermedad', 'user_id' => 1, 'activo' =>1],
        ]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('motivo_ausencias');
    }
}
