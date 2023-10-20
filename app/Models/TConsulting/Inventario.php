<?php

namespace App\Models\TConsulting;

use App\Models\Bodegas\InventarioDetalle;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inventario extends Model
{
    use HasFactory;
    protected $guarded = ['id'];

    public function detalle(){
        return $this->hasOne(InventarioDetalle::class, 'inventario_id', 'id');
    }

    public function sucursal()
    {
        return $this->hasOne(Sucursal::class, 'id', 'sucursal_id');
    }

    public function lote()
    {
        return $this->hasOne(Lote::class, 'id', 'lote_id');
    }
}