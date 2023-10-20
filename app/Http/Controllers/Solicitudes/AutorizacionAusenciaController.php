<?php

namespace App\Http\Controllers\Solicitudes;

use App\Models\TConsulting\DescuentoEmpleado;
use App\Models\TConsulting\SolicitudAusencia;
use App\Models\TConsulting\TipoAusencia;
use Carbon\Carbon;
use Csgt\Crud\CrudController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AutorizacionAusenciaController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new SolicitudAusencia());
        $this->setWhere('estado', '=', 'SOLICITADO');
        $this->setTitle('Autorizacion Ausencias');

        $this->setField(['name' => 'cue', 'field' => 'empleado.cue', 'editable' => false]);
        $this->setField(['name' => 'Primer Nombre', 'field' => 'empleado.nombre1', 'editable' => false]);
        $this->setField(['name' => 'Primer Apellido', 'field' => 'empleado.apellido1', 'editable' => false]);
        $this->setField(['name' => 'Motivo Ausencia', 'field' => 'motivo.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Fecha Desde', 'field' => 'fecha_desde', 'type' => 'date', 'editable' => false]);
        $this->setField(['name' => 'Fecha Hasta', 'field' => 'fecha_hasta', 'type' => 'date', 'editable' => false]);
        $this->setField(['name' => 'Estado', 'field' => 'estado', 'editable' => false]);
        $this->setField(['name' => 'Observacion', 'field' => 'observacion', 'editable' => true]);

        $this->middleware(function ($request, $next) {
            $this->setField([
                'name' => 'Estado',
                'field' => 'estado',
                'type' => 'combobox',
                'collection' => collect([
                    ['id' => 'AUTORIZADO', 'name' => 'AUTORIZADO'],
                    ['id' => 'DENEGADO', 'name' => 'DENEGADO'],
                ]),
            ]);
            $this->setField([
                'name' => 'Tipo Ausencia',
                'field' => 'tipo_ausencia_id',
                'type' => 'combobox',
                'collection' => TipoAusencia::select('id', 'descripcion')->get(),
            ]);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'solicitudes.autorizacion-ausencias');
    }

    public function update(Request $request, $aId)
    {
        if ($request->tipo_ausencia_id == 1) {

            DB::beginTransaction();

            try {
                $solicitud = SolicitudAusencia::FindOrFail(decrypt($aId));

                $datosSueldo = DB::select('CALL sueldo_por_dia(?)', [$solicitud->cue]);

                if (!$datosSueldo[0]->sueldo_por_dia) {
                    abort(403, "Empleado sin Sueldo, favor de comunicarse con Sistemas...");
                }

                $descuento = new DescuentoEmpleado;
                $descuento->cue = $solicitud->cue;
                $descuento->estado = 'GRABADO';
                $descuento->monto = $datosSueldo[0]->sueldo_por_dia;
                $descuento->tipo_descuento_id = 2;
                $descuento->fecha = Carbon::now()->format('Y-m-d');
                $descuento->user_id = auth()->user()->id;
                $descuento->save();

                DB::commit();
            } catch (\Throwable $th) {
                DB::rollBack();
                throw $th;
            }

        }
        return parent::update($request, $aId);
    }
}
