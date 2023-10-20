<?php

use App\Models\Ventas\VentaComisione;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVentaComisionesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('venta_comisiones', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->double('monto_inicio');
            $table->double('monto_fin');
            $table->double('porcentaje');
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
        Schema::dropIfExists('venta_comisiones');
    }
}
