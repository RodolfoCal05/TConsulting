<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterTwoColumToPlanillas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('planillas', function (Blueprint $table) {
            $table->dropForeign('planillas_tipo_planila_id_foreign');
            $table->dropColumn('tipo_planila_id');
            $table->foreignId('tipo_planilla_id')->after('fecha_fin')->constrained('tipo_planillas');
            $table->bigInteger('cierra_user_id')->nullable()->change();
            $table->bigInteger('calcula_user_id')->nullable()->change();
            $table->bigInteger('crea_user_id')->after('empresa_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('planillas', function (Blueprint $table) {
            //
        });
    }
}
