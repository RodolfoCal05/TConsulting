<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddForeignToPrecios extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('precios', function (Blueprint $table) {
            $table->foreignId('oferta_id')->constrained('ofertas');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('precios', function (Blueprint $table) {
            $table->dropForeign('precios_oferta_id_foreign');
            $table->dropColumn('oferta_id');
        });
    }
}
