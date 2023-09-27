<?php

namespace App\Http\Controllers\Productos;

use App\Models\CincoCalles\Lote;
use Csgt\Crud\CrudController;

class LotesController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new Lote);
        $this->setTitle('Lotes');

        $this->setField(['name' => 'Id', 'field' => 'id', 'editable' => false]);
        $this->setField(['name' => 'Fecha Vencimiento (mes/año)', 'field' => 'descripcion', 'editable' => true]);

        $this->setPermissions("\Cancerbero::crudPermissions", 'productos.lotes');
    }
}