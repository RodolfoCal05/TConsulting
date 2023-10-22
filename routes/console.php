<?php

/*
|--------------------------------------------------------------------------
| Console Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of your Closure based console
| commands. Each Closure is bound to a command instance allowing a
| simple approach to interacting with each command's IO methods.
|
 */

use App\Models\Auth\User;
use App\Models\Bodegas\InventarioDetalle;
use App\Models\Planillas\Plane;
use App\Models\Planillas\Planilla;
use App\Models\TConsulting\Empleado;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

Artisan::command('password', function () {
    dd(Hash::make('admin'));
});

Artisan::command('user', function () {
    $user = auth()->user()->id;
    dd($user);
});

Artisan::command('calculos', function () {
    $empleado = new Empleado;
    $empleado->nombre1 = 'Rodolfo';
    $empleado->nombre2 = 'Jonnathan';
    $empleado->nombre3 = null;
    $empleado->apellido1 = 'Cal';
    $empleado->apellido2 = 'Monzon';
    $empleado->apellido3 = null;
    $empleado->dpi = '338';
    $empleado->genero = 'Masculino';
    $empleado->fecha_nacimiento = '1998-06-05';
    $empleado->direccion = 'Mazatenango';
    $empleado->celular = '56200147';
    $empleado->telefono = null;
    $empleado->estado_civil = 'Casado';
    $empleado->correo = 'rcal@gmail.com';
    $empleado->user_id = 1;
    $empleado->puesto_id = '1';
    $empleado->sueldo_id = 1; //'';
    $empleado->empresa_id = 2;
    $empleado->activo = 1;
    $empleado->save();
});

Artisan::command('limit', function () {
    //Version 1
    // $existecia = Bodega::whereHas('detalle', function ($query) use ($datos) {
    //     $query->where('producto_id', $datos->productoId)
    //         ->where('inventario_id', $datos->inventarioId);
    // })
    //     ->with('detalle.producto')
    //     ->where('id', $datos->bodegaId)
    //     ->get()
    //     ->map(function ($query) {
    //         dd($query->detalle[0]->producto);
    //         return [
    //             'id' => $query->inventario->detalle[0]->producto->id,
    //             'descripcion' => $query->inventario->detalle[0]->producto->descripcion,
    //             'precio' => $query->inventario->detalle[0]->producto->precio,
    //             'existencias' => $query->inventario->detalle[0]->existencia,
    //         ];
    //     });

    $existecia = InventarioDetalle::with('producto')
        ->where('inventario_id', 2)
        ->where('producto_id', 2)
        ->get()
        ->map(function ($query) {
            return [
                'id' => $query->producto->id,
                'descripcion' => $query->producto->descripcion,
                'precio' => $query->producto->precio,
                'existencias' => $query->existencia,
            ];
        });
    dd($existecia);
});

Artisan::command('procedure {cue} {fecha_inicio} {fecha_fin} ', function ($cue, $fecha_inicio, $fecha_fin) {
    // $datosSueldoIgss = DB::select("CALL calculo_pago_e_igss($cue,$numero_plan)");
    // dd($datosSueldoIgss[0]->pago);
    //$descuentos = DB::select("CALL descuentos($cue, '$fecha_inicio', '$fecha_fin')");
    $comisionVentas = DB::select("CALL comision_ventas($cue, '$fecha_inicio', '$fecha_fin')");
    dd($comisionVentas[0]->comision_total);
    $datos = DB::select("CALL sueldo_por_dia($cue)");

    dd($datos[0]->sueldo_por_dia);
});

Artisan::command('between', function () {
    $fechaActual = Carbon::now()->toDateString();

    $plan = Plane::whereRaw("'$fechaActual' between `fecha_desde` and `fecha_hasta`")
        ->first();
    $planilla = Planilla::where('fecha_inicio', $plan->fecha_desde)
        ->where('fecha_fin', $plan->fecha_hasta)
        ->where('empresa_id', 1)
        ->first();
    if ($planilla) {
        dd("ya existe planilla creada");
    }
    dd("no existe planilla");
    $planilla = Planilla::with('tipo')
        ->with('empresa')
        ->whereRaw("'$fechaActual' between `fecha_inicio` and `fecha_fin`")
        ->first();
    dd($planilla);
});

Artisan::command('planilla {id}', function($id){
    Planilla::where('id', $id)->update(['estado' => 'APLICADO']);
});

