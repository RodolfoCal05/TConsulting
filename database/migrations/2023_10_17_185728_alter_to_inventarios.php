<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterToInventarios extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('inventarios', function (Blueprint $table) {
            $table->string('descripcion')->after('id');
            $table->dropForeign('inventarios_producto_id_foreign');
            $table->dropForeign('inventarios_lote_id_foreign');
            $table->dropColumn('producto_id');
            $table->dropColumn('lote_id');
            $table->dropColumn('existencias');
            $table->dropColumn('reservado');
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
            //
        });
    }
}
