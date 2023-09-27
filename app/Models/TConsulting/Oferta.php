<?php

namespace App\Models\CincoCalles;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Oferta extends Model
{
    use HasFactory;
    protected $guarded = ['id'];
    public $timestamps = false;
}