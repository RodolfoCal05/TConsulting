<?php

namespace App\Models\Bodegas;

use App\Models\TConsulting\Empleado;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProduccionDiaria extends Model
{
    protected $table = 'produccion_diaria';
    protected $guarded = ['id'];
    public $timestamps = false;

    public function empleado(){
        return $this->hasOne(Empleado::class, 'cue', 'cue');
    }

    public function bodega(){
        return $this->hasOne(Bodega::class, 'id', 'bodega_id');
    }
    
    public function producto(){
        return $this->hasOne(producto::class, 'id', 'producto_id');
    }
}
