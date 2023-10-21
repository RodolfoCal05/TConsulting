<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CreateProcedureComisionVentas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::unprepared("DROP PROCEDURE IF EXISTS comision_ventas");
        DB::unprepared("CREATE PROCEDURE comision_ventas(in _cue int, in _fecha_inicio date, in _fecha_fin date)
                            BEGIN
                                declare total_ventas decimal(10,4);

                                set total_ventas = (select sum(vd.total) as venta_total  from tconsulting.ventas v
                                                            inner join tconsulting.venta_detalles vd on v.id = vd.venta_id
                                                    where v.cue_autoriza = _cue and v.fecha between _fecha_inicio and _fecha_fin and v.estado = 'GRABADO');

                                select vc.descripcion, sum(vc.porcentaje * total_ventas) as comision_total  from tconsulting.venta_comisiones vc 
                                where vc.monto_inicio <= total_ventas and vc.monto_fin >= total_ventas
                                group by vc.descripcion;
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
        DB::unprepared("DROP PROCEDURE IF EXISTS comision_ventas");

    }
}
