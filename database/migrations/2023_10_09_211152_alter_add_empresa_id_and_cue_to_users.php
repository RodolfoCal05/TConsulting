<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterAddEmpresaIdAndCueToUsers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->foreignId('cue')->nullable()->after('email')->constrained('empleados', 'cue');
            $table->foreignId('empresa_id')->nullable()->after('remember_token')->constrained('empresas','id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['users_cue_foreign','users_empresa_id_foreign']);
            $table->dropColumn(['cue','empresa_id']);
        });
    }
}
