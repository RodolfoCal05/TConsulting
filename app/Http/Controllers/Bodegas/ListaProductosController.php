<?php

namespace App\Http\Controllers\Bodegas;

use App\Models\Bodegas\Producto;
use Csgt\Crud\CrudController;

class ListaProductosController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new Producto());
        $this->setTitle('Lista de Productos');

        $this->setField(['name' => 'Id', 'field' => 'id', 'editable' => false]);
        $this->setField(['name' => 'Descripcion', 'field' => 'descripcion', 'editable' => true]);
        $this->setField(['name' => 'Codigo de Barra', 'field' => 'codigo_barra', 'editable' => true]);
        $this->setField(['name' => 'Precio', 'field' => 'precio', 'editable' => true]);
        $this->setField(['name' => 'Estado', 'field' => 'estado', 'editable' => false]);

        $this->middleware(function ($request, $next) {
            $this->setField([
                'name'       => 'Estado',
                'field'      => 'estado',
                'type'       => 'combobox',
                'collection' => collect([['id' => '1', 'name' => 'ACTIVO'], ['id' => '0', 'name' => 'INACTIVO']]),
            ]);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'bodegas.lista-productos');
    }
}
