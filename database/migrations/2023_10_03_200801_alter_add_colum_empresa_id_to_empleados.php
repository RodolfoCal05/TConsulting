<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddColumEmpresaIdToEmpleados extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::disableForeignKeyConstraints();
        Schema::table('empleados', function (Blueprint $table) {
            $table->bigInteger('empresa_id')->unsigned()->after('sueldo_id');

            $table->foreign('empresa_id', 'empresa_id_foreign')->references('id')->on('empresas');
        });
        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('empleados', function (Blueprint $table) {
            $table->dropIndex('empresa_id_foreign');
            $table->dropColumn('empresa_id');
        });
    }
}
