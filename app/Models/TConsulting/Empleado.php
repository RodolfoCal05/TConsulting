<?php

namespace App\Models\TConsulting;

use App\Models\Tconsulting\Empresa;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Empleado extends Model
{
    use HasFactory;

    public function empresa(){
        return $this->hasOne(Empresa::class, 'id', 'empresa_id');
    }

    public function puesto(){
        return $this->hasOne(Puesto::class, 'id', 'puesto_id');
    }

    public function sueldo(){
        return $this->hasOne(Sueldo::class, 'id','sueldo_id');
    }
}
