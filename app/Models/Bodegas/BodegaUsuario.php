<?php

namespace App\Models\Bodegas;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BodegaUsuario extends Model
{
    use HasFactory;

    public  function bodega(){
        return $this->hasOne(Bodega::class, 'id', 'bodega_id');
    }
}
