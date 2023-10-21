<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddEmpresaIdAndPlanillaIdToPlanillaEmpledos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('planilla_empleados', function (Blueprint $table) {
            $table->foreignId('planilla_id')->after('dias_laborados')->constrained('planillas');
            $table->bigInteger('empresa_id')->after('planilla_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('planilla_empleados', function (Blueprint $table) {
            $table->dropForeign('planilla_empleados_planilla_id_foreign');
            $table->dropColumn('planilla_id');
            $table->dropColumn('empresa_id');
        });
    }
}
