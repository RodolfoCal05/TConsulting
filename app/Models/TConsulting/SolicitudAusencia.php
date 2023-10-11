<?php

namespace App\Models\TConsulting;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SolicitudAusencia extends Model
{
    protected $table = 'solicitud_ausencias';
    protected $guarded = ['id'];

    public function empleado(){
        return $this->hasOne(Empleado::class, 'cue', 'cue');
    }

    public function puesto(){
        return $this->hasOne(Puesto::class, 'id', 'puesto_id');
    }

    public function tipoSolicitud(){
        return $this->hasOne(TipoSolicitude::class, 'id', 'tipo_solicitud_id');
    }

    public function motivo(){
        return $this->hasOne(MotivoAusencia::class, 'id', 'motivo_ausencia_id');
    }

    public function tipoAusencia(){
        return $this->hasOne(TipoAusencia::class, 'id', 'tipo_ausencia_id');
    }
    
}
