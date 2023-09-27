<?php

namespace App\Http\Controllers\Inventarios;

use App\Models\TConsulting\Sucursal;
use App\Models\TConsulting\TipoSede;
use Csgt\Crud\CrudController;

class SucursalesController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new Sucursal);
        $this->setTitle('Sucursales');

        $this->setField(['name' => 'Id', 'field' => 'id', 'editable' => false]);
        $this->setField(['name' => 'Descripcion', 'field' => 'descripcion', 'editable' => true]);
        $this->setField(['name' => 'Estado', 'field' => 'estado', 'editable' => false]);
        $this->setField(['name' => 'Tipo Sede', 'field' => 'tiposede.descripcion', 'editable' => false]);

        $this->middleware(function ($request, $next) {
            $this->setField([
                'name'       => 'Estado',
                'field'      => 'estado',
                'type'       => 'combobox',
                'collection' => collect([['id' => 'ACTIVO', 'name' => 'ACTIVO'], ['id' => 'INACTIVO', 'name' => 'INACTIVO']]),
            ]);

            $this->setField([
                'name'       => 'Tipo Sede',
                'field'      => 'tipo_sede_id',
                'type'       => 'combobox',
                'collection' => TipoSede::select('id', 'descripcion')->get(),
            ]);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'inventarios.sucursales');
    }
}
