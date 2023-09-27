<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GestionDetalle extends Model
{
    use HasFactory;
    public $timestamps = false;

    public function producto()
    {
        return $this->hasOne(Producto::class, 'id', 'producto_id');
    }
}
