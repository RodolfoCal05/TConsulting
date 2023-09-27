<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inventario extends Model
{
    use HasFactory;
    protected $guarded = ['id'];

    public function sucursal()
    {
        return $this->hasOne(Sucursal::class, 'id', 'sucursal_id');
    }

    public function producto()
    {
        return $this->hasOne(Producto::class, 'id', 'producto_id');
    }

    public function lote()
    {
        return $this->hasOne(Lote::class, 'id', 'lote_id');
    }
}