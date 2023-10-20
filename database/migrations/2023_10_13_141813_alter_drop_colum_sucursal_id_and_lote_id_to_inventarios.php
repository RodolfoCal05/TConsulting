<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterDropColumSucursalIdAndLoteIdToInventarios extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('inventarios', function (Blueprint $table) {
            $table->dropForeign('inventarios_sucursal_id_foreign');
            $table->dropForeign('inventarios_lote_id_foreign');
            $table->dropColumn('sucursal_id');
            $table->dropColumn('lote_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('inventarios', function (Blueprint $table) {
            
        });
    }
}
