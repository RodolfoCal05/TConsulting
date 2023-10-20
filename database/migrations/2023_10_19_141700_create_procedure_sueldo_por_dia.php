<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CreateProcedureSueldoPorDia extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::unprepared("DROP PROCEDURE IF EXISTS sueldo_por_dia");
        DB::unprepared("CREATE PROCEDURE sueldo_por_dia(in _cue int)
                            BEGIN
                                set @cue = _cue;
                                select e.cue, s.sueldo, sum(s.sueldo/30) as sueldo_por_dia  from tconsulting.empleados e
                                        inner join tconsulting.sueldos s on e.sueldo_id = s.id and e.puesto_id = s.puesto_id
                                where e.cue = @cue; 
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
        DB::unprepared("DROP PROCEDURE IF EXISTS sueldo_por_dia");
    }
}
