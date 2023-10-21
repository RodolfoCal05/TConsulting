<?php

namespace App\Http\Controllers\Planillas;

use App\Http\Controllers\Controller;
use App\Models\Planillas\Plane;
use App\Models\Planillas\Planilla;
use App\Models\Planillas\PlanillaEmpleado;
use App\Models\TConsulting\Empleado;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PlanillaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('component')
            ->with('component', 'planillas-planilla');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $fechaActual = Carbon::now()->toDateString();

        $planilla = self::getPlanPlanilla($fechaActual, auth()->user()->empresa_id);

        if (!$planilla['planilla']->isEmpty()) {
            abort(403, "Ya existe Planilla Creada");
        }

        DB::beginTransaction();
        try {
            $p = new Planilla;
            $p->fecha_inicio = $planilla['plan']['fecha_desde'];
            $p->fecha_fin = $planilla['plan']['fecha_hasta'];
            $p->tipo_planilla_id = 1;
            $p->estado = 'GRABADO';
            $p->empresa_id = auth()->user()->empresa_id;
            $p->crea_user_id = auth()->user()->id;
            $p->save();

            DB::commit();
        } catch (\Throwable $th) {
            throw $th;
            DB::rollBack();
        }

        $planilla = self::getPlanilla($p->id);

        return response()->json($planilla['planilla']);
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
            case 'planillaEmpleado':
                return response()->json();
                break;
            default: // Datos Iniciales
                $fechaActual = Carbon::now()->toDateString();
                $planilla = self::getPlanPlanilla($fechaActual, auth()->user()->empresa_id);
                $planillaEmpleados = [];
                
                if (!$planilla['planilla']->isEmpty()) {
                    $planillaEmpleados = self::getPlanillaEmpleados($planilla['planilla'][0]->id, auth()->user()->empresa_id);
                }
                $data = [
                    'planilla' => $planilla['planilla'],
                    'planillaEmpleados' => $planillaEmpleados,
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
        $datos = $request;
        $fechaActual = Carbon::now()->toDateString();

        $empleados = Empleado::where('empresa_id', auth()->user()->empresa_id)
            ->where('activo', 1)
            ->pluck('cue');

        $planPlanilla = self::getPlanPlanilla($fechaActual, auth()->user()->empresa_id);

        $plan = $planPlanilla['plan'];
        $planilla = $planPlanilla['planilla'][0];

        if ($planilla->estado === 'APLICADO') {
            abort(403, "Planilla ya Calculada...");
        }

        DB::beginTransaction();
        $contador = 0;
        try {
            foreach ($empleados as $cue) {
                $datosSueldoIgss = DB::select("CALL calculo_pago_e_igss($cue, $plan->numero_plan)");
                $descuentos = DB::select("CALL descuentos($cue, '$planilla->fecha_inicio', '$planilla->fecha_fin')");
                $comisionVentas = DB::select("CALL comision_ventas($cue, '$planilla->fecha_inicio', '$planilla->fecha_fin')");

                $pago = $datosSueldoIgss[0]->pago;
                $igss = $datosSueldoIgss[0]->cuota_igss;
                $descuento = $descuentos[0]->descuento_total == null ? 0 : $descuentos[0]->descuento_total;
                $comision = count($comisionVentas) == 0 ? 0 : $comisionVentas[0]->comision_total;
                // if ($contador>0) {
                //     dd($cue.'  - sueldo: '. $pago.' -  comision: '. $comision . ' - descuento: '.$descuento);
                // }
                $liquido = (($pago + $comision) - ($igss + $descuento));

                $planillaEmp = new PlanillaEmpleado;
                $planillaEmp->cue = $cue;
                $planillaEmp->liquido = $liquido;
                $planillaEmp->dias_laborados = 15;
                $planillaEmp->planilla_id = $planilla->id;
                $planillaEmp->empresa_id = auth()->user()->empresa_id;
                $planillaEmp->user_id = auth()->user()->id;
                $planillaEmp->save();
                $contador++;
            }

            Planilla::where('id', $planilla->id)->update(['estado' => 'APLICADO']);

            DB::commit();
        } catch (\Throwable $th) {
            throw $th;
            DB::rollBack();
        }

        // // Realizar la consulta inicial
        // $datos = DB::select('CALL sueldo_por_dia(?)', [$cue]);

        // // Agregar un nuevo elemento al final del array
        // nuevoElemento = ["clave" => "valor"]; // Define tu nuevo elemento como un array asociativo o indexado según tus necesidades
        // array_push($datos, $nuevoElemento);
        return response()->json(self::getPlanillaEmpleados($planilla->id, auth()->user()->empresa_id));
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

    public static function getPlanPlanilla($fechaActual, $empresa_id)
    {
        $plan = Plane::whereRaw("'$fechaActual' between `fecha_desde` and `fecha_hasta`")
            ->first();

        $planilla = Planilla::with('tipo')
            ->with('empresa')
            ->where('fecha_inicio', $plan->fecha_desde)
            ->where('fecha_fin', $plan->fecha_hasta)
            ->where('empresa_id', $empresa_id)
            ->get();

        return $data = [
            'plan' => $plan,
            'planilla' => $planilla,
        ];
    }

    public static function getPlanilla($idPlanilla)
    {
        $planilla = Planilla::with('tipo')
            ->with('empresa')
            ->findOrFail($idPlanilla);

        return $planilla;
    }

    public static function getPlanillaEmpleados($idPlanilla, $empresa_id)
    {
        $planilla = PlanillaEmpleado::with('empleado')
            ->with('planilla')
            ->where('planilla_id', $idPlanilla)
            ->where('empresa_id', $empresa_id)
            ->get();
        return $planilla;
    }
}
