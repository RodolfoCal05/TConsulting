<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    use HasFactory;
    protected $guarded = ['id'];

    public function precio()
    {
        return $this->hasOne(Precio::class, 'producto_id', 'id');
    }
}
