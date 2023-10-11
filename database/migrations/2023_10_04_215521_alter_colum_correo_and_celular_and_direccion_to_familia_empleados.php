<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterColumCorreoAndCelularAndDireccionToFamiliaEmpleados extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('familia_empleados', function (Blueprint $table) {
            $table->string('correo')->nullable()->change();
            $table->string('celular')->nullable()->change();
            $table->string('direccion')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('familia_empleados', function (Blueprint $table) {
            $table->string('correo')->change();
            $table->string('celular')->change();
            $table->string('direccion')->change();
        });
    }
}
