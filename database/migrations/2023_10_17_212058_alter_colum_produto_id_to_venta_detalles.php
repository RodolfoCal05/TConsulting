<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterColumProdutoIdToVentaDetalles extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('venta_detalles', function (Blueprint $table) {
            $table->dropForeign('venta_detalles_produto_id_foreign');
            $table->dropColumn('produto_id');
            $table->foreignId('producto_id')->after('venta_id')->constrained('productos');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('venta_detalles', function (Blueprint $table) {
            //
        });
    }
}
