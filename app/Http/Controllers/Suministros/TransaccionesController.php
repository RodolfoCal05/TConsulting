<?php

namespace App\Http\Controllers\Suministros;

use App\Http\Controllers\Controller;
use App\Models\CincoCalles\ControlAcceso;
use App\Models\CincoCalles\Gestion;
use App\Models\CincoCalles\Sucursal;
use Illuminate\Http\Request;

class TransaccionesController extends Controller
{
    public function index()
    {
        $permisos   = ControlAcceso::where('user_id', auth()->user()->id)->pluck('sucursal_id');
        $sucursales = Sucursal::whereIn('id', $permisos)->get();

        $params = [
            'sucursales' => $sucursales,
        ];

        return view('component')
            ->with('component', 'suministros-transacciones')
            ->with('params', $params);
    }

    public function data(Request $request)
    {
        if (!$request->sucursal_id) {
            abort(404, 'Seleccione una Sucursal');
        }

        $gestiones = Gestion::with(['serie', 'sucursal_origen', 'sucursal_destino', 'socio.fidelizacion', 'tipopago', 'usuario'])
            ->where('origen', $request->sucursal_id)
            ->orWhere('destino', $request->sucursal_id)
            ->orderBy('id', 'desc')
            ->limit($request->cantidad)
            ->get();

        return response()->json($gestiones);
    }
}