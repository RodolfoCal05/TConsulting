<?php

namespace App\Models\Bodegas;

use App\Models\TConsulting\Inventario;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bodega extends Model
{
    use HasFactory;

    public function inventario(){
        return $this->hasOne(Inventario::class, 'id', 'inventario_id');
    }

    public function detalle(){
        return $this->hasOne(InventarioDetalle::class, 'inventario_id', 'inventario_id');
    }
}
