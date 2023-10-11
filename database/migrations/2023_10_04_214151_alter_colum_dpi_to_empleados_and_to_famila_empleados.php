<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterColumDpiToEmpleadosAndToFamilaEmpleados extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('empleados', function (Blueprint $table) {
            $table->bigInteger('dpi')->change();
        });

        Schema::table('familia_empleados', function (Blueprint $table) {
            $table->bigInteger('dpi')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('empleados', function (Blueprint $table) {
            $table->integer('dpi')->change();
        });

        Schema::table('familia_empleados', function (Blueprint $table) {
            $table->integer('dpi')->nullable()->change();
        });
    }
}
