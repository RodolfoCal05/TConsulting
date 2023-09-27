<?php

namespace App\Models\CincoCalles;

use App\Models\Auth\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gestion extends Model
{
    use HasFactory;
    protected $table = 'gestiones';

    public function detalles()
    {
        return $this->hasMany(GestionDetalle::class, 'gestion_id', 'id');
    }

    public function serie()
    {
        return $this->hasOne(Serie::class, 'id', 'serie_id');
    }

    public function sucursal_origen()
    {
        return $this->hasOne(Sucursal::class, 'id', 'origen');
    }

    public function sucursal_destino()
    {
        return $this->hasOne(Sucursal::class, 'id', 'destino');
    }

    public function socio()
    {
        return $this->hasOne(Socio::class, 'id', 'socio_id');
    }

    public function tipopago()
    {
        return $this->hasOne(TipoPago::class, 'id', 'tipo_pago_id');
    }

    public function usuario()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }
}