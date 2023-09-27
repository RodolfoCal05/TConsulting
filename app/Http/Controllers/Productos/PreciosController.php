<?php

namespace App\Http\Controllers\Productos;

use App\Models\CincoCalles\Oferta;
use App\Models\CincoCalles\Precio;
use App\Models\CincoCalles\Producto;
use App\Models\CincoCalles\Sucursal;
use Csgt\Crud\CrudController;
use Illuminate\Support\Facades\DB;

class PreciosController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new Precio);
        $this->setTitle('Lista de Precios');

        $this->setField(['name' => 'Id', 'field' => 'id', 'editable' => false]);
        $this->setField(['name' => 'Sucursal', 'field' => 'sucursal.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Producto', 'field' => 'producto.descripcion', 'editable' => false]);

        $this->middleware(function ($request, $next) {
            $this->setField([
                'name'       => 'Sucursal',
                'field'      => 'sucursal_id',
                'type'       => 'combobox',
                'collection' => Sucursal::select('id', 'descripcion')->get(),
            ]);
            $this->setField([
                'name'       => 'Producto',
                'field'      => 'producto_id',
                'type'       => 'combobox',
                'collection' => Producto::select('id', 'descripcion')->get(),
            ]);
            $this->setField([
                'name'       => 'Oferta',
                'field'      => 'oferta_id',
                'type'       => 'combobox',
                'collection' => Oferta::select('id', DB::raw("CONCAT(descripcion,' ',valor)"))->get(),
            ]);

            $this->setField(['name' => 'Precio Mayoreo', 'field' => 'precio_mayoreo', 'editable' => true]);
            $this->setField(['name' => 'Precio Supermercado', 'field' => 'precio_supermercado', 'editable' => true]);
            $this->setField(['name' => 'Oferta', 'field' => 'oferta.descripcion', 'editable' => false]);
            $this->setField(['name' => 'Porcentaje de Oferta', 'field' => 'oferta.valor', 'editable' => false]);

            return $next($request);
        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'productos.precios');
    }
}