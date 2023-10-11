<?php

namespace App\Models\TConsulting;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sucursal extends Model
{
    use HasFactory;
    protected $table   = 'sucursales';
    protected $guarded = ['id'];
    public $timestamps = false;

    public function tiposede()
    {
        return $this->hasOne(TipoSede::class, 'id', 'tipo_sede_id');
    }
}