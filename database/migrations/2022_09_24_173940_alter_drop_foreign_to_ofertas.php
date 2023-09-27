<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterDropForeignToOfertas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('ofertas', function (Blueprint $table) {
            $table->dropForeign('ofertas_precio_id_foreign');
            $table->dropColumn('precio_id');
            $table->decimal('valor')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('ofertas', function (Blueprint $table) {
            $table->foreignId('precio_id')->constrained('precios');
            $table->dropColumn('valor');
        });
    }
}
