<?php

namespace App\Http\Controllers\Solicitudes;

use App\Http\Controllers\Controller;
use App\Models\TConsulting\Empleado;
use App\Models\TConsulting\MotivoAusencia;
use App\Models\TConsulting\Puesto;
use App\Models\TConsulting\SolicitudAusencia;
use App\Models\TConsulting\TipoAusencia;
use App\Models\TConsulting\TipoSolicitude;
use Csgt\Crud\CrudController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AusenciaController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new SolicitudAusencia);
        $this->setTitle('Solcitud Ausencias');

        $this->setField(['name' => 'cue', 'field' =>'empleado.cue', 'editable' => false]);
        $this->setField(['name' => 'Primer Nombre', 'field' =>'empleado.nombre1', 'editable' => false]);
        $this->setField(['name' => 'Primer Apellido', 'field' =>'empleado.apellido1', 'editable' => false]);
        //$this->setField(['name' => 'Tipo Solicitud', 'field' =>'tipoSolicitud.descripcion', 'editable' => false]);
       $this->setField(['name' => 'Motivo Ausencia', 'field' =>'motivo.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Fecha Desde', 'field' =>'fecha_desde', 'type' => 'date', 'editable' => true]);
        $this->setField(['name' => 'Fecha Hasta', 'field' =>'fecha_hasta', 'type' => 'date','editable' => true]);
        $this->setField(['name' => 'Estado', 'field' =>'estado', 'editable' => false]);
        //$this->setField(['name' => 'Tipo Ausencia', 'field' =>'tipoAusencia.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Observacion', 'field' =>'observacion', 'editable' => false]);


        $this->middleware(function ($request, $next) {
           // $this->setHidden(['field' => 'user_id', 'value' => auth()->user()->id]);
            $this->setField([
				'name'       => 'Empleado',
				'field'      => 'cue',
				'type'       => 'combobox',
				'collection' => Empleado::query()
					->select('cue', DB::raw("concat (cue, ' - ', nombre1, ' ', apellido1) as nombre"))
					->where('activo', 1)
					->get(),
			]);
            $this->setField([
                'name'       => 'Motivo Ausencia',
                'field'      => 'motivo_ausencia_id',
                'type'       => 'combobox',
                'collection' => MotivoAusencia::select('id', 'descripcion')->get(),
            ]);
            $this->setHidden(['field' => 'tipo_solicitud_id', 'value' => 1]);
            $this->setHidden(['field' => 'estado', 'value' => 'SOLICITADO']);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'solicitudes.ausencias');
   }

}
