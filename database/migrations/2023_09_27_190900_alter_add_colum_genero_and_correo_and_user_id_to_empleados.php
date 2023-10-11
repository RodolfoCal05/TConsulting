<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class AlterAddColumGeneroAndCorreoAndUserIdToEmpleados extends Migration
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
            $table->string('genero')->after('dpi');
            $table->string('correo')->after('estado_civil');
            $table->bigInteger('user_id')->unsigned()->after('activo');

            $table->foreign('user_id')->references('id')->on('users');
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
            $$table->dropindex('familia_empleados_user_id_foreign');
            $table->dropColumn(['genero', 'correo','user_id']);
        });
    }
}
