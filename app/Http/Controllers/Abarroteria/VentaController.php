<?php

namespace App\Http\Controllers\Abarroteria;

use App\Http\Controllers\Controller;
use App\Models\Bodegas\Bodega;
use App\Models\Bodegas\BodegaUsuario;
use App\Models\Bodegas\InventarioDetalle;
use App\Models\TConsulting\DescuentoEmpleado;
use App\Models\TConsulting\Empleado;
use App\Models\TConsulting\TipoPago;
use App\Models\Ventas\DisponibleEmpleado;
use App\Models\Ventas\Venta;
use App\Models\Ventas\VentaDetalle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VentaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('component')
            ->with('component', 'ventas-venta');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $datos = $request->form;

        $detalles = $datos['detalles'];
        $total = 0;
        $fecha = now()->format('Y-m-d');
        $user = auth()->user()->id;

        // $disponible = self::disponible($datos['cue']);

        // if ($datos['pago']['id'] == 1 && $disponible < $datos['total']) {
        //     abort(404, "El empleado no cuenta con el monto suficiente pera efectura la ventana");
        // }

        DB::beginTransaction();

        try {

            $venta = new Venta;
            $venta->cue_autoriza = auth()->user()->cue;
            $venta->cue_solicita = $datos['solicita']['cue'];
            $venta->bodega_id = $datos['bodega']['id'];
            $venta->tipo_pago_id = $datos['pago']['id'];
            $venta->estado = $datos['estado'];
            $venta->fecha = $fecha;
            $venta->save();

            foreach ($detalles as $detalle) {
                $vd = new VentaDetalle;
                $vd->venta_id = $venta->id;
                $vd->producto_id = $detalle['producto']['id'];
                $vd->precio = $detalle['producto']['precio'];
                $vd->cantidad = $detalle['cantidad'];
                $vd->total = ($detalle['producto']['precio'] * $detalle['cantidad']);
                $vd->estado = $datos['estado'];
                $vd->save();
                $total += $vd->total;

                $inventario = InventarioDetalle::where('inventario_id', $datos['bodega']['inventario_id'])
                    ->where('producto_id', $detalle['producto']['id'])
                    ->first();

                if ($datos['estado'] === 'GRABADO') {
                    $inventario->existencia = ($inventario->existencia - $detalle['cantidad']);
                } else {
                    $inventario->existencia = ($inventario->existencia + $total);
                }
                $inventario->save();
            }

            if ($datos['pago']['id'] == 4) {
                $disponible = self::disponible($venta->cue_solicita);

                $descuento = new DescuentoEmpleado;
                $descuento->cue = $venta->cue_solicita;
                if ($datos['estado'] === 'GRABADO') {
                    $descuento->estado = 'PENDIENTE';
                    $descuento->monto = $total;

                    $disponible->monto_restante = ($disponible->monto_restante - $total);
                } else {
                    $descuento->estado = $datos['estado'];
                    $descuento->monto = ($total * -1);

                    $disponible->monto_restante = ($disponible->monto_restante + $total);
                }
                $descuento->tipo_descuento_id = 1;
                $descuento->fecha = $fecha;
                $descuento->user_id = $user;
                $descuento->save();

                $disponible->save();

            }

            DB::commit();
        } catch (\Throwable $th) {
            throw $th;
            DB::rollBack();
        }

        $data = [
            'estado' => 'REALIZADO',
            'banderaAnulado' => $venta->estado == 'ANULADO' ? true : false,
        ];

        return response()->json($data);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function detail($datos)
    {
        $datos = json_decode($datos);

        switch ($datos->opcion) {
            case 'disponibleEmpleado':
                $disponible = self::disponible($datos->cue);
                if (!$disponible) {
                    abort(403, "Empleado sin monto disponible, favor de comunicarse con Sistemas...");
                }
                return response()->json($disponible->monto);
                break;
            case 'existenciaProducto':
                $existecia = InventarioDetalle::with('producto')
                    ->where('inventario_id', $datos->inventarioId)
                    ->where('producto_id', $datos->productoId)
                    ->get()
                    ->map(function ($query) {
                        return [
                            'id' => $query->producto->id,
                            'descripcion' => $query->producto->descripcion,
                            'precio' => $query->producto->precio,
                            'existencias' => $query->existencia,
                        ];
                    });

                if (count($existecia) == 0) {
                    abort(403, "Codigo no existe para producto, favor de revisar...");
                }

                if (intval($existecia[0]['existencias']) === 0) {
                    abort(403, "Producto sin existencia en bodega, favor de revisar...");
                }
                return response()->json($existecia);
                break;
            default: //datos iniciales
                $tipoPagos = TipoPago::all();
                $empleados = Empleado::query()->select('cue', 'nombre1', 'nombre2', 'nombre3', 'apellido1', 'apellido2', 'apellido3')
                //->where('empresa_id', auth()->user()->empresa_id)
                    ->where('activo', 1)
                    ->get();
                $bodega = BodegaUsuario::with('bodega')
                    ->where('user_id', auth()->user()->id)
                    ->first();

                $data = [
                    'tipoPagos' => $tipoPagos,
                    'empleados' => $empleados,
                    'bodega' => $bodega->bodega,
                ];
                return response()->json($data);
                break;
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public static function disponible($cue)
    {
        $disponible = DisponibleEmpleado::where('cue', $cue)->first();

        return $disponible;
    }
}
