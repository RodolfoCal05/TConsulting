<?php

namespace App\Http\Controllers\Bodegas;

use App\Models\Bodegas\Bodega;
use App\Models\Bodegas\ProduccionDiaria;
use App\Models\Bodegas\Producto;
use App\Models\TConsulting\Empleado;
use Carbon\Carbon;
use Csgt\Crud\CrudController;
use Illuminate\Support\Facades\DB;

class ProduccionDiariaController extends CrudController
{
    public function __construct()
    {
        $this->setModel(new ProduccionDiaria);
        $this->setTitle('Produccion Diaria');

        $this->setField(['name' => 'cue', 'field' => 'empleado.cue', 'editable' => false]);
        $this->setField(['name' => 'Nombre', 'field' => 'empleado.nombre1', 'editable' => false]);
        $this->setField(['name' => 'Apellido', 'field' => 'empleado.apellido1', 'editable' => false]);
        $this->setField(['name' => 'Bodega', 'field' => 'bodega.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Producto', 'field' => 'producto.descripcion', 'editable' => false]);
        $this->setField(['name' => 'Cantidad', 'field' => 'cantidad', 'editable' => true]);
        $this->setField(['name' => 'Fecha', 'field' => 'fecha', 'editable' => false]);

        $this->middleware(function ($request, $next) {
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
				'name'       => 'Bodega',
				'field'      => 'bodega_id',
				'type'       => 'combobox',
				'collection' => Bodega::query()
					->select('id', DB::raw("concat (id, ' - ', descripcion) as nombre"))
					->where('activo', 1)
					->get(),
			]);

            $this->setField([
				'name'       => 'Producto',
				'field'      => 'producto_id',
				'type'       => 'combobox',
				'collection' => Producto::query()
					->select('id', DB::raw("concat (id, ' - ', descripcion) as nombre"))
					->where('estado', 1)
					->get(),
			]);
            $this->setHidden(['field' => 'user_id', 'value' => auth()->user()->id]);
            $this->setHidden(['field' => 'fecha', 'value' => Carbon::now()->format('Y-m-d')]);

            return $next($request);

        });

        $this->setPermissions("\Cancerbero::crudPermissions", 'bodegas.produccion-diaria');

    }
}
