<?php

namespace App\Http\Controllers\Rrhh;

use App\Http\Controllers\Controller;
use App\Models\TConsulting\Ascenso;
use App\Models\TConsulting\Empleado;
use App\Models\Tconsulting\Empresa;
use App\Models\TConsulting\EstadoCivil;
use App\Models\TConsulting\FamiliaEmpleado;
use App\Models\TConsulting\Genero;
use App\Models\TConsulting\Puesto;
use App\Models\TConsulting\Sueldo;
use App\Models\TConsulting\TipoFamilia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EmpleadosController extends Controller
{
    public function index()
    {
        return view('component')
            ->with('component', 'rrhh-empleados');
    }

    public function detail($datos)
    {
        $datos = json_decode($datos);

        switch ($datos->opcion) {
            case 'empleados':

                $empleados = Empleado::with('empresa')
                    ->with('puesto')
                    ->with('sueldo')
                    ->with('familias.estadoCivil')
                    ->with('familias.genero')
                    ->with('familias.tipoFamilia')
                    ->with('estadoCivil')
                    ->with('genero')
                    ->get();
                    // ->map(function ($query) {
                    //     return [
                    //         'cue' => $query->cue,
                    //         'nombre1' => $query->nombre1,
                    //         'nombre2' => $query->nombre2,
                    //         'nombre3' => $query->nombre3,
                    //         'apellido1' => $query->apellido1,
                    //         'apellido2' => $query->apellido2,
                    //         'apellido3' => $query->apellido3,
                    //         'dpi' => $query->dpi,
                    //         'genero' => [
                    //             'eleccion' => $query->genero == 'Hombre' ? $query->genero : 'Mujer',
                    //         ],
                    //         'fecha_nacimiento' => $query->fecha_nacimiento,
                    //         'direccion' => $query->direccion,
                    //         'celular' => $query->celular,
                    //         'telefono' => $query->telefono,
                    //         'estado_civil' => [
                    //             'eleccion' => $query->estado_civil == 'Casado' ? $query->estado_civil : 'Soltero',
                    //         ],
                    //         'puesto' => $query->puesto,
                    //         'sueldo' => $query->sueldo,
                    //         'correo' => $query->correo,
                    //         'activo' => $query->activo,
                    //         'observacion' => null,
                    //         'familia' => $query->familia,
                    //         'empresa' => $query->empresa,
                    //     ];
                    // });

                return response()->json($empleados);
                break;
            case 'sueldos':
                $sueldos = Sueldo::where('puesto_id', $datos->id)
                    ->where('activo', 1)
                    ->get();
                return response()->json($sueldos);
                break;

            default: //Datos de inicio
                $data = [
                    'puestos' => Puesto::all(),
                    'tipoFamilias' => TipoFamilia::all(),
                    'empresas' => Empresa::all(),
                    'estadosCivil' => EstadoCivil::all(),
                    'generos' => Genero::all(),
                ];

                return response()->json($data);
                break;
        }

    }

    public function store(Request $request)
    {
        $rules = [
            'form.empresa' => 'required',
            'form.nombre1' => 'required',
            'form.apellido1' => 'required',
            'form.apellido2' => 'required',
            'form.dpi' => 'required',
            'form.fecha_nacimiento' => 'required',
            'form.direccion' => 'required',
            'form.celular' => 'required',
            'form.genero' => 'required',
            'form.estado_civil' => 'required',
            'form.puesto' => 'required',
            'form.sueldo' => 'required',
        ];

        $request->validate($rules);

        $datos = $request->form;
        $familias = $datos['familias'];
        $bandera = true;
        $empleado = new Empleado;
        $ascenso = new Ascenso;

        if ($datos['cue'] !== null) {
            $empleado = Empleado::where('cue',$datos['cue'])->first();
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
            $empleado->genero = $datos['genero']['id'];
            $empleado->fecha_nacimiento = $datos['fecha_nacimiento'];
            $empleado->direccion = $datos['direccion'];
            $empleado->celular = $datos['celular'];
            $empleado->telefono = $datos['telefono'];
            $empleado->estado_civil = $datos['estado_civil']['id'];
            $empleado->correo = $datos['correo'];
            $empleado->user_id = auth()->user()->id;
            $empleado->puesto_id = $datos['puesto']['id'];
            $empleado->sueldo_id = $datos['sueldo']['id'];
            $empleado->empresa_id = $datos['empresa']['id'];
            $empleado->activo = $datos['activo'];
            $empleado->save();

            if ($bandera) {
                self::ascensos($ascenso, $empleado->cue, $empleado->puesto_id, $empleado->sueldo_id, 'Contratacion');
            }
            if ($empleado->sueldo_id != $ascenso->sueldo_id) {
                $ascenso = new Ascenso;
                self::ascensos($ascenso, $empleado->cue, $empleado->puesto_id, $empleado->sueldo_id, $datos['observacion']);
            }

            foreach ($familias as $familia) {
                $fam = new FamiliaEmpleado;
                if ($familia['id'] != null) {
                    $fam = FamiliaEmpleado::findOrFail($familia['id']);
                }
                //$fam = FamiliaEmpleado::firstOrNew('id', $familia['id']);

                $fam->nombre1 = $familia['nombre1'];
                $fam->nombre2 = $familia['nombre2'];
                $fam->nombre3 = $familia['nombre3'];
                $fam->apellido1 = $familia['apellido1'];
                $fam->apellido2 = $familia['apellido2'];
                $fam->apellido3 = $familia['apellido3'];
                $fam->dpi = $familia['dpi'];
                $fam->genero = $familia['genero']['id'];
                $fam->fecha_nacimiento = $familia['fecha_nacimiento'];
                $fam->direccion = $familia['direccion'];
                $fam->celular = $familia['celular'];
                $fam->telefono = $familia['telefono'];
                $fam->estado_civil = $familia['estado_civil']['id'];
                $fam->correo = $familia['correo'];
                $fam->user_id = auth()->user()->id;
                $fam->tipo_familia_id = $familia['tipo_familia']['id'];
                $fam->empleado_cue = $empleado->cue;
                $fam->save();
            }
            DB::commit();

        } catch (\Throwable $th) {
            DB::rollBack();
            //throw $th;
        }
        $registroEmp = Empleado::with('empresa')
                    ->with('puesto')
                    ->with('sueldo')
                    ->with('familias.estadoCivil')
                    ->with('familias.genero')
                    ->with('familias.tipoFamilia')
                    ->with('estadoCivil')
                    ->with('genero')
                    ->where('cue', $empleado->cue)
                    ->get();
        return response()->json($registroEmp);
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
