<?php

namespace App\Models\TConsulting;

use App\Models\Tconsulting\Empresa;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Empleado extends Model
{
    //protected $connection = 'tconsulting';
    protected $table = 'empleados';
    protected $primaryKey = 'cue';
    protected $guarded = ['cue'];
    protected $appends = ['nombre_completo'];

    public function getNombreCompletoAttribute(){
        return $this->cue.' - '. $this->nombre1.' '. $this->nombre2.' '. $this->nombre3.' '. $this->apellido1.' '. $this->apellido2.' '. $this->apellido3;
    }

    public function empresa(){
        return $this->hasOne(Empresa::class, 'id', 'empresa_id');
    }

    public function puesto(){
        return $this->hasOne(Puesto::class, 'id', 'puesto_id');
    }

    public function sueldo(){
        return $this->hasOne(Sueldo::class, 'id','sueldo_id');
    }

    public function familias(){
        return $this->hasMany(FamiliaEmpleado::class,'empleado_cue', 'cue');
    }

    public function estadoCivil(){
        return $this->hasOne(EstadoCivil::class, 'id','estado_civil');
    }

    public function genero(){
        return $this->hasOne(Genero::class, 'id','genero');
    }

    public function UltimoAscenso(){
        return $this->hasOne(Ascenso::class, 'cue','cue')->orderBy('id', 'DESC')->limit(1);
    }
}
