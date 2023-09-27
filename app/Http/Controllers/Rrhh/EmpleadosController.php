<?php

namespace App\Http\Controllers\Rrhh;

use App\Http\Controllers\Controller;
use App\Models\TConsulting\Ascenso;
use App\Models\TConsulting\Empleado;
use App\Models\TConsulting\Puesto;
use App\Models\TConsulting\Sueldo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PhpParser\Node\Stmt\Return_;

class EmpleadosController extends Controller
{
    public function index()
    {
        return view('component')
            ->with('component', 'rrhh-empleados');
    }

    public function detail($id)
    {
        $opcion = json_decode($id);
        switch ($opcion) {
            case 'Empleados':
                $empleados = Empleado::with('empresa')
                    ->with('puesto')
                    ->with('sueldo')
                    ->get();
                return response()->json($empleados);
                break;
            case 'sueldos':
                $sueldos = Sueldo::all();
                return response()->json($sueldos);
                break;

            default: //Datos de inicio

                $puestos = Puesto::all();

                return response()->json($puestos);
                break;
        }

    }

    public function store(Request $request)
    {
        $datos = $request->form;

        $bandera = true;
        $empleado = new Empleado;
        $ascenso = new Ascenso;

        if ($datos['cue'] !== null) {
            $empleado = Empleado::find($datos['cue']);
            $ascenso = Ascenso::where('cue', $datos['cue'])
                ->OrderBy('id', 'DESC')
                ->first();

            $bandera = false;
        }

        DB::beginTransaction();

        try {

            $empleado->nombre1 = $datos['nombre1'];
            $empleado->nombre2 = $datos['nombre2'];
            $empleado->nombre3 = $datos['nombre3'];
            $empleado->apellido1 = $datos['apellido1'];
            $empleado->apellido2 = $datos['apellido2'];
            $empleado->apellido3 = $datos['apellido3'];
            $empleado->dpi = $datos['dpi'];
            $empleado->fecha_nacimiento = $datos['fecha_nacimiento'];
            $empleado->direccion = $datos['direccion'];
            $empleado->celular = $datos['celular'];
            $empleado->telefono = $datos['telefono'];
            $empleado->estado_civil = $datos['estado_civil'];
            $empleado->puesto_id = $datos['puesto']['id'];
            $empleado->sueldo_id = $datos['sueldo']['id'];
            $empleado->activo = $datos['activo'];
            $empleado->save();

            if ($bandera) {
                self::ascensos($ascenso, $empleado->cue, $empleado->puesto_id, $empleado->sueldo_id, 'Contratacion');
            }
            if ($empleado->sueldo_id != $ascenso->sueldo_id) {
                self::ascensos($ascenso, $empleado->cue, $empleado->puesto_id, $empleado->sueldo_id, $datos['observacion']);
            }

            DB::commit();

        } catch (\Throwable $th) {
            DB::rollBack();
            //throw $th;
        }

    }

    public function update(Request $request, $id)
    {
        dd("aqui vamos en update");
    }

    public static function ascensos($ascenso, $cue, $idpuesto, $idsueldo, $obsevacion)
    {

        $ascenso->cue = $cue;
        $ascenso->puesto_id = $idpuesto;
        $ascenso->sueldo_id = $idsueldo;
        $ascenso->observacion = $obsevacion;
        $ascenso->save();
    }

}
