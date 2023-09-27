<?php

namespace App\Http\Controllers\Socios;

use App\Models\CincoCalles\Fidelizacion;
use App\Models\CincoCalles\Socio;
use App\Models\CincoCalles\TipoSocio;
use Csgt\Crud\CrudController;
use Illuminate\Support\Facades\DB;

class ListadoSociosController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new Socio);
        $this->setTitle('Listado de Socios');

        $this->setField(['name' => 'Id', 'field' => 'id', 'editable' => false]);
        $this->setField(['name' => 'Nombre', 'field' => 'nombre', 'editable' => true]);
        $this->setField(['name' => 'NIT', 'field' => 'nit', 'editable' => true]);
        $this->setField(['name' => 'Direccion', 'field' => 'direccion', 'editable' => true]);
        $this->setField(['name' => 'Fidelizacion', 'field' => 'fidelizacion.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Porcentaje por Fidelizacion', 'field' => 'fidelizacion.valor', 'editable' => false]);
        $this->setField(['name' => 'Tipo de Socio', 'field' => 'tiposocio.descripcion', 'editable' => false]);

        $this->middleware(function ($request, $next) {
            $this->setField([
                'name'       => 'Fidelizacion',
                'field'      => 'fidelizacion_id',
                'type'       => 'combobox',
                'collection' => Fidelizacion::select('id', DB::raw("CONCAT(descripcion, ' ', valor)"))->get(),
            ]);

            $this->setField([
                'name'       => 'Tipo de Socio',
                'field'      => 'tipo_socio_id',
                'type'       => 'combobox',
                'collection' => TipoSocio::select('id', 'descripcion')->get(),
            ]);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'socios.listado-socios');
    }
}
