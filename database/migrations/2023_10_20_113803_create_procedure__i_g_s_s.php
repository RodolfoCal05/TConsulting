<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateProcedureIGSS extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::unprepared("DROP PROCEDURE IF EXISTS calculo_pago_e_igss");
        DB::unprepared("CREATE PROCEDURE calculo_pago_e_igss(IN _cue INT, IN _tipo INT)
                        BEGIN
                            DECLARE cue INT;
                            DECLARE tipo INT;
                            DECLARE igss DECIMAL(10, 4);
                            DECLARE porcentaje DECIMAL(10, 4);

                            SET cue = _cue;
                            SET tipo = _tipo;
                            SET igss = 0.0483;

                            IF tipo = 1 THEN
                                SET porcentaje = 0.45;
                            ELSEIF tipo = 2 THEN
                                SET porcentaje = 0.55;
                            END IF;

                            select r.cue, r.sueldo, r.pago, sum(r.pago * igss) as cuota_igss
                            from (SELECT e.cue, s.sueldo, SUM(s.sueldo * porcentaje) AS pago
                                FROM tconsulting.empleados e
                                    INNER JOIN tconsulting.sueldos s ON e.sueldo_id = s.id AND e.puesto_id = s.puesto_id
                            WHERE e.cue = cue) as r
                            group by r.cue;
                        END;"
        );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::unprepared("DROP PROCEDURE IF EXISTS calculo_pago_e_igss");
    }
}
