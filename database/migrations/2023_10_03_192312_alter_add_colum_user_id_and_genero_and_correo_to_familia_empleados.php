<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddColumUserIdAndGeneroAndCorreoToFamiliaEmpleados extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('familia_empleados', function (Blueprint $table) {
            $table->string('genero')->after('dpi');
            $table->string('correo')->after('estado_civil');
            $table->bigInteger('user_id')->unsigned()->after('empleado_cue');

            $table->foreign('user_id')->references('id')->on('users');
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
            $table->dropColumn(['genero', 'correo','user_id']);
        });
    }
}
