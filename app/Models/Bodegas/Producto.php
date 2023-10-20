<?php

namespace App\Models\Bodegas;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    use HasFactory;
    protected $table = 'productos';
    protected $guarded = ['id'];

    public function precio()
    {
        return $this->hasOne(Precio::class, 'producto_id', 'id');
    }
}
