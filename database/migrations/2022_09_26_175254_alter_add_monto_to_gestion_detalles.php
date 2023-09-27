<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddMontoToGestionDetalles extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('gestion_detalles', function (Blueprint $table) {
            $table->decimal('monto')->default(0)->after('costo');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('gestion_detalles', function (Blueprint $table) {
            $table->dropColumn('monto');
        });
    }
}
