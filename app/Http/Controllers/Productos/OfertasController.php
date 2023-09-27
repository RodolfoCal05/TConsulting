<?php

namespace App\Http\Controllers\Productos;

use App\Models\CincoCalles\Oferta;
use Csgt\Crud\CrudController;

class OfertasController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new Oferta);
        $this->setTitle('Ofertas');

        $this->setField(['name' => 'Id', 'field' => 'id', 'editable' => false]);
        $this->setField(['name' => 'Descripcion', 'field' => 'descripcion', 'editable' => true]);
        $this->setField(['name' => 'Porcentaje', 'field' => 'valor', 'editable' => true]);

        $this->setPermissions("\Cancerbero::crudPermissions", 'productos.ofertas');
    }
}