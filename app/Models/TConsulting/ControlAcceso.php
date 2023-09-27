<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ControlAcceso extends Model
{
    use HasFactory;
    protected $guarded = ['id'];
    public $timestamps = false;

    public function sucursales()
    {
        return $this->hasOne(Sucursal::class, 'id', 'sucursal_id');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function series()
    {
        return $this->hasOne(Serie::class, 'id', 'serie_id');
    }
}
