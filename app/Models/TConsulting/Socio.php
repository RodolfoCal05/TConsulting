<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Socio extends Model
{
    use HasFactory;
    protected $guarded = ['id'];
    public $timestamps = false;

    public function fidelizacion()
    {
        return $this->hasOne(Fidelizacion::class, 'id', 'fidelizacion_id');
    }

    public function tiposocio()
    {
        return $this->hasOne(TipoSocio::class, 'id', 'tipo_socio_id');
    }
}
