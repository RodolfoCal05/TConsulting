<?php

namespace App\Models\Planillas;

use App\Models\TConsulting\Empleado;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanillaEmpleado extends Model
{
    protected $table = 'planilla_empleados';
    protected $primaryKey = 'id';
    //protected $guarded = ['id'];
    public $timestamps = true;


    public function empleado(){
        return $this->hasOne(Empleado::class, 'cue', 'cue');
    }

    public function planilla(){
        return $this->hasOne(Planilla::class, 'id', 'planilla_id');
    }
}
