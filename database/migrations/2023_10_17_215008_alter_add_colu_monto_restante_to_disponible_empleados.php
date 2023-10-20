<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddColuMontoRestanteToDisponibleEmpleados extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('disponible_empleados', function (Blueprint $table) {
            $table->double('monto_restante', 10,6)->after('monto');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('disponible_empleados', function (Blueprint $table) {
            $table->dropColumn('monto_restante');
        });
    }
}
