<?php

namespace App\Http\Controllers\Solicitudes;

use App\Models\TConsulting\SolicitudAusencia;
use App\Models\TConsulting\TipoAusencia;
use Csgt\Crud\CrudController;

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
                'name'       => 'Tipo Ausencia',
                'field'      => 'tipo_ausencia_id',
                'type'       => 'combobox',
                'collection' => TipoAusencia::select('id', 'descripcion')->get(),
            ]);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'solicitudes.autorizacion-ausencias');
    }
}
