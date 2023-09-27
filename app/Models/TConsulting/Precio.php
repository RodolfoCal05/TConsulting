<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Precio extends Model
{
    use HasFactory;
    protected $guarded = ['id'];
    public $timestamps = false;

    public function sucursal()
    {
        return $this->hasOne(Sucursal::class, 'id', 'sucursal_id');
    }

    public function producto()
    {
        return $this->hasOne(Producto::class, 'id', 'producto_id');
    }

    public function oferta()
    {
        return $this->hasOne(Oferta::class, 'id', 'oferta_id');
    }
}