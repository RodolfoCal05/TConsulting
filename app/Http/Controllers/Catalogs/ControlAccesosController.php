<?php

namespace App\Http\Controllers\Catalogs;

use App\Http\Controllers\Controller;
use App\Models\Auth\User;
use App\Models\TConsulting\ControlAcceso;
use App\Models\TConsulting\Serie;
use App\Models\TConsulting\Sucursal;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ControlAccesosController extends Controller
{
    public function index()
    {
        $sucursales = Sucursal::where('estado', "ACTIVO")->get();
        $series     = Serie::all();
        $users      = User::query()
            ->select('id', 'name', 'email')
            ->where('active', 1)
            ->get();

        $parms = [
            'sucursales' => $sucursales,
            'series'     => $series,
            'users'      => $users,
        ];

        return view('component')
            ->with('component', 'catalogs-control-accesos')
            ->with('params', $parms);
    }

    public function detail($id)
    {
        $datos = json_decode($id);

        switch ($datos->opcion) {
            case 'series':
                $series = ControlAcceso::query()
                    ->where('user_id', $datos->user_id)
                    ->where('sucursal_id', $datos->sucursal_id)
                    ->pluck('serie_id');

                $permisos = Serie::query()
                    ->whereIn('id', $series)
                    ->get();

                return response()->json($permisos);
                break;

            default:
                abort(404, 'Opcion Invalida');
                break;
        }
    }

    public function store(Request $request)
    {
        $rules = [
            'series'   => 'required|min:1',
            'sucursal' => 'required|min:1',
            'id'       => 'required|integer',
        ];

        $request->validate($rules);
        $series   = $request->series;
        $sucursal = $request->sucursal;
        $id       = $request->id;

        DB::transaction(function () use ($series, $sucursal, $id) {
            ControlAcceso::where('user_id', $id)
                ->where('sucursal_id', $sucursal)
                ->delete();

            foreach ($series as $serie) {
                $ca              = new ControlAcceso;
                $ca->sucursal_id = $sucursal;
                $ca->serie_id    = $serie['id'];
                $ca->user_id     = $id;
                $ca->save();
            }
        });

        return response()->json("Permisos Agregados Correctamente");
    }
}