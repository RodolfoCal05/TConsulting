<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lote extends Model
{
    use HasFactory;
    protected $guarded = ['id'];
    public $timestamps = false;
}