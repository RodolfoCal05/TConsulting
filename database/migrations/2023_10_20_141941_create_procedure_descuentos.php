<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CreateProcedureDescuentos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::unprepared("DROP PROCEDURE IF EXISTS descuentos");
        DB::unprepared("CREATE PROCEDURE descuentos(in _cue int, in _fecha_inicio date, in _fecha_fin date)
                            BEGIN
                                select de.cue, sum(de.monto) as descuento_total from tconsulting.descuento_empleados de
                                where de.cue = _cue and de.fecha between _fecha_inicio and _fecha_fin;
                            END"
                    );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::unprepared("DROP PROCEDURE IF EXISTS descuentos");
    }
}
