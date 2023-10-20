<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddColumBodegaIdAndLoteIdToInventarios extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('inventarios', function (Blueprint $table) {
            $table->foreignId('bodega_id')->after('producto_id')->constrained('bodegas');
            $table->foreignId('lote_id')->after('bodega_id')->nullable()->constrained('lotes');
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
            $table->dropForeign('inventarios_bodega_id_foreign');
            $table->dropForeign('inventarios_lote_id_foreign');
            $table->dropColumn('bodega_id');
            $table->dropColumn('lote_id');
        });
    }
}
