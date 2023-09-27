<?php

namespace App\Models\TConsulting;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Fidelizacion extends Model
{
    use HasFactory;
    protected $table    = 'fidelizaciones';
    protected $guarderd = ['id'];
}
