<?php

namespace App\Http\Controllers\Suministros;

use App\Http\Controllers\Controller;
use App\Models\CincoCalles\ControlAcceso;
use App\Models\CincoCalles\Gestion;
use App\Models\CincoCalles\GestionDetalle;
use App\Models\CincoCalles\Inventario;
use App\Models\CincoCalles\Precio;
use App\Models\CincoCalles\Serie;
use App\Models\CincoCalles\Socio;
use App\Models\CincoCalles\Sucursal;
use App\Models\CincoCalles\TipoPago;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class GestionesController extends Controller
{
    public function index()
    {
        return $this->edit(0);
    }

    public function edit($id)
    {
        $params = [
            'id' => $id,
        ];

        return view('component')
            ->with('component', 'suministros-gestiones')
            ->with('params', $params);
    }

    public function detail(Request $request, $id)
    {
        $datos = json_decode($id);

        switch ($datos->opcion) {
            case 'series':
                $permisos = ControlAcceso::query()
                    ->where('user_id', auth()->user()->id)
                    ->where('sucursal_id', $datos->sucursal_id)
                    ->pluck('serie_id');

                $series = Serie::whereIn('id', $permisos)->get();

                return response()->json($series);
                break;
            case 'nuevaGestion':
                return self::nuevaGestion($datos);
                break;
            case 'buscarProducto':
                return response()->json(self::buscarProducto($datos));
                break;
            case 'finalizar':
                return response()->json(self::finalizar($datos));
                break;
            default:
                abort(404, 'Opcion Invalida');
                break;
        }
    }

    public function store(Request $request)
    {
        $rules = [
            'gestion.id'               => 'required',
            'gestion.serie'            => 'required',
            'gestion.sucursal_origen'  => 'required',
            'gestion.sucursal_destino' => 'required',
            'gestion.fecha'            => 'required',
            'gestion.detalles'         => 'required|min:1',
        ];

        $request->validate($rules);
        $gestion = $request->gestion;

        $gestionReturn = DB::transaction(function () use ($gestion) {
            $g = new Gestion;

            if ($gestion['id'] != 0) {
                $g = Gestion::findOrFail($gestion['id']);
                GestionDetalle::query()->where('gestion_id', $gestion['id'])->delete();
            }

            $g->fecha         = $gestion['fecha'];
            $g->serie_id      = $gestion['serie']['id'];
            $g->origen        = $gestion['sucursal_origen']['id'];
            $g->destino       = $gestion['sucursal_destino']['id'];
            $g->socio_id      = is_null($gestion['socio']) ? 1 : $gestion['socio']['id'];
            $g->tipo_pago_id  = is_null($gestion['tipopago']) ? 1 : $gestion['tipopago']['id'];
            $g->user_id       = auth()->user()->id;
            $g->estado        = $gestion['estado'];
            $g->observaciones = $gestion['observaciones'];
            $g->save();

            $esVenta     = $this->validarVenta($gestion);
            $noEsMayoreo = $this->validarSede($gestion);

            if ($esVenta) {
                $descuentoSocio = $this->validarDescuento($gestion);
            }

            foreach ($gestion['detalles'] as $detalle) {
                $precio    = 0;
                $costo     = 0;
                $descuento = 0;
                $precio    = $detalle['producto']['precio']['precio_mayoreo'];
                $costo     = $precio;

                if ($noEsMayoreo) {
                    $precio = $detalle['producto']['precio']['precio_supermercado'];
                    $costo  = $precio;
                }

                if ($esVenta) {
                    $descuento = $detalle['producto']['precio']['oferta']['valor'] * $precio;
                    $costo     = $precio - $descuento;

                    if ($descuentoSocio) {
                        $fidelizacion = $gestion['socio']['fidelizacion']['valor'];
                        $descuento    = $fidelizacion;
                        $costo        = $precio - ($precio * $descuento);
                    }
                }

                $gd              = new GestionDetalle;
                $gd->gestion_id  = $g->id;
                $gd->producto_id = $detalle['producto']['id'];
                $gd->cantidad    = $detalle['cantidad'];
                $gd->costo       = $costo;
                $gd->descuento   = $descuento;
                $gd->monto       = $costo * $detalle['cantidad'];
                $gd->estado      = 'SOLICITADO';
                $gd->save();
            }

            return $g->id;
        });

        return response()->json(self::gestion($gestionReturn));
    }

    public static function finalizar($datos)
    {
        $estado   = 'FINALIZADO';
        $sucursal = $datos->origen;

        if ($datos->serie_id == 2) {
            $estado = 'ENVIADO';
            if ($datos->estado == 'ENVIADO') {
                $sucursal = $datos->destino;
                $estado   = 'RECIBIDO';
            }
        }

        $g          = Gestion::findOrFail($datos->id);
        $g->estado  = $estado;
        $g->user_id = auth()->user()->id;
        $g->save();

        GestionDetalle::query()
            ->where('gestion_id', $datos->id)
            ->update([
                'estado' => $estado,
            ]);

        foreach ($datos->detalles as $detalle) {
            $stock = Inventario::query()
                ->select('existencias')
                ->where('sucursal_id', $sucursal)
                ->where('producto_id', $detalle->producto_id)
                ->first();

            if ($datos->serie_id == 2 && $estado == 'RECIBIDO') {
                $existencia = 0;
                if (!$stock) {
                    $existencia = $detalle->cantidad;
                } else {
                    $existencia = ($stock->existencias + $detalle->cantidad);
                }
            } else {
                $existencia = ($stock->existencias - $detalle->cantidad);
            }

            $inv = Inventario::firstOrNew([
                'sucursal_id' => $sucursal,
                'producto_id' => $detalle->producto_id,
            ]);
            if (!$inv->exists) {
                $inv->lote_id = 1;
            }
            $inv->existencias = $existencia;
            $inv->save();
        }

        return self::gestion($datos->id);
    }

    public static function nuevaGestion($datos)
    {
        $permisos   = ControlAcceso::where('user_id', auth()->user()->id)->pluck('sucursal_id');
        $sucursales = Sucursal::whereIn('id', $permisos)->get();
        $socios     = Socio::with('fidelizacion')->get();
        $tipoPagos  = TipoPago::all();

        $gestion = [
            'id'               => 0,
            'fecha'            => Carbon::now()->format('Y-m-d'),
            'serie'            => null,
            'tipopago'         => null,
            'sucursal_origen'  => [],
            'sucursal_destino' => [],
            'socio'            => null,
            'user_id'          => auth()->user()->id,
            'estado'           => "SOLICITADO",
            'observaciones'    => null,
            'detalles'         => [],
        ];

        if ($datos->id != '0') {
            $gestion = self::gestion($datos->id);
        }

        $data = [
            'gestion'    => $gestion,
            'sucursales' => $sucursales,
            'socios'     => $socios,
            'tipoPagos'  => $tipoPagos,
        ];

        return response()->json($data);
    }

    public static function buscarProducto($datos)
    {
        $producto = Inventario::query()
            ->with(['producto.precio' => function ($q) use ($datos) {
                $q->where('sucursal_id', $datos->sucursal_id);
            }])
            ->with(['lote', 'producto.precio.oferta'])
            ->where('sucursal_id', $datos->sucursal_id)
            ->where('producto_id', $datos->producto_id)
            ->first();

        if (!$producto && $datos->serie_id != 3) {
            abort(404, 'Producto no existe en inventario');
        }

        if (!$producto->lote && $datos->serie_id != 3) {
            abort(404, 'Producto sin Lote, asigneselos');
        }

        if (!$producto->producto->precio && $datos->serie_id != 3) {
            abort(404, 'Producto no tiene precio');
        }

        return $producto;
    }

    public static function gestion($id)
    {
        $sucursal = Gestion::select('origen')->findOrFail($id);
        $gestion  = Gestion::with(['detalles.producto.precio' => function ($q) use ($sucursal) {
            $q->where('sucursal_id', $sucursal->origen);
        }])
            ->with(['serie', 'sucursal_origen', 'sucursal_destino', 'socio.fidelizacion', 'tipopago', 'detalles.producto.precio.oferta'])
            ->findOrFail($id);

        return $gestion;
    }

    public function validarVenta($gestion): bool
    {
        return $gestion['serie']['id'] == 1;
    }

    public function validarSede($gestion)
    {
        return $gestion['sucursal_origen']['tipo_sede_id'] != 2;
    }

    public function validarDescuento($gestion)
    {
        return $gestion['socio']['fidelizacion_id'] != 4;
    }
}