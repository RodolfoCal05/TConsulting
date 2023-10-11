<?php

namespace App\Models\TConsulting;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FamiliaEmpleado extends Model
{
    //protected $connection = 'tconsulting';
    protected $table = 'familia_empleados';
    protected $guarded = ['id'];
    protected $appends = ['nombre_completo'];

    public function getNombreCompletoAttribute(){
        return $this->nombre1.' '. $this->nombre2.' '. $this->nombre3.' '. $this->apellido1.' '. $this->apellido2.' '. $this->apellido3;
    }

    public function tipoFamilia(){
        return $this->hasOne(TipoFamilia::class, 'id', 'tipo_familia_id');
    }

    public function estadoCivil(){
        return $this->hasOne(EstadoCivil::class, 'id','estado_civil');
    }

    public function genero(){
        return $this->hasOne(Genero::class, 'id','genero');
    }
}
