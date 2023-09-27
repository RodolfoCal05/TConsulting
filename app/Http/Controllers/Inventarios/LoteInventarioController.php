<?php

namespace App\Http\Controllers\Inventarios;

use App\Models\CincoCalles\Inventario;
use App\Models\CincoCalles\Lote;
use Csgt\Crud\CrudController;

class LoteInventarioController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new Inventario);
        $this->setTitle('Lote de Inventario');

        $this->setField(['name' => 'Id', 'field' => 'id', 'editable' => false]);
        $this->setField(['name' => 'Sucursal', 'field' => 'sucursal.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Producto', 'field' => 'producto.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Lote', 'field' => 'lote.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Existencias', 'field' => 'existencias', 'editable' => false]);

        $this->middleware(function ($request, $next) {
            $this->setField([
                'name'       => 'Lote',
                'field'      => 'lote_id',
                'type'       => 'combobox',
                'collection' => Lote::select('id', 'descripcion')->get(),
            ]);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'inventarios.lote-inventario');
    }
}